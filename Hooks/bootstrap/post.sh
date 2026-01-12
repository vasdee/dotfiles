#!/bin/sh

. ../../lib/lib.sh

# $1 - ca destination path
# $2 - ca update trust bundle command
# $3 - optional prefix to add to the certificate when copying
install_certs() {
    LOCAL_CERT_DIR=~/.local/share/certificates
    for cert in $(ls ${LOCAL_CERT_DIR}); do
        if [ -n "$1" ] && [ -n "$2" ]; then
            echo "Importing CA for $OS_ID"
            rootdo cp ${LOCAL_CERT_DIR}/$cert ${1}/$cert${3}
            rootdo $2
        fi
    done

}

fedora() {
    install_certs "/etc/pki/ca-trust/source/anchors" "update-ca-trust" ".pem"

    rootdo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    rootdo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    rootdo dnf install -y git-core jq
}

debian() {
    rootdo apt install -y jq
    install_certs "/usr/local/share/ca-certificates" "update-ca-certificates" ".crt"
}

ubuntu() {
    debian
}
