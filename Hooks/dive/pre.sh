#!/bin/sh

. ../../lib/lib.sh

fedora_install() {
    LATEST_VERSION=$(github_latest_tag "wagoodman/dive")
    VERSION=${DIVE_VERSION:=$LATEST_VERSION}
    curl -sfOL https://github.com/wagoodman/dive/releases/download/v${VERSION}/dive_${VERSION}_linux_amd64.rpm
    rootdo dnf install -y dive_${VERSION}_linux_amd64.rpm ncurses
    rm dive_${VERSION}_linux_amd64.rpm
}

debian_install() {
    VERSION=$(github_latest_tag "wagoodman/dive")
    curl -sfOL https://github.com/wagoodman/dive/releases/download/v${VERSION}/dive_${VERSION}_linux_amd64.deb
    rootdo apt install ./dive_${VERSION}_linux_amd64.deb
    rm dive_${VERSION}_linux_amd64.deb
}

install_for_os
