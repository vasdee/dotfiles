#!/bin/sh

. ../../lib/lib.sh

fedora() {
    rootdo dnf install -y fd-find
}

debian() {
    rootdo apt install -y fd-find
}

ubuntu() {
    debian
}


steamos() {
    rootdo pacman -S --noconfirm fd
}
