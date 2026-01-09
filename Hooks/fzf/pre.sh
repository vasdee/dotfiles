#!/bin/sh

. ../../lib/lib.sh

linux() {
    LATEST_VERSION=$(github_latest_tag "junegunn/fzf")
    VERSION=${FZF_VERSION:=$LATEST_VERSION}
    FILENAME="fzf-${VERSION}-linux_amd64.tar.gz"
    curl -sOL https://github.com/junegunn/fzf/releases/download/v${VERSION}/${FILENAME}
    tar xzf ${FILENAME}
    mv ./fzf ~/.local/bin/fzf
}
