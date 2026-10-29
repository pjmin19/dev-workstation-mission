# Docker 실제 실행 기록

실행자: 소유자의 요청을 받은 Codex.

UTC: 2026-10-29T11:57:26.1733368Z


## Docker 버전

```text
> docker --version
Docker version 29.4.1, build 055a478
[exit 0]
```


## Docker 엔진 점검

```text
> docker info --format 'Engine={{.ServerVersion}} OS={{.OperatingSystem}} Kernel={{.KernelVersion}}'
Engine=29.4.1 OS=Docker Desktop Kernel=6.18.33.2-microsoft-standard-WSL2
[exit 0]
```


## 공식 이미지 받기 hello-world:latest

```text
> docker pull hello-world:latest
latest: Pulling from library/hello-world
Digest: sha256:c567b231f65614688711a75f31518a064258a51d442117a3e771a3a8fdba78ef
Status: Image is up to date for hello-world:latest
docker.io/library/hello-world:latest
[exit 0]
```


## 이미지 목록 hello-world:latest

```text
> docker images hello-world:latest
WARNING: This output is designed for human readability. For machine-readable output, please use --format.
IMAGE                ID             DISK USAGE   CONTENT SIZE   EXTRA
hello-world:latest   c567b231f656       25.9kB         9.49kB
[exit 0]
```


## 이미지 식별 hello-world:latest

```text
> docker image inspect --format 'ID={{.Id}} Digests={{json .RepoDigests}}' hello-world:latest
ID=sha256:c567b231f65614688711a75f31518a064258a51d442117a3e771a3a8fdba78ef Digests=["hello-world@sha256:c567b231f65614688711a75f31518a064258a51d442117a3e771a3a8fdba78ef"]
[exit 0]
```


## 공식 이미지 받기 ubuntu:24.04

```text
> docker pull ubuntu:24.04
24.04: Pulling from library/ubuntu
Digest: sha256:fe81560990fae86dc4743202b2cb4d3df98d0bcf949173cecef15ce1127ef852
Status: Image is up to date for ubuntu:24.04
docker.io/library/ubuntu:24.04
[exit 0]
```


## 이미지 목록 ubuntu:24.04

```text
> docker images ubuntu:24.04
WARNING: This output is designed for human readability. For machine-readable output, please use --format.
IMAGE          ID             DISK USAGE   CONTENT SIZE   EXTRA
ubuntu:24.04   fe81560990fa        119MB         31.7MB
[exit 0]
```


## 이미지 식별 ubuntu:24.04

```text
> docker image inspect --format 'ID={{.Id}} Digests={{json .RepoDigests}}' ubuntu:24.04
ID=sha256:fe81560990fae86dc4743202b2cb4d3df98d0bcf949173cecef15ce1127ef852 Digests=["ubuntu@sha256:fe81560990fae86dc4743202b2cb4d3df98d0bcf949173cecef15ce1127ef852"]
[exit 0]
```


## 공식 이미지 받기 nginx:alpine

```text
> docker pull nginx:alpine
alpine: Pulling from library/nginx
Digest: sha256:785835ea65db4bba6f021acc0f3be91b0fef76a53fe41f8588c6698d2aed0606
Status: Image is up to date for nginx:alpine
docker.io/library/nginx:alpine
[exit 0]
```


## 이미지 목록 nginx:alpine

```text
> docker images nginx:alpine
WARNING: This output is designed for human readability. For machine-readable output, please use --format.
IMAGE          ID             DISK USAGE   CONTENT SIZE   EXTRA
nginx:alpine   785835ea65db       94.5MB         27.2MB
[exit 0]
```


## 이미지 식별 nginx:alpine

```text
> docker image inspect --format 'ID={{.Id}} Digests={{json .RepoDigests}}' nginx:alpine
ID=sha256:785835ea65db4bba6f021acc0f3be91b0fef76a53fe41f8588c6698d2aed0606 Digests=["nginx@sha256:785835ea65db4bba6f021acc0f3be91b0fef76a53fe41f8588c6698d2aed0606"]
[exit 0]
```


## 컨테이너 생성 codyssey-m1-20261029205726-hello

