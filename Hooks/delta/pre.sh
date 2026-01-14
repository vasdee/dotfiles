#!/bin/sh

. ../../lib/lib.sh

arch() {
    rootdo pacman -S --noconfirm git-delta
}

fedora() {
    rootdo dnf install -y git-delta
}

debian() {
    rootdo apt install -y git-delta
}

ubuntu() {
    debian
}

steamos() {
    arch
}

macos() {
    brew install git-delta
}

linux() {
    # Fallback for Linux distros without package manager support
    LATEST_VERSION=$(github_latest_tag "dandavison/delta")
    VERSION=${DELTA_VERSION:=$LATEST_VERSION}
    FILENAME="delta-${VERSION}-$(uname -m)-unknown-linux-gnu.tar.gz"
    curl -fOL "https://github.com/dandavison/delta/releases/download/${VERSION}/${FILENAME}"
    tar -xzf ${FILENAME}
    mv delta-${VERSION}-$(uname -m)-unknown-linux-gnu/delta ~/.local/bin/
    chmod +x ~/.local/bin/delta
}
