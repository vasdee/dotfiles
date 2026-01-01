#!/bin/sh

. ../../lib/lib.sh

linux_install() {
    uv tool install bump-my-version
}

install_for_os