```text
> docker run --name codyssey-m1-20261029205726-hello --label codyssey.run=codyssey-m1-20261029205726 --memory 128m --cpus 0.5 hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

[exit 0]
```


## 컨테이너 생성 codyssey-m1-20261029205726-ubuntu

```text
> docker run --name codyssey-m1-20261029205726-ubuntu --label codyssey.run=codyssey-m1-20261029205726 --memory 128m --cpus 0.5 -dit ubuntu:24.04 bash
749720629ce61ce4cdf1d7bc6e69d4e5b3d864a93789ccb5edc6bb5388e546de
[exit 0]
```


## Ubuntu 내부 명령

```text
> docker exec codyssey-m1-20261029205726-ubuntu bash -lc 'echo inside-ubuntu; pwd; ls /; echo process-alive'
inside-ubuntu
/
bin
boot
dev
etc
home
lib
lib64
media
mnt
opt
proc
root
run
sbin
srv
sys
tmp
usr
var
process-alive
[exit 0]
```


## exec의 셸만 종료

```text
> docker exec codyssey-m1-20261029205726-ubuntu bash -lc 'echo exec-session-finished; exit 0'
exec-session-finished
[exit 0]
```


## exec 후 PID 1 유지 확인

```text
> docker inspect --format {{.State.Running}} codyssey-m1-20261029205726-ubuntu
true
[exit 0]
```


## 컨테이너 생성 codyssey-m1-20261029205726-attach

```text
> docker run --name codyssey-m1-20261029205726-attach --label codyssey.run=codyssey-m1-20261029205726 --memory 128m --cpus 0.5 -d ubuntu:24.04 sh -c 'sleep 2; echo main-process-finished'
388bf552196ba82aa5e8a7b5450d52217fed1bd63aaa1ed78b73cccd01b1f585
[exit 0]
```


## attach로 주 프로세스 출력 관찰

```text
> docker attach codyssey-m1-20261029205726-attach
main-process-finished
[exit 0]
```


## 주 프로세스 종료 상태

```text
> docker inspect --format '{{.State.Status}} exit={{.State.ExitCode}}' codyssey-m1-20261029205726-attach
exited exit=0
[exit 0]
```


## Dockerfile 빌드

```text
> docker build --progress plain -t codyssey-workstation:codyssey-m1-20261029205726 .
#0 building with "desktop-linux" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 554B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/nginx:alpine@sha256:785835ea65db4bba6f021acc0f3be91b0fef76a53fe41f8588c6698d2aed0606
#2 DONE 0.0s

#3 [internal] load .dockerignore
#3 transferring context: 88B done
#3 DONE 0.0s

#4 [internal] load build context
#4 transferring context: 61B done
#4 DONE 0.0s

#5 [1/2] FROM docker.io/library/nginx:alpine@sha256:785835ea65db4bba6f021acc0f3be91b0fef76a53fe41f8588c6698d2aed0606
#5 resolve docker.io/library/nginx:alpine@sha256:785835ea65db4bba6f021acc0f3be91b0fef76a53fe41f8588c6698d2aed0606 0.0s done
#5 DONE 0.0s

#6 [2/2] COPY site/ /usr/share/nginx/html/
#6 CACHED

#7 exporting to image
#7 exporting layers done
#7 exporting manifest sha256:05e85aaea2ad701a0bb6ad8250c60bc307225bfa16e38d3cef1db185b1d7a077 done
#7 exporting config sha256:9ea39e816da1046fa3dfe798bd3f355be6b168cd284b128a83cc46a796b7fb53 done
#7 exporting attestation manifest sha256:1d7411349bcf7ca60c1737d5bceeb3da37c1c95a20f81560e063829b06c79f7c 0.0s done
#7 exporting manifest list sha256:341a96adb24afe8e7dc2b65668baf2a0451f534cc197171484b375c948b03cf7 0.0s done
#7 naming to docker.io/library/codyssey-workstation:codyssey-m1-20261029205726
#7 naming to docker.io/library/codyssey-workstation:codyssey-m1-20261029205726 done
#7 unpacking to docker.io/library/codyssey-workstation:codyssey-m1-20261029205726 0.0s done
#7 DONE 0.1s
[exit 0]
```


