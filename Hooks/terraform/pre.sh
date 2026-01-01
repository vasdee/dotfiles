#!/bin/sh

. ../../lib/lib.sh

fedora_install() {
    rootdo dnf config-manager addrepo --from-repofile https://rpm.releases.hashicorp.com/$ID/hashicorp.repo
    rootdo dnf update
    rootdo dnf install -y terraform
}

install_for_os
