#!/bin/sh

. ../../lib/lib.sh


generic_install() {
    curl -LsSf https://astral.sh/uv/install.sh | sh
}

install_for_os
