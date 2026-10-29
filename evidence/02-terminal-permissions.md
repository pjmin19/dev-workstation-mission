# 터미널과 권한 실제 실습

실행자: 소유자 요청을 받은 Codex. WSL Linux의 임시 실습 폴더에서 수행.

UTC: 2026-10-29T11:59:57.691562+00:00

```text
$ wsl -d Ubuntu-24.04 -- bash /mnt/d/Codex/projects/dev-workstation-mission/scripts/terminal-lab.sh
++ mktemp -d /tmp/codyssey-m1.XXXXXX
+ lab_dir=/tmp/codyssey-m1.4nNEgu
+ cd /tmp/codyssey-m1.4nNEgu
+ pwd
+ mkdir practice
/tmp/codyssey-m1.4nNEgu
+ cd practice
+ touch .hidden-note empty.txt
+ printf 'terminal-practice\n'
+ ls -la
total 12
drwxr-xr-x 2 root root 4096 Oct 29 20:59 .
drwx------ 3 root root 4096 Oct 29 20:59 ..
-rw-r--r-- 1 root root    0 Oct 29 20:59 .hidden-note
-rw-r--r-- 1 root root    0 Oct 29 20:59 empty.txt
-rw-r--r-- 1 root root   18 Oct 29 20:59 note.txt
+ cat note.txt
terminal-practice
+ cp note.txt copied.txt
+ mv copied.txt renamed.txt
+ ls -l renamed.txt empty.txt
-rw-r--r-- 1 root root  0 Oct 29 20:59 empty.txt
-rw-r--r-- 1 root root 18 Oct 29 20:59 renamed.txt
+ rm renamed.txt
+ mkdir temporary-directory
+ rmdir temporary-directory
+ test '!' -e renamed.txt
+ test '!' -e temporary-directory
+ printf '#!/bin/sh\necho permission-recovered\n'
+ mkdir permissions-demo
+ chmod 644 run-demo.sh
+ chmod 755 permissions-demo
+ stat -c '%a %A %n' run-demo.sh permissions-demo
644 -rw-r--r-- run-demo.sh
755 drwxr-xr-x permissions-demo
+ set +e
+ ./run-demo.sh
/mnt/d/Codex/projects/dev-workstation-mission/scripts/terminal-lab.sh: line 30: ./run-demo.sh: Permission denied
+ permission_exit=126
+ set -e
+ printf 'Expected permission failure exit=%s\n' 126
Expected permission failure exit=126
+ test 126 -eq 126
+ chmod 755 run-demo.sh
+ chmod 700 permissions-demo
+ stat -c '%a %A %n' run-demo.sh permissions-demo
755 -rwxr-xr-x run-demo.sh
700 drwx------ permissions-demo
+ ./run-demo.sh
permission-recovered
+ cd /tmp/codyssey-m1.4nNEgu
absolute-path=/tmp/codyssey-m1.4nNEgu/practice
relative-path=./practice
+ printf 'absolute-path=%s/practice\nrelative-path=./practice\n' /tmp/codyssey-m1.4nNEgu
+ printf 'TERMINAL_LAB_VERIFIED\n'
TERMINAL_LAB_VERIFIED

[exit 0]
```