## 컨테이너 생성 codyssey-m1-20261029205726-web

```text
> docker run --name codyssey-m1-20261029205726-web --label codyssey.run=codyssey-m1-20261029205726 --memory 128m --cpus 0.5 -d -p 127.0.0.1:18881:80 codyssey-workstation:codyssey-m1-20261029205726
aca336e0895a543c823f0169e25d7b84ccf9e6f20ba008456c0ed216da4cd928
[exit 0]
```


## 컨테이너 생성 codyssey-m1-20261029205726-web2

```text
> docker run --name codyssey-m1-20261029205726-web2 --label codyssey.run=codyssey-m1-20261029205726 --memory 128m --cpus 0.5 -d -p 127.0.0.1:18882:80 codyssey-workstation:codyssey-m1-20261029205726
50f1f4b9bd891418517c8cc4d5b1207fd859810d0a2ac242c1194726851cc1da
[exit 0]
```


## 포트 18881 HTTP 접속

```text
> curl.exe --connect-timeout 3 --max-time 8 --retry 3 --retry-all-errors --retry-delay 1 -fsS -w '
HTTP=%{http_code}
' http://127.0.0.1:18881/
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>개발 워크스테이션 · 미션 1</title>
  <style>
    :root { color-scheme: light; font-family: system-ui, "Malgun Gothic", sans-serif; color: #142e38; background: #f2f6f5; }
    * { box-sizing: border-box; }
    body { margin: 0; padding: 64px 24px; }
    main { max-width: 1000px; margin: auto; }
    .eyebrow { color: #126a56; font-weight: 750; letter-spacing: .13em; font-size: 13px; }
    h1 { font-size: clamp(32px, 5vw, 54px); line-height: 1.2; margin: 20px 0; letter-spacing: -.045em; }
    .intro { font-size: 19px; line-height: 1.8; max-width: 720px; color: #45616b; }
    .status { display: inline-flex; gap: 9px; align-items: center; padding: 10px 16px; background: #d9eee5; color: #155d48; border-radius: 24px; font-weight: 700; margin: 16px 0 30px; }
    .dot { width: 8px; height: 8px; border-radius: 50%; background: #167650; }
    .grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 18px; }
    article { border: 1px solid #d6e3df; background: white; border-radius: 18px; padding: 25px; }
    article small { color: #548578; font-weight: 750; }
    h2 { font-size: 22px; margin: 14px 0; }
    article p { line-height: 1.8; color: #45616b; margin-bottom: 0; }
    .flow { margin-top: 26px; border-radius: 16px; padding: 22px; color: #dff4ed; background: #173f40; line-height: 1.9; }
    code { font-family: ui-monospace, Consolas, monospace; }
    footer { margin-top: 28px; line-height: 1.8; font-size: 14px; color: #5b747b; }
    @media (max-width: 700px) { body { padding: 32px 18px; } .grid { grid-template-columns: 1fr; } }
  </style>
<script type="text/javascript" nonce="fa0fb1a5456a408f91bae273ec7" src="//local.adguard.org?ts=1793272518879&amp;type=content-script&amp;dmn=127.0.0.1:18881&amp;url=http%3A%2F%2F127.0.0.1%3A18881%2F&amp;app=curl.exe&amp;css=2&amp;js=1&amp;rel=1&amp;rji=1&amp;sbe=1&amp;stealth=0"></script><script type="text/javascript" nonce="fa0fb1a5456a408f91bae273ec7" src="//local.adguard.org?ts=1793272518879&amp;name=AdGuard%20Extra&amp;name=AdGuard%20Popup%20Blocker&amp;type=user-script"></script></head>
<body>
  <main data-project="codyssey-mission-1">
    <div class="eyebrow">CODYSSEY / DEVELOPMENT WORKSTATION</div>
    <h1>내 컴퓨터에서 시작하는<br>개발 워크스테이션</h1>
    <p class="intro">Dockerfile로 만든 이미지 안에서 NGINX가 이 웹페이지를 제공합니다. 브라우저가 이 화면을 받았다면, 호스트의 포트와 컨테이너의 웹 서버가 연결된 것입니다.</p>
    <div class="status"><span class="dot"></span>NGINX 정적 웹페이지</div>
    <div class="grid">
      <article><small>01 · IMAGE</small><h2>실행 환경을 묶기</h2><p>공식 NGINX 이미지를 바탕으로 이 페이지를 복사합니다. 이미지를 다시 실행해도 같은 콘텐츠를 제공합니다.</p></article>
      <article><small>02 · PORT</small><h2>브라우저와 연결하기</h2><p>PC의 포트를 컨테이너 내부 80번 포트에 연결합니다. 실행 로그와 주소창을 함께 확인합니다.</p></article>
      <article><small>03 · STORAGE</small><h2>변경과 데이터를 확인하기</h2><p>바인드 마운트로 파일 변경을 확인하고, 별도 볼륨으로 컨테이너 삭제 후 데이터가 남는지 실습합니다.</p></article>
    </div>
    <div class="flow"><strong>요청이 도착하는 경로</strong><br>브라우저 → PC의 공개한 로컬 포트 → 컨테이너의 <code>80</code>번 포트 → <code>index.html</code></div>
    <footer>미션 1 실습용 페이지입니다. 실제 실행 명령, 검증 결과와 작업 지원 범위는 GitHub 저장소의 README와 evidence에서 확인할 수 있습니다.</footer>
  </main>
</body>
</html>

HTTP=200
[exit 0]
```


