#!/bin/bash

alias hs="history | grep -i"


function docker_client_proxy_on() {
    sed -iE "s|\"httpProxy\":.*$|\"httpProxy\": \"${LOCAL_HTTP_PROXY}\",|g" ~/.docker/config.json
    sed -iE "s|\"httpsProxy\":.*$|\"httpsProxy\": \"${LOCAL_HTTP_PROXY}\",|g" ~/.docker/config.json
    sed -iE "s|\"noProxy\":.*$|\"noProxy\": \"${LOCAL_NO_PROXY}\"|g" ~/.docker/config.json

}

function docker_client_proxy_off() {
    sed -iE "s|\"httpProxy\":.*$|\"httpProxy\": \"\",|g" ~/.docker/config.json
    sed -iE "s|\"httpsProxy\":.*$|\"httpsProxy\": \"\",|g" ~/.docker/config.json
    sed -iE "s|\"noProxy\":.*$|\"noProxy\": \"\"|g" ~/.docker/config.json
}


function ssh_proxy_on() {
    sed -Ei "s|^ (##)?ProxyCommand.*$| ProxyCommand ncat --proxy $LOCAL_HTTPS_PROXY %h %p|g" ~/.ssh/config
}

function ssh_proxy_off() {
    sed -iE "s|^ ProxyCommand.*$| ##ProxyCommand|g" ~/.ssh/config
}

function git_proxy_on() {
    git_proxy_off
    git config --global --add http.proxy ${LOCAL_HTTP_PROXY}
    git config --global --add https.proxy ${LOCAL_HTTPS_PROXY}
}

function git_proxy_off() {
    git config --global --unset-all http.proxy
    git config --global --unset-all https.proxy
}

function enable_proxy() {
    echo "Proxy enabled"
    export HTTP_PROXY=${LOCAL_HTTP_PROXY}
    export HTTPS_PROXY=${LOCAL_HTTPS_PROXY}
    export http_proxy=${LOCAL_HTTP_PROXY}
    export https_proxy=${LOCAL_HTTPS_PROXY}
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
