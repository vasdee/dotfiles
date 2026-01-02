#!/bin/sh

. ../../lib/lib.sh

steamos() {
    rootdo pacman -S --noconfirm python-argcomplete
}


fedora() {
    rootdo dnf install -y python3-argcomplete
}


generic() {
    uv_install --prerelease allow azure-cli@latest
}
