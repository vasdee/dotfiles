#!/bin/sh

. ../../lib/lib.sh


linux() {
    VERSION=$(gitlab_latest_tag "gitlab-org%2Fcli")
    FILENAME="glab_${VERSION}_linux_amd64"

    curl -Ls https://gitlab.com/gitlab-org/cli/-/releases/v${VERSION}/downloads/${FILENAME}.tar.gz | tar xvzf -
    mv bin/glab ~/.local/bin/glab
}
