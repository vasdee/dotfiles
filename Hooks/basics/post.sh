#!/bin/sh

. ../../lib/lib.sh

# Do the enterprise cert inline, to avoid having to explicity run tuckr with sudo initially
cat > /tmp/ent.pem <<EOF
-----BEGIN CERTIFICATE-----
MIIDQzCCAiugAwIBAgIQQ+RWL0Gu1olK+RGiXBMXuDANBgkqhkiG9w0BAQsFADA0
MTIwMAYDVQQDEylCSFAgQmlsbGl0b24gQXV0aGVudGljYXRpb24gUm9vdCBDQSAt
IEV4dDAeFw0xNTAyMjcwMTE0NDdaFw0zMTAyMjcwMTI0NDVaMDQxMjAwBgNVBAMT
KUJIUCBCaWxsaXRvbiBBdXRoZW50aWNhdGlvbiBSb290IENBIC0gRXh0MIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA36xjPrG7MorwtS8nGGsXk7UhMMsM
l+sicvioT4C4UuhQzey9P7CZ6MF/stFGdOcwBMJwADKWwHGCEM7JuGCBVp3n2ZhX
o/+4XdUxHeEugMV4stacfdgMD2f08dogJ38HmDSNa7aUnNNc2oXasnbKbAn5dFkB
obVW1l/TBYBsrLZWVEArZTKe0DTzENdjUWVo8wJ+tXUw57ROVT8x+OAUqGv1pdm0
llUGT58clb0xXvx9o60pbXfdNaapj/pnCN2pA9QLccoWEPtAW7wh9CKw7Xq4kxQx
QlMqkEvMTgUsb9IedH8VLPnAxzGXKVeauVLGHTR8312BLDXgDQ2q7nqk6QIDAQAB
o1EwTzALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUE6/o
idwFTmIX6wT5U9NotUQobc0wEAYJKwYBBAGCNxUBBAMCAQAwDQYJKoZIhvcNAQEL
BQADggEBABj5t+mhk250Zl92BdzaZ16fzkWbCfr0YOmtg/kmkA3YGxkl90XGqI4V
cDRzMWYfBs2NulyDh4oTeerhTWAeLizjDRV0pkKVIIh+u93pH+bxJKpggaxleenT
jQzWqynO5UFS4n5Tgx8+fXB2tnosl+9pe2MAbfOCbLUYErR6Su+GDe9ABbjwAk/5
xB9qGg18tnwlKEeGTxVigfGKhOlz3HukBfoFr57gx4RIkR47bacY/UZ3/Yd5pXxv
qcg6RYpVDFCN+Yl84ykgveRaoW0IaXhz6c25BDlA6t06cCQPc9M56dwTgkyeWmHT
OGcwmU+m/xxkGoskCZXT/mPFE896+vo=
-----END CERTIFICATE-----
EOF


# $1 - ca destination path
# $2 - ca update trust bundle command
install_corporate_cert() {
    if [ -n "$1" ] && [ -n "$2" ]; then
        echo "Importing Enterprise trust CA for $OS_ID"
        sudo cp /tmp/ent.pem ${1}
        eval "sudo ${2}"
    fi

}

fedora_install() {
    install_corporate_cert "/etc/pki/ca-trust/source/anchors/" "update-ca-trust"

    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y htop btop tmux git-core vim jq
}

debian_install() {
    rootdo apt install -y jq
    install_corporate_cert "/usr/local/share/ca-certificates/" "update-ca-certificates"
}

ubuntu_install() {
    debian_install
}

echo "Importing enterprise root certificate and installing the basics"

sudo ln -s ${HOME}/.config/dotfiles_bhp/bin/${OS_TYPE}/tuckr /usr/local/bin/tuckr
install_for_os
