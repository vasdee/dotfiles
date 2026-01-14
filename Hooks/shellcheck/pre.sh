#!/bin/sh

. ../../lib/lib.sh


linux() {
    LATEST_VERSION=$(github_latest_tag "koalaman/shellcheck")
    VERSION=${SHELLCHECK_VERSION:=$LATEST_VERSION}
    FILENAME=shellcheck-v${VERSION}.linux.x86_64.tar.gz
    curl -LO https://github.com/koalaman/shellcheck/releases/download/v${VERSION}/${FILENAME}
    tar zxf $FILENAME
    mv shellcheck-v${VERSION}/shellcheck ~/.local/bin/shellcheck
    chmod +x ~/.local/bin/shellcheck
}
