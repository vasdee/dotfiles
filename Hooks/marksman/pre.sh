#!/bin/sh

MARKSMAN_VERSION="2025-11-30"

linux() {
    curl --output-dir ~/.local/bin -o marksman -L --create-dirs https://github.com/artempyanykh/marksman/releases/download/${MARKSMAN_VERSION}/marksman-linux-x64
    chmod +x ~/.local/bin/marksman
}

macos() {
    brew install marksman
}
