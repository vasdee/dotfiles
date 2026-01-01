#!/bin/sh

. ../../lib/lib.sh


fedora_install() {
    rootdo dnf install -y python3-argcomplete
}


generic_install() {
    uv_install --prerelease=allow azure-cli@latest
}


install_for_os
