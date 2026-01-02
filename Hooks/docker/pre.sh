#!/bin/sh

. ../../lib/lib.sh

fedora() {
    rootdo dnf config-manager addrepo --from-repofile https://download.docker.com/linux/$OS_ID/docker-ce.repo
    rootdo dnf update
    rootdo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    rootdo systemctl enable --now docker
    rootdo usermod -a -G docker,wheel $USER
}

debian() {
    # Add Docker's official GPG key:
    rootdo apt update
    rootdo apt install -y ca-certificates curl
    rootdo install -m 0755 -d /etc/apt/keyrings
    rootdo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    rootdo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    rootdo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

    rootdo apt update
    rootdo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    rootdo systemctl enable --now docker
    rootdo usermod -a -G docker,wheel $USER
}

ubuntu() {
    # Add Docker's official GPG key:
    rootdo apt update
    rootdo apt install ca-certificates curl
    rootdo install -m 0755 -d /etc/apt/keyrings
    rootdo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    rootdo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    rootdo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

    rootdo apt update
    rootdo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    rootdo systemctl enable --now docker
    rootdo usermod -a -G docker,wheel $USER
}
