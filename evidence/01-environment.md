# 기존 설치 환경 확인

실행자: 사용자 요청을 받은 Codex. 기존 설치를 확인했으며 새 설치 이력을 주장하지 않음.

기록 시각(UTC): 2026-10-29T11:48:32.260204+00:00

## git --version

```text

$ git --version

git version 2.52.0.windows.1

[exit 0]

```

## gh --version

```text

$ "C:\Program Files\GitHub CLI\gh.exe" --version

gh version 2.92.0 (2026-04-28)
https://github.com/cli/cli/releases/tag/v2.92.0

[exit 0]

```

## docker version --format client/server

```text

$ docker version --format "Client={{.Client.Version}} ({{.Client.Os}}), Server={{.Server.Version}} ({{.Server.Os}})"

Client=29.4.1 (windows), Server=29.4.1 (linux)

[exit 0]

```

## docker info --format engine

```text

$ docker info --format "Engine={{.ServerVersion}}, OS={{.OperatingSystem}}, Kernel={{.KernelVersion}}, CPUs={{.NCPU}}"

Engine=29.4.1, OS=Docker Desktop, Kernel=6.18.33.2-microsoft-standard-WSL2, CPUs=16

[exit 0]

```

## WSL Ubuntu operating system

```text

$ wsl -d Ubuntu-24.04 -- cat /etc/os-release

PRETTY_NAME="Ubuntu 24.04 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04 LTS (Noble Numbat)"
VERSION_CODENAME=noble
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=noble
LOGO=ubuntu-logo

[exit 0]

```

## WSL bash --version

```text

$ wsl -d Ubuntu-24.04 -- bash --version

GNU bash, version 5.2.21(1)-release (x86_64-pc-linux-gnu)
Copyright (C) 2022 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

[exit 0]

```

## 호스트와 도구 추가 확인

명령: Get-CimInstance Win32_OperatingSystem; $PSVersionTable.PSVersion; Code.exe VersionInfo.ProductVersion

```json
{
  "Windows": {
    "Caption": "Microsoft Windows 11 Home",
    "Version": "10.0.22621",
    "BuildNumber": "22621"
  },
  "VSCode": "1.142.0",
  "PowerShell": "7.6.5"
}
```
