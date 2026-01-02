#!/bin/sh

. ../../lib/lib.sh

linux() {

    LATEST_VERSION="$(github_latest_tag 'oras-project/oras')"
    VERSION=${ORAS_VERSION:=$LATEST_VERSION}
    FILENAME="oras_${VERSION}_linux_amd64"
    curl -fLO "https://github.com/oras-project/oras/releases/download/v${VERSION}/${FILENAME}.tar.gz"
    mkdir -p oras-install/
    tar -zxf ${FILENAME}.tar.gz -C oras-install/
    mv oras-install/oras ~/.local/bin/
}
