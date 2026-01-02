#!/bin/sh

. ../../lib/lib.sh

fedora() {
    rootdo dnf install -y zsh

    # Support .zshrc.d/ organisation
    add_line_to_file "source ~/.zshrc-custom" ~/.zshrc
    mkdir -p ~/.zshrc.d/ || true

}

debian() {
    rootdo apt install -y zsh

    # Support .zshrc.d/ organisation
    add_line_to_file "source ~/.zshrc-custom" ~/.zshrc
    mkdir -p ~/.zshrc.d/ || true
}

ubuntu() {
    debian
}
