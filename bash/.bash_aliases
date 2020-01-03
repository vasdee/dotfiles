#!/bin/bash

HTTP_PROXY=http://proxy-bne.bhpbilliton.net:8080
HTTPS_PROXY=http://proxy-bne.bhpbilliton.net:8081

function enable_proxy() {
    echo "Proxy enabled"
    export HTTP_PROXY=$HTTP_PROXY
    export HTTPS_PROXY=$HTTPS_PROXY
    export http_proxy=$HTTP_PROXY
    export https_proxy=$HTTPS_PROXY
 
    alias apt-get="apt-get -o Acquire::http::proxy=true"
    sed -i 's/^ #ProxyCommand/ ProxyCommand/g' ~/.ssh/config
}


function disable_proxy() {

    echo "Proxy disabled"

    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset http_proxy
    unset https_proxy

    alias apt-get="apt-get -o Acquire::http::proxy=false"
    sed -i 's/^ ProxyCommand/ #ProxyCommand/g' ~/.ssh/config
}
