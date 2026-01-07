#!/bin/sh

. ../../lib/lib.sh

fedora() {
    rootdo dnf install -y nodejs-npm
    mkdir -p ~/.local/lib/node_modules
    npm config set prefix '~/.local'
}
