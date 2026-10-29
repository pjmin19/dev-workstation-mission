# Git 설정과 GitHub·VSCode 연결 확인

실행자: 사용자 요청을 받은 Codex. 공개 증거에는 저장소 전용 설정과 GitHub 공개 아이디만 기록합니다.

UTC: 2026-10-29T12:02:14.897452+00:00

```text

$ git config --local --list

core.repositoryformatversion=0
core.filemode=false
core.bare=false
core.logallrefupdates=true
core.symlinks=false
core.ignorecase=true
core.autocrlf=false
remote.origin.url=https://github.com/pjmin19/dev-workstation-mission.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.main.remote=origin
branch.main.merge=refs/heads/main
branch.main.vscode-merge-base=origin/main
user.name=pjmin19
user.email=18236467+pjmin19@users.noreply.github.com
init.defaultbranch=main

[exit 0]

```

```text

$ git log -3 "--format=%h %s"

3b53e13 feat: 미션 1 웹 서버와 재현 가능한 실습 명령 추가
9539ef0 docs: README.md 작성 - 1단계 완료
2b3b537 Initial commit

[exit 0]

```

```text

$ git remote get-url origin

https://github.com/pjmin19/dev-workstation-mission.git

[exit 0]

```

```text

$ "C:\Program Files\GitHub CLI\gh.exe" api user --jq {login:.login,id:.id}

{"id":18236467,"login":"pjmin19"}

[exit 0]

```

## VSCode 네이티브 화면에서 별도 확인

실제 계정 메뉴: pjmin19 (GitHub)

실제 Git 상태: dev-workstation-mission (Git) - main*, 변경 내용 동기화

[확인 시각과 네이티브 UI 항목](04-vscode-native-readback.json)

CLI 인증과 별도로 VSCode의 로그인 계정 표시를 읽었습니다. 기존 로그인 상태를 사용했습니다. 토큰·인증 파일은 읽거나 저장하지 않았습니다.
