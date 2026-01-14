#!/bin/sh

. ../../lib/lib.sh

macos() {
    brew install coreutils git curl jq
}

fedora() {
    rootdo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    rootdo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    rootdo dnf install -y git-core jq curl
}

debian() {
    rootdo apt install -y jq curl git
}

steamos() {
    rootdo steamos-readonly disable
    rootdo pacman-key --init
    rootdo pacman-key --populate archlinux
    rootdo pacman-key --populate holo
    rootdo pacman -S --noconfirm jq git curl
}

generic() {

    # link in tuckr and the dots if it hasn't already happened
    # is it safe to assume that this will always be dotfiles? Might need to think about that
    if [ ! -f $HOME/.config/dotfiles/bin/$(uname -s)/$(uname -m)/tuckr ] ; then
        ln -s $HOME/.config/dotfiles/bin/$(uname -s)/$(uname -m)/tuckr ${HOME}/.local/bin/tuckr
    fi

    # Lets make these directories ahead of time, since they are used by so many other groups
    mkdir -p ~/.local/share/bash-completion/completions/
    mkdir -p ~/.zshrc.d/
    mkdir -p ~/.bashrc.d/
    mkdir -p ~/.local/share/certificates/
    mkdir -p ~/.gitconfig.d/
}
