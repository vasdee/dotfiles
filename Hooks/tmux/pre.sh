#!/bin/sh

. ../../lib/lib.sh

steamos() {
    rootdo pacman -S --noconfirm tmux
}

fedora() {
    rootdo dnf install -y tmux
}
