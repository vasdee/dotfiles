#!/bin/sh

. ../../lib/lib.sh

arch() {
    rootdo pacman -S --needed --noconfirm git base-devel
    if ! command -v yay >/dev/null 2>&1; then
        TMPDIR=$(mktemp -d)
        git clone https://aur.archlinux.org/yay.git "$TMPDIR/yay"
        cd "$TMPDIR/yay"
        makepkg -si --noconfirm
        cd -
        rm -rf "$TMPDIR"
    fi
}

steamos() {
    arch
}
