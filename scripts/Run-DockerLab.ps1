[CmdletBinding()]
param(
    [switch]$KeepWeb,
    [int]$Port = 18881,
    [int]$SecondPort = 18882,
    [int]$ExperimentPort = 18883
)
$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false
$taskRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $taskRoot
$runId = 'codyssey-m1-' + (Get-Date -Format 'yyyyMMddHHmmss')
$image = "codyssey-workstation:$runId"
$labRoot = Join-Path $taskRoot '.lab'
$evidenceRoot = Join-Path $taskRoot 'evidence'
New-Item -ItemType Directory -Force -Path $labRoot,$evidenceRoot | Out-Null
$logPath = Join-Path $evidenceRoot '03-docker-lab.md'
Set-Content -LiteralPath $logPath -Encoding utf8 -Value "# Docker 실제 실행 기록`n`n실행자: 소유자의 요청을 받은 Codex.`n`nUTC: $([DateTime]::UtcNow.ToString('o'))`n"
$created = [System.Collections.Generic.List[string]]::new()
$webNames = [System.Collections.Generic.List[string]]::new()
$volumeName = "$runId-data"
$volumeCreated = $false
$success = $false
function Run-Lab {
    param([string]$Title, [string[]]$Command, [int[]]$AllowedExit = @(0))
    $executable = $Command[0]
    [string[]]$nativeArguments = @($Command | Select-Object -Skip 1)
    $display = ($Command | ForEach-Object { if ($_ -match '[\s"'']') { "'" + ($_ -replace "'", "''") + "'" } else { $_ } }) -join ' '
    $nativeOutput = & $executable @nativeArguments 2>&1 | Out-String
    $nativeExit = $LASTEXITCODE
    Add-Content -LiteralPath $logPath -Encoding utf8 -Value ("`n## $Title`n`n``````text`n> $display`n$nativeOutput[exit $nativeExit]`n```````n")
    Write-Host "$Title : exit $nativeExit"
    if ($nativeExit -notin $AllowedExit) { throw "$Title failed with exit $nativeExit. See $logPath" }
    return $nativeOutput.Trim()
}
function New-LabContainer {
    param([string]$Name, [string[]]$Options, [string]$ContainerImage, [string[]]$ContainerCommand = @())
    if (& docker ps -a --filter "name=^/$Name`$" --format '{{.Names}}') { throw "Container name already exists: $Name" }
    $result = Run-Lab "컨테이너 생성 $Name" (@('docker','run','--name',$Name,'--label',"codyssey.run=$runId",'--memory','128m','--cpus','0.5') + $Options + @($ContainerImage) + $ContainerCommand)
    $created.Add($Name)
    return $result
}
function Remove-LabContainer {
    param([string]$Name)
    $label = & docker inspect --format '{{index .Config.Labels "codyssey.run"}}' $Name 2>$null
    if ($LASTEXITCODE -eq 0 -and $label -eq $runId) { $null = Run-Lab "작업 컨테이너 삭제 $Name" @('docker','rm','-f',$Name) }
}
try {
    $listeningPorts = @([System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties().GetActiveTcpListeners().Port)
    foreach ($hostPort in @($Port,$SecondPort,$ExperimentPort)) {
        if ($hostPort -in $listeningPorts) { throw "Port $hostPort is occupied. Choose a free port parameter." }
    }
    $null = Run-Lab 'Docker 버전' @('docker','--version')
    $null = Run-Lab 'Docker 엔진 점검' @('docker','info','--format','Engine={{.ServerVersion}} OS={{.OperatingSystem}} Kernel={{.KernelVersion}}')
    foreach ($baseImage in @('hello-world:latest','ubuntu:24.04','nginx:alpine')) {
        $null = Run-Lab "공식 이미지 받기 $baseImage" @('docker','pull',$baseImage)
        $null = Run-Lab "이미지 목록 $baseImage" @('docker','images',$baseImage)
        $null = Run-Lab "이미지 식별 $baseImage" @('docker','image','inspect','--format','ID={{.Id}} Digests={{json .RepoDigests}}',$baseImage)
    }
    $hello = "$runId-hello"
    $helloOutput = New-LabContainer $hello @() 'hello-world:latest'
    if ($helloOutput -notmatch 'Hello from Docker!') { throw 'hello-world success text missing' }
    $ubuntu = "$runId-ubuntu"
    $null = New-LabContainer $ubuntu @('-dit') 'ubuntu:24.04' @('bash')
    $null = Run-Lab 'Ubuntu 내부 명령' @('docker','exec',$ubuntu,'bash','-lc','echo inside-ubuntu; pwd; ls /; echo process-alive')
    $null = Run-Lab 'exec의 셸만 종료' @('docker','exec',$ubuntu,'bash','-lc','echo exec-session-finished; exit 0')
    $execState = Run-Lab 'exec 후 PID 1 유지 확인' @('docker','inspect','--format','{{.State.Running}}',$ubuntu)
    if ($execState -ne 'true') { throw 'exec unexpectedly stopped the container' }
    $attached = "$runId-attach"
    $null = New-LabContainer $attached @('-d') 'ubuntu:24.04' @('sh','-c','sleep 2; echo main-process-finished')
    $null = Run-Lab 'attach로 주 프로세스 출력 관찰' @('docker','attach',$attached)
    $attachState = Run-Lab '주 프로세스 종료 상태' @('docker','inspect','--format','{{.State.Status}} exit={{.State.ExitCode}}',$attached)
    if ($attachState -ne 'exited exit=0') { throw 'attach experiment did not finish normally' }
    $null = Run-Lab 'Dockerfile 빌드' @('docker','build','--progress','plain','-t',$image,'.')
    $web = "$runId-web"
    $null = New-LabContainer $web @('-d','-p',"127.0.0.1:${Port}:80") $image
    $webNames.Add($web)
    $web2 = "$runId-web2"
    $null = New-LabContainer $web2 @('-d','-p',"127.0.0.1:${SecondPort}:80") $image
    $webNames.Add($web2)
    foreach ($hostPort in @($Port,$SecondPort)) {
        $body = Run-Lab "포트 $hostPort HTTP 접속" @('curl.exe','--connect-timeout','3','--max-time','8','--retry','3','--retry-all-errors','--retry-delay','1','-fsS','-w',"`nHTTP=%{http_code}`n","http://127.0.0.1:$hostPort/")
        if ($body -notmatch 'data-project="codyssey-mission-1"' -or $body -notmatch 'HTTP=200') { throw "HTTP verification failed: $hostPort" }
    }
    # 의도한 실패 재현: NGINX는 80에서 듣지만 8080으로 잘못 연결한다.
    $wrongPort = "$runId-wrong-port"
    $null = New-LabContainer $wrongPort @('-d','-p',"127.0.0.1:${ExperimentPort}:8080") $image
    $null = Run-Lab '의도한 실패: 잘못된 컨테이너 포트' @('curl.exe','--max-time','4','-fsS',"http://127.0.0.1:$ExperimentPort/") @(7,28,52,56)
    $null = Run-Lab 'NGINX 실제 수신 포트 확인' @('docker','exec',$wrongPort,'sh','-c','nginx -T 2>&1 | grep listen')
    Remove-LabContainer $wrongPort
    $bindRoot = Join-Path $labRoot 'bind-site'
    New-Item -ItemType Directory -Force -Path $bindRoot | Out-Null
    Copy-Item -LiteralPath (Join-Path $taskRoot 'site\index.html') -Destination (Join-Path $bindRoot 'index.html')
    Set-Content -LiteralPath (Join-Path $bindRoot 'marker.txt') -Encoding utf8 -NoNewline -Value 'bind-before'
    $bound = "$runId-bind"
    $null = New-LabContainer $bound @('-d','-p',"127.0.0.1:${ExperimentPort}:80",'--mount',"type=bind,source=$bindRoot,target=/usr/share/nginx/html,readonly") $image
    $beforeRaw = Run-Lab '바인드 마운트 변경 전' @('curl.exe','--connect-timeout','3','--max-time','8','--retry','3','--retry-all-errors','--retry-delay','1','-fsS',"http://127.0.0.1:$ExperimentPort/marker.txt")
    $before = ($beforeRaw -split "`n")[-1].Trim()
    Add-Content -LiteralPath $logPath -Encoding utf8 -Value "`n호스트 파일 변경 명령: Set-Content .lab/bind-site/marker.txt -Value 'bind-after' -NoNewline -Encoding utf8`n"
    Set-Content -LiteralPath (Join-Path $bindRoot 'marker.txt') -Encoding utf8 -NoNewline -Value 'bind-after'
    $afterRaw = Run-Lab '재빌드 없이 바인드 마운트 변경 후' @('curl.exe','--connect-timeout','3','--max-time','8','-fsS',"http://127.0.0.1:$ExperimentPort/marker.txt")
    $after = ($afterRaw -split "`n")[-1].Trim()
    if ($before -ne 'bind-before' -or $after -ne 'bind-after') { throw 'bind-mount change not verified' }
    $null = Run-Lab 'named volume 생성' @('docker','volume','create','--label',"codyssey.run=$runId",$volumeName)
    $volumeCreated = $true
    $vol1 = "$runId-volume-before"
    $null = New-LabContainer $vol1 @('-d','--mount',"type=volume,source=$volumeName,target=/data") 'ubuntu:24.04' @('sleep','infinity')
    $proof = "persisted-$runId"
    $null = Run-Lab '볼륨에 데이터 기록' @('docker','exec',$vol1,'sh','-c',"printf '%s\n' '$proof' > /data/proof.txt; cat /data/proof.txt; sha256sum /data/proof.txt")
    $hashBefore = Run-Lab '삭제 전 데이터 해시' @('docker','exec',$vol1,'sha256sum','/data/proof.txt')
    Remove-LabContainer $vol1
    $vol2 = "$runId-volume-after"
    $null = New-LabContainer $vol2 @('-d','--mount',"type=volume,source=$volumeName,target=/data") 'ubuntu:24.04' @('sleep','infinity')
    $hashAfter = Run-Lab '새 컨테이너의 데이터 해시' @('docker','exec',$vol2,'sha256sum','/data/proof.txt')
    $null = Run-Lab '컨테이너 삭제 후 보존된 본문' @('docker','exec',$vol2,'cat','/data/proof.txt')
    if ($hashBefore -ne $hashAfter) { throw 'named-volume content changed after recreation' }
    $null = Run-Lab '작업 컨테이너 목록' @('docker','ps','-a','--filter',"label=codyssey.run=$runId",'--format','{{.Names}} | {{.Status}} | {{.Ports}}')
    $null = Run-Lab '웹 서버 로그' @('docker','logs',$web)
    $null = Run-Lab '웹 서버 자원 사용량' @('docker','stats','--no-stream',$web,$web2)
    $null = Run-Lab 'Ubuntu 컨테이너 중지' @('docker','stop',$ubuntu)
    $null = Run-Lab '중지 후 상태' @('docker','inspect','--format','{{.State.Status}}',$ubuntu)
    $state = @{run_id=$runId; image=$image; containers=@($created); web_containers=@($webNames); volume=$volumeName; ports=@($Port,$SecondPort); verified=$true; volume_hash_before=$hashBefore; volume_hash_after=$hashAfter; bind_before=$before; bind_after=$after; web_kept=[bool]$KeepWeb}
    $state | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $labRoot 'state.json') -Encoding utf8
    $success = $true
    Add-Content -LiteralPath $logPath -Encoding utf8 -Value "`nDOCKER_LAB_VERIFIED: hello-world, Ubuntu, exec/attach, build, two HTTP ports, bind mount, volume persistence, operations.`n"
} finally {
    foreach ($containerName in $created) {
        if ($success -and $KeepWeb -and $webNames.Contains($containerName)) { continue }
        Remove-LabContainer $containerName
    }
    if ($volumeCreated) {
        $null = Run-Lab '검증이 끝난 작업 볼륨 정리' @('docker','volume','rm',$volumeName)
    }
}
Write-Host "증거 저장: $logPath"
if ($success -and $KeepWeb) { Write-Host "웹 확인: http://127.0.0.1:$Port/ , http://127.0.0.1:$SecondPort/" }
