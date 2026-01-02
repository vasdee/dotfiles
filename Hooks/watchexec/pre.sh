#!/bin/sh

. ../../lib/lib.sh


fedora() {
    has "curl"
    has "tar"

    LATEST_VERSION=$(github_latest_tag "watchexec/watchexec")
    VERSION=${WATCHEXEC_VERSION:=$LATEST_VERSION}
    FILENAME="watchexec-${version}-$(uname -m)-unknown-linux-gnu.rpm"
    curl -fOL "https://github.com/watchexec/watchexec/releases/download/v${VERSION}/${FILENAME}"
    rootdo dnf install -y ${FILENAME}
}

debian() {
    LATEST_VERSION=$(github_latest_tag "watchexec/watchexec")
    VERSION=${WATCHEXEC_VERSION:=$LATEST_VERSION}
    FILENAME="watchexec-${version}-$(uname -m)-unknown-linux-gnu.deb"
    curl -fOL "https://github.com/watchexec/watchexec/releases/download/v${VERSION}/${FILENAME}"
    rootdo apt install -y ${FILENAME}
}
