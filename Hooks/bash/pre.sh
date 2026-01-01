#!/bin/sh

. ../../lib/lib.sh

fedora_install() {
    mkdir -p ~/.bashrc.d/ || true
}

ubuntu_install() {
    debian_install
}

debian_install() {

    # Debian do not support the .bashrc.d/ concept out of the box.
    # We'll add a custom snippet in that case
    add_line_to_file "source ~/.bashrc-custom" ~/.bashrc

    mkdir -p ~/.bashrc.d/ || true
}

install_for_os
