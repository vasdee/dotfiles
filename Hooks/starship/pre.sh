#!/bin/sh

. ../../lib/lib.sh

fedora_install() {
    rootdo dnf -y copr enable chronoscrat/starship
    rootdo dnf install -y starship
}

debian_install() {
    rootdo apt install -y starship
}

ubuntu_install() {
    debian_install
}


install_for_os