## 포트 18882 HTTP 접속

```text
> curl.exe --connect-timeout 3 --max-time 8 --retry 3 --retry-all-errors --retry-delay 1 -fsS -w '
HTTP=%{http_code}
' http://127.0.0.1:18882/
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>개발 워크스테이션 · 미션 1</title>
  <style>
    :root { color-scheme: light; font-family: system-ui, "Malgun Gothic", sans-serif; color: #142e38; background: #f2f6f5; }
    * { box-sizing: border-box; }
    body { margin: 0; padding: 64px 24px; }
    main { max-width: 1000px; margin: auto; }
    .eyebrow { color: #126a56; font-weight: 750; letter-spacing: .13em; font-size: 13px; }
    h1 { font-size: clamp(32px, 5vw, 54px); line-height: 1.2; margin: 20px 0; letter-spacing: -.045em; }
    .intro { font-size: 19px; line-height: 1.8; max-width: 720px; color: #45616b; }
    .status { display: inline-flex; gap: 9px; align-items: center; padding: 10px 16px; background: #d9eee5; color: #155d48; border-radius: 24px; font-weight: 700; margin: 16px 0 30px; }
    .dot { width: 8px; height: 8px; border-radius: 50%; background: #167650; }
    .grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 18px; }
    article { border: 1px solid #d6e3df; background: white; border-radius: 18px; padding: 25px; }
    article small { color: #548578; font-weight: 750; }
    h2 { font-size: 22px; margin: 14px 0; }
    article p { line-height: 1.8; color: #45616b; margin-bottom: 0; }
    .flow { margin-top: 26px; border-radius: 16px; padding: 22px; color: #dff4ed; background: #173f40; line-height: 1.9; }
    code { font-family: ui-monospace, Consolas, monospace; }
    footer { margin-top: 28px; line-height: 1.8; font-size: 14px; color: #5b747b; }
    @media (max-width: 700px) { body { padding: 32px 18px; } .grid { grid-template-columns: 1fr; } }
  </style>
<script type="text/javascript" nonce="fa0fb1a5456a408f91bae273ec7" src="//local.adguard.org?ts=1793272518879&amp;type=content-script&amp;dmn=127.0.0.1:18882&amp;url=http%3A%2F%2F127.0.0.1%3A18882%2F&amp;app=curl.exe&amp;css=2&amp;js=1&amp;rel=1&amp;rji=1&amp;sbe=1&amp;stealth=0"></script><script type="text/javascript" nonce="fa0fb1a5456a408f91bae273ec7" src="//local.adguard.org?ts=1793272518879&amp;name=AdGuard%20Extra&amp;name=AdGuard%20Popup%20Blocker&amp;type=user-script"></script></head>
<body>
  <main data-project="codyssey-mission-1">
    <div class="eyebrow">CODYSSEY / DEVELOPMENT WORKSTATION</div>
    <h1>내 컴퓨터에서 시작하는<br>개발 워크스테이션</h1>
    <p class="intro">Dockerfile로 만든 이미지 안에서 NGINX가 이 웹페이지를 제공합니다. 브라우저가 이 화면을 받았다면, 호스트의 포트와 컨테이너의 웹 서버가 연결된 것입니다.</p>
    <div class="status"><span class="dot"></span>NGINX 정적 웹페이지</div>
    <div class="grid">
      <article><small>01 · IMAGE</small><h2>실행 환경을 묶기</h2><p>공식 NGINX 이미지를 바탕으로 이 페이지를 복사합니다. 이미지를 다시 실행해도 같은 콘텐츠를 제공합니다.</p></article>
      <article><small>02 · PORT</small><h2>브라우저와 연결하기</h2><p>PC의 포트를 컨테이너 내부 80번 포트에 연결합니다. 실행 로그와 주소창을 함께 확인합니다.</p></article>
      <article><small>03 · STORAGE</small><h2>변경과 데이터를 확인하기</h2><p>바인드 마운트로 파일 변경을 확인하고, 별도 볼륨으로 컨테이너 삭제 후 데이터가 남는지 실습합니다.</p></article>
    </div>
    <div class="flow"><strong>요청이 도착하는 경로</strong><br>브라우저 → PC의 공개한 로컬 포트 → 컨테이너의 <code>80</code>번 포트 → <code>index.html</code></div>
    <footer>미션 1 실습용 페이지입니다. 실제 실행 명령, 검증 결과와 작업 지원 범위는 GitHub 저장소의 README와 evidence에서 확인할 수 있습니다.</footer>
  </main>
</body>
</html>

HTTP=200
[exit 0]
```


