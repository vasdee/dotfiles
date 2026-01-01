#!/bin/sh

. ../../lib/lib.sh


linux_install() {
    echo "Downloading AWS executable"
    curl -s "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    ./aws/install --bin-dir $HOME/.local/bin/ --install-dir $HOME/.local/awscli/ --update
    rm awscliv2.zip
    test -d aws && rm -rf aws
}

install_for_os
