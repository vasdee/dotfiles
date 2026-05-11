#!/bin/sh


arch() {
    yay_install starship
}

fedora() {
    rootdo dnf -y copr enable chronoscrat/starship
    rootdo dnf install -y starship
}

debian() {
    rootdo apt install -y starship
}

ubuntu() {
    debian
}

steamos() {
    rootdo pacman -S --noconfirm starship
}
