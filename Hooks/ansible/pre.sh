#!/bin/sh

. ../../lib/lib.sh

fedora_install() {
    rootdo dnf install -y sshpass
}

linux_install() {
    has uv
    uv tool install --with-executables-from ansible-core,ansible-lint \
       --with requests \
       ansible
}

install_for_os
