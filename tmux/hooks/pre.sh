#!/bin/sh

macos() {
    brew install tmux
}

arch() {
    yay_install tmux
}

steamos() {
    rootdo pacman -S --noconfirm tmux
}

fedora() {
    rootdo dnf install -y tmux
}

# Bazzite seems to have tmux already installed
bazzite() {
    macos
}
