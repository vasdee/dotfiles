#!/bin/sh

. ../../lib/lib.sh

debian() {
    # Add Docker's official GPG key:
    rootdo install -m 0755 -d /etc/apt/keyrings && \
    rootdo curl -fsSL https://download.docker.com/linux/$OS_ID/gpg -o /etc/apt/keyrings/docker.asc && \
    rootdo chmod a+r /etc/apt/keyrings/docker.asc && \
    (rootdo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF
    ) && \
    rootdo apt update && \
    rootdo apt install -y docker-ce-cli docker-buildx-plugin docker-compose-plugin && \
    rootdo apt -y clean

}

fedora() {
    rootdo dnf config-manager addrepo --overwrite --from-repofile https://download.docker.com/linux/$OS_ID/docker-ce.repo && \
    rootdo dnf install -y docker-ce-cli docker-buildx-plugin docker-compose-plugin
}