## 컨테이너 생성 codyssey-m1-20261029205726-wrong-port

```text
> docker run --name codyssey-m1-20261029205726-wrong-port --label codyssey.run=codyssey-m1-20261029205726 --memory 128m --cpus 0.5 -d -p 127.0.0.1:18883:8080 codyssey-workstation:codyssey-m1-20261029205726
642dcf2ea7515890b46de432f0ec1a66ff5c2d955991307f15bc2d8b5cb4e5fd
[exit 0]
```


## 의도한 실패: 잘못된 컨테이너 포트

```text
> curl.exe --max-time 4 -fsS http://127.0.0.1:18883/
curl: (52) Empty reply from server
[exit 52]
```


## NGINX 실제 수신 포트 확인

```text
> docker exec codyssey-m1-20261029205726-wrong-port sh -c 'nginx -T 2>&1 | grep listen'
    listen       80;
    listen  [::]:80;
    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
[exit 0]
```


## 작업 컨테이너 삭제 codyssey-m1-20261029205726-wrong-port

```text
> docker rm -f codyssey-m1-20261029205726-wrong-port
codyssey-m1-20261029205726-wrong-port
[exit 0]
```


## 컨테이너 생성 codyssey-m1-20261029205726-bind

```text
> docker run --name codyssey-m1-20261029205726-bind --label codyssey.run=codyssey-m1-20261029205726 --memory 128m --cpus 0.5 -d -p 127.0.0.1:18883:80 --mount type=bind,source=D:\Codex\projects\dev-workstation-mission\.lab\bind-site,target=/usr/share/nginx/html,readonly codyssey-workstation:codyssey-m1-20261029205726
4ec781aea172205957f04d968b3ce7ed8f43c9f7b1cb6725f25f6d5a25413cfe
[exit 0]
```


## 바인드 마운트 변경 전

```text
> curl.exe --connect-timeout 3 --max-time 8 --retry 3 --retry-all-errors --retry-delay 1 -fsS http://127.0.0.1:18883/marker.txt
bind-before
[exit 0]
```


호스트 파일 변경 명령: Set-Content .lab/bind-site/marker.txt -Value 'bind-after' -NoNewline -Encoding utf8


## 재빌드 없이 바인드 마운트 변경 후

