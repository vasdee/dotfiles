#!/bin/sh

. ../../lib/lib.sh

linux() {
    LATEST_VERSION=$(github_latest_tag "altsem/gitu")
    VERSION=${GITU_VERSION:=$LATEST_VERSION}
    FILENAME="gitu-v${version}-$(uname -m)-unknown-linux-gnu"
    curl -sLO https://github.com/altsem/gitu/releases/download/v${VERSION}/${FILENAME}.zip
    unzip -o ${FILENAME}.zip
    mv ${FILENAME}/gitu ~/.local/bin/
    chmod +x ~/.local/bin/gitu
}
