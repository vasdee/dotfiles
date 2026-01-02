#!/bin/sh

. ../../lib/lib.sh

fedora_install() {
    rootdo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    rootdo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    rootdo dnf install -y htop btop tmux git-core vim jq
}

debian_install() {
    debian_install
}

steamos_install() {
    rootdo steamos-readonly disable
    rootdo pacman-key --init
    rootdo pacman-key --populate archlinux
    rootdo pacman-key --populate holo
    rootdo pacman -S --noconfirm tmux jq
}

generic_install() {

    if [ ! -f ${HOME}/.config/dotfiles_bhp/bin/${OS_TYPE}/tuckr ]; then
        ln -s ${HOME}/.config/dotfiles_bhp/bin/${OS_TYPE}/tuckr ${HOME}/.local/bin/tuckr
    fi
}
