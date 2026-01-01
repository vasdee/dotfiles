#!/bin/sh

. ../../lib/lib.sh

fedora_install() {
    rootdo dnf install -y zsh

    # Support .zshrc.d/ organisation
    add_line_to_file "source ~/.zshrc-custom" ~/.zshrc
    mkdir -p ~/.zshrc.d/ || true

}

debian_install() {
    rootdo apt install -y zsh

    # Support .zshrc.d/ organisation
    add_line_to_file "source ~/.zshrc-custom" ~/.zshrc
    mkdir -p ~/.zshrc.d/ || true
}

ubuntu_install() {
    debian_install
}

install_for_os