```text
> curl.exe --connect-timeout 3 --max-time 8 -fsS http://127.0.0.1:18883/marker.txt
bind-after
[exit 0]
```


## named volume 생성

```text
> docker volume create --label codyssey.run=codyssey-m1-20261029205726 codyssey-m1-20261029205726-data
codyssey-m1-20261029205726-data
[exit 0]
```


## 컨테이너 생성 codyssey-m1-20261029205726-volume-before

```text
> docker run --name codyssey-m1-20261029205726-volume-before --label codyssey.run=codyssey-m1-20261029205726 --memory 128m --cpus 0.5 -d --mount type=volume,source=codyssey-m1-20261029205726-data,target=/data ubuntu:24.04 sleep infinity
5494c03305230da51285c99b8fe9bca9464c09e3565eac1e76743dc7700707a5
[exit 0]
```


## 볼륨에 데이터 기록

```text
> docker exec codyssey-m1-20261029205726-volume-before sh -c 'printf ''%s\n'' ''persisted-codyssey-m1-20261029205726'' > /data/proof.txt; cat /data/proof.txt; sha256sum /data/proof.txt'
persisted-codyssey-m1-20261029205726
c9fccc927433657eeaad6e0c66e2aafddf9fd350cf225104077b97eb5e0262af  /data/proof.txt
[exit 0]
```


## 삭제 전 데이터 해시

```text
> docker exec codyssey-m1-20261029205726-volume-before sha256sum /data/proof.txt
c9fccc927433657eeaad6e0c66e2aafddf9fd350cf225104077b97eb5e0262af  /data/proof.txt
[exit 0]
```


## 작업 컨테이너 삭제 codyssey-m1-20261029205726-volume-before

```text
> docker rm -f codyssey-m1-20261029205726-volume-before
codyssey-m1-20261029205726-volume-before
[exit 0]
```


## 컨테이너 생성 codyssey-m1-20261029205726-volume-after

```text
> docker run --name codyssey-m1-20261029205726-volume-after --label codyssey.run=codyssey-m1-20261029205726 --memory 128m --cpus 0.5 -d --mount type=volume,source=codyssey-m1-20261029205726-data,target=/data ubuntu:24.04 sleep infinity
8bbdb546fc03a8681688145ee3b6ad0b7e42cbc1f1a19db6ca81883f8eab4237
[exit 0]
```


## 새 컨테이너의 데이터 해시

```text
> docker exec codyssey-m1-20261029205726-volume-after sha256sum /data/proof.txt
c9fccc927433657eeaad6e0c66e2aafddf9fd350cf225104077b97eb5e0262af  /data/proof.txt
[exit 0]
```


## 컨테이너 삭제 후 보존된 본문

```text
> docker exec codyssey-m1-20261029205726-volume-after cat /data/proof.txt
persisted-codyssey-m1-20261029205726
[exit 0]
```


## 작업 컨테이너 목록

```text
> docker ps -a --filter label=codyssey.run=codyssey-m1-20261029205726 --format '{{.Names}} | {{.Status}} | {{.Ports}}'
codyssey-m1-20261029205726-volume-after | Up Less than a second |
codyssey-m1-20261029205726-bind | Up 3 seconds (health: starting) | 127.0.0.1:18883->80/tcp
codyssey-m1-20261029205726-web2 | Up 8 seconds (healthy) | 127.0.0.1:18882->80/tcp
codyssey-m1-20261029205726-web | Up 9 seconds (healthy) | 127.0.0.1:18881->80/tcp
codyssey-m1-20261029205726-attach | Exited (0) 11 seconds ago |
codyssey-m1-20261029205726-ubuntu | Up 16 seconds |
codyssey-m1-20261029205726-hello | Exited (0) 16 seconds ago |
[exit 0]
```


## 웹 서버 로그

