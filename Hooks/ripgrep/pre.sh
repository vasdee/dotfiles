#!/bin/sh

. ../../lib/lib.sh

echo "Installing ripgrep"

fedora_install() {
    rootdo dnf install -y ripgrep
}

ubuntu_install() {
    debian_install
}

debian_install() {

    rootdo apt install -y ripgrep
}

install_for_os
