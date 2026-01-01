#!/bin/sh

. ../../lib/lib.sh

fedora_install() {
    rootdo dnf install -y pandoc
}

install_for_os