```text
> docker logs codyssey-m1-20261029205726-web
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
2026/10/29 11:57:43 [notice] 1#1: using the "epoll" event method
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2026/10/29 11:57:43 [notice] 1#1: nginx/1.31.8
2026/10/29 11:57:43 [notice] 1#1: built by gcc 15.2.0 (Alpine 15.2.0)
2026/10/29 11:57:43 [notice] 1#1: OS: Linux 6.18.33.2-microsoft-standard-WSL2
2026/10/29 11:57:43 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2026/10/29 11:57:43 [notice] 1#1: start worker processes
2026/10/29 11:57:43 [notice] 1#1: start worker process 30
2026/10/29 11:57:43 [notice] 1#1: start worker process 31
2026/10/29 11:57:43 [notice] 1#1: start worker process 32
2026/10/29 11:57:43 [notice] 1#1: start worker process 33
2026/10/29 11:57:43 [notice] 1#1: start worker process 34
2026/10/29 11:57:43 [notice] 1#1: start worker process 35
2026/10/29 11:57:43 [notice] 1#1: start worker process 36
2026/10/29 11:57:43 [notice] 1#1: start worker process 37
2026/10/29 11:57:43 [notice] 1#1: start worker process 38
2026/10/29 11:57:43 [notice] 1#1: start worker process 39
2026/10/29 11:57:43 [notice] 1#1: start worker process 40
2026/10/29 11:57:43 [notice] 1#1: start worker process 41
2026/10/29 11:57:43 [notice] 1#1: start worker process 42
2026/10/29 11:57:43 [notice] 1#1: start worker process 43
2026/10/29 11:57:43 [notice] 1#1: start worker process 44
172.17.0.1 - - [29/Oct/2026:11:57:45 +0000] "GET / HTTP/1.1" 200 3382 "-" "curl/8.9.1" "-"
2026/10/29 11:57:43 [notice] 1#1: start worker process 45
127.0.0.1 - - [29/Oct/2026:11:57:48 +0000] "GET / HTTP/1.1" 200 3382 "-" "Wget" "-"
[exit 0]
```


## 웹 서버 자원 사용량

```text
> docker stats --no-stream codyssey-m1-20261029205726-web codyssey-m1-20261029205726-web2
CONTAINER ID   NAME                              CPU %     MEM USAGE / LIMIT   MEM %     NET I/O           BLOCK I/O     PIDS
aca336e0895a   codyssey-m1-20261029205726-web    0.00%     12.86MiB / 128MiB   10.04%    2.05kB / 4.13kB   0B / 12.3kB   17
50f1f4b9bd89   codyssey-m1-20261029205726-web2   0.00%     12.86MiB / 128MiB   10.05%    1.97kB / 4.13kB   0B / 12.3kB   17
[exit 0]
```


## Ubuntu 컨테이너 중지

```text
> docker stop codyssey-m1-20261029205726-ubuntu
codyssey-m1-20261029205726-ubuntu
[exit 0]
```


## 중지 후 상태

```text
> docker inspect --format {{.State.Status}} codyssey-m1-20261029205726-ubuntu
exited
[exit 0]
```


DOCKER_LAB_VERIFIED: hello-world, Ubuntu, exec/attach, build, two HTTP ports, bind mount, volume persistence, operations.


## 작업 컨테이너 삭제 codyssey-m1-20261029205726-hello

```text
> docker rm -f codyssey-m1-20261029205726-hello
codyssey-m1-20261029205726-hello
[exit 0]
```


## 작업 컨테이너 삭제 codyssey-m1-20261029205726-ubuntu

```text
> docker rm -f codyssey-m1-20261029205726-ubuntu
codyssey-m1-20261029205726-ubuntu
[exit 0]
```


## 작업 컨테이너 삭제 codyssey-m1-20261029205726-attach

```text
> docker rm -f codyssey-m1-20261029205726-attach
codyssey-m1-20261029205726-attach
[exit 0]
```


## 작업 컨테이너 삭제 codyssey-m1-20261029205726-bind

```text
> docker rm -f codyssey-m1-20261029205726-bind
codyssey-m1-20261029205726-bind
[exit 0]
```


## 작업 컨테이너 삭제 codyssey-m1-20261029205726-volume-after

```text
> docker rm -f codyssey-m1-20261029205726-volume-after
codyssey-m1-20261029205726-volume-after
[exit 0]
```


## 검증이 끝난 작업 볼륨 정리

```text
> docker volume rm codyssey-m1-20261029205726-data
codyssey-m1-20261029205726-data
[exit 0]
```
