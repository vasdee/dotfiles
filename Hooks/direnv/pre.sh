#!/bin/sh

. ../../lib/lib.sh

fedora_install() {
    rootdo dnf install -y direnv
}

install_for_os
