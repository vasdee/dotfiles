#!/bin/bash

alias hs="history | grep -i"
alias ll="ls -lah --group-directories-first"
alias cdi="cd ~/code/iiot-platform/"
alias cdd="cd ~/code/dash/"
alias dots="cd ~/dotfiles/"
alias la='ls -A'
alias l='ls -CF'
alias dotenv="[[ -f .env ]] && set -a && source .env && set +a"

function docker_client_proxy_on() {
    sed -iE "s|\"httpProxy\":.*$|\"httpProxy\": \"${LOCAL_PROXY_DOMAIN}\",|g" ~/.docker/config.json
    sed -iE "s|\"httpsProxy\":.*$|\"httpsProxy\": \"${LOCAL_PROXY_DOMAIN}\",|g" ~/.docker/config.json
    sed -iE "s|\"noProxy\":.*$|\"noProxy\": \"${LOCAL_NO_PROXY}\"|g" ~/.docker/config.json

}

function docker_client_proxy_off() {
    sed -iE "s|\"httpProxy\":.*$|\"httpProxy\": \"\",|g" ~/.docker/config.json
    sed -iE "s|\"httpsProxy\":.*$|\"httpsProxy\": \"\",|g" ~/.docker/config.json
    sed -iE "s|\"noProxy\":.*$|\"noProxy\": \"\"|g" ~/.docker/config.json
}


function ssh_proxy_on() {
    alias ssh="ssh -o ProxyCommand=\"ncat --proxy ${LOCAL_PROXY_DOMAIN} %h %p\""
}

function ssh_proxy_off() {
    [[ $(type -t ssh) == "alias" ]] && unalias ssh
}

function git_proxy_on() {
    export GIT_SSH_COMMAND="ssh -o ProxyCommand=\"ncat --proxy ${LOCAL_PROXY_DOMAIN} %h %p\""
    git config --local --add http.proxy ${LOCAL_PROXY_DOMAIN}
    git config --local --add https.proxy ${LOCAL_PROXY_DOMAIN}
}

function git_proxy_off() {
    unset GIT_SSH_COMMAND
    git config --local --unset-all http.proxy
    git config --local --unset-all https.proxy
}

function enable_proxy() {
    echo "Proxy enabled"
    export HTTP_PROXY=${LOCAL_PROXY_DOMAIN}
    export HTTPS_PROXY=${LOCAL_PROXY_DOMAIN}
    export http_proxy=${LOCAL_PROXY_DOMAIN}
    export https_proxy=${LOCAL_PROXY_DOMAIN}
    export NO_PROXY=${LOCAL_NO_PROXY}
    export no_proxy=${LOCAL_NO_PROXY}

    git_proxy_on
    docker_client_proxy_on
    ssh_proxy_on
}


function disable_proxy() {

    echo "Proxy disabled"

    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset http_proxy
    unset https_proxy
    unset NO_PROXY
    unset no_proxy

    git_proxy_off
    docker_client_proxy_off
    ssh_proxy_off
}
