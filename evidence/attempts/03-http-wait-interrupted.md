# Docker 실제 실행 기록

실행자: 소유자의 요청을 받은 Codex.

UTC: 2026-10-29T11:52:56.8974233Z


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


## 컨테이너 생성 codyssey-m1-20261029205255-hello

```text
> docker run --name codyssey-m1-20261029205255-hello --label codyssey.run=codyssey-m1-20261029205255 --memory 128m --cpus 0.5 hello-world:latest

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


## 컨테이너 생성 codyssey-m1-20261029205255-ubuntu

```text
> docker run --name codyssey-m1-20261029205255-ubuntu --label codyssey.run=codyssey-m1-20261029205255 --memory 128m --cpus 0.5 -dit ubuntu:24.04 bash
c58f38438ea3b63c073c0293602d7b7f5d011cd50119da9672fd16a9f63bee16
[exit 0]
```


## Ubuntu 내부 명령

```text
> docker exec codyssey-m1-20261029205255-ubuntu bash -lc 'echo inside-ubuntu; pwd; ls /; echo process-alive'
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
> docker exec codyssey-m1-20261029205255-ubuntu bash -lc 'echo exec-session-finished; exit 0'
exec-session-finished
[exit 0]
```


## exec 후 PID 1 유지 확인

```text
> docker inspect --format {{.State.Running}} codyssey-m1-20261029205255-ubuntu
true
[exit 0]
```


## 컨테이너 생성 codyssey-m1-20261029205255-attach

```text
> docker run --name codyssey-m1-20261029205255-attach --label codyssey.run=codyssey-m1-20261029205255 --memory 128m --cpus 0.5 -d ubuntu:24.04 sh -c 'sleep 2; echo main-process-finished'
1cd8def1e04cf6bf788186af16e67b0a29eb5bbd0bb8ef47cbd92990c5350513
[exit 0]
```


## attach로 주 프로세스 출력 관찰

```text
> docker attach codyssey-m1-20261029205255-attach
main-process-finished
[exit 0]
```


## 주 프로세스 종료 상태

```text
> docker inspect --format '{{.State.Status}} exit={{.State.ExitCode}}' codyssey-m1-20261029205255-attach
exited exit=0
[exit 0]
```


## Dockerfile 빌드

```text
> docker build --progress plain -t codyssey-workstation:codyssey-m1-20261029205255 .
#0 building with "desktop-linux" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 554B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/nginx:alpine@sha256:785835ea65db4bba6f021acc0f3be91b0fef76a53fe41f8588c6698d2aed0606
#2 DONE 0.0s

#3 [internal] load .dockerignore
#3 transferring context: 88B 0.1s done
#3 DONE 0.1s

#4 [internal] load build context
#4 transferring context: 61B done
#4 DONE 0.0s

#5 [1/2] FROM docker.io/library/nginx:alpine@sha256:785835ea65db4bba6f021acc0f3be91b0fef76a53fe41f8588c6698d2aed0606
#5 resolve docker.io/library/nginx:alpine@sha256:785835ea65db4bba6f021acc0f3be91b0fef76a53fe41f8588c6698d2aed0606 0.0s done
#5 DONE 0.1s

#6 [2/2] COPY site/ /usr/share/nginx/html/
#6 CACHED

#7 exporting to image
#7 exporting layers done
#7 exporting manifest sha256:05e85aaea2ad701a0bb6ad8250c60bc307225bfa16e38d3cef1db185b1d7a077 done
#7 exporting config sha256:9ea39e816da1046fa3dfe798bd3f355be6b168cd284b128a83cc46a796b7fb53 done
#7 exporting attestation manifest sha256:78c72f567ae372ac6aff8e3f213f35f4d65a71a1dae0534f3186446c76c340c6 0.1s done
#7 exporting manifest list sha256:a0eb373d0d7c7c4e821c14ea9e93e91f54c59684595863cff784d021a67e39ea
#7 exporting manifest list sha256:a0eb373d0d7c7c4e821c14ea9e93e91f54c59684595863cff784d021a67e39ea 0.6s done
#7 naming to docker.io/library/codyssey-workstation:codyssey-m1-20261029205255
#7 naming to docker.io/library/codyssey-workstation:codyssey-m1-20261029205255 done
#7 unpacking to docker.io/library/codyssey-workstation:codyssey-m1-20261029205255 0.0s done
#7 DONE 0.8s
[exit 0]
```


## 컨테이너 생성 codyssey-m1-20261029205255-web

```text
> docker run --name codyssey-m1-20261029205255-web --label codyssey.run=codyssey-m1-20261029205255 --memory 128m --cpus 0.5 -d -p 127.0.0.1:18881:80 codyssey-workstation:codyssey-m1-20261029205255
08e8c5b73cb6ae0d564daac6307dec0cca7ebb975ed027410e8a73d70c3d07c0
[exit 0]
```


## 컨테이너 생성 codyssey-m1-20261029205255-web2

```text
> docker run --name codyssey-m1-20261029205255-web2 --label codyssey.run=codyssey-m1-20261029205255 --memory 128m --cpus 0.5 -d -p 127.0.0.1:18882:80 codyssey-workstation:codyssey-m1-20261029205255
eb22338e512fe360539521bffabf3107f42ea51ad4245977699364b094878b10
[exit 0]
```


## 포트 18881 HTTP 접속

```text
> curl.exe --retry 5 --retry-all-errors --retry-delay 1 -fsS -w '
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
