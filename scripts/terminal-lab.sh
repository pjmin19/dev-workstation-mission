#!/usr/bin/env bash
# Linux 파일 권한은 WSL의 /tmp에서 실습한다. Windows 마운트의 권한 설정은 변경하지 않는다.
set -euo pipefail
PS4='+ '
set -x
lab_dir=$(mktemp -d /tmp/codyssey-m1.XXXXXX)
cd "$lab_dir"
pwd
mkdir practice
cd practice
touch .hidden-note empty.txt
printf 'terminal-practice\n' > note.txt
ls -la
cat note.txt
cp note.txt copied.txt
mv copied.txt renamed.txt
ls -l renamed.txt empty.txt
rm renamed.txt
mkdir temporary-directory
rmdir temporary-directory
test ! -e renamed.txt
test ! -e temporary-directory
printf '#!/bin/sh\necho permission-recovered\n' > run-demo.sh
mkdir permissions-demo
chmod 644 run-demo.sh
chmod 755 permissions-demo
stat -c '%a %A %n' run-demo.sh permissions-demo
# 의도한 실패 재현: 실행 권한이 없는 파일을 실행하면 126으로 실패한다.
set +e
./run-demo.sh
permission_exit=$?
set -e
printf 'Expected permission failure exit=%s\n' "$permission_exit"
test "$permission_exit" -eq 126
chmod 755 run-demo.sh
chmod 700 permissions-demo
stat -c '%a %A %n' run-demo.sh permissions-demo
./run-demo.sh
cd "$lab_dir"
printf 'absolute-path=%s/practice\nrelative-path=./practice\n' "$lab_dir"
printf 'TERMINAL_LAB_VERIFIED\n'
