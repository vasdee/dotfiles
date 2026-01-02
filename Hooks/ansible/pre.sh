#!/bin/sh

. ../../lib/lib.sh

fedora() {
    rootdo dnf install -y sshpass
}

linux() {
    has uv
    uv tool install --with-executables-from ansible-core,ansible-lint \
       --with requests \
       ansible
}
