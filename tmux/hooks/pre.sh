#!/bin/sh


arch() {
    yay_install tmux
}

steamos() {
    rootdo pacman -S --noconfirm tmux
}

fedora() {
    rootdo dnf install -y tmux
}
