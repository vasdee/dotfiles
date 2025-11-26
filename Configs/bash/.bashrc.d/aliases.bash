#!/bin/bash

alias hs="history | grep -i"
alias ll="ls -lah --group-directories-first"
alias cdi="cd ~/code/iiot-platform/"
alias dots="cd ~/dotfiles/"
alias la='ls -A'
alias l='ls -CF'
alias dotenv="[[ -f .env ]] && set -a && source .env && set +a"

# create a file and the leading directories 
function touchpath { mkdir -p "$(dirname "$1")" && touch "$1" ; }

# $1 is the full git url, including https:// or https://user:pass@ or git@ or http variants
function git_clonepath {
    url=$1
    base_dir=${DEFAULT_CODE_DIR:-${PWD}}

    # Semi colon is used in sed to separate regular expressions
    local extracted_path=$(echo $url | sed -E 's/^(https?:\/\/.+:.+@|https?:\/\/|git@)//;s/(\/[^\/]*\.git$)//')

    pathchk $extracted_path
    
    echo "Cloning $url to $base_dir/$extracted_path"
    mkdir -p $base_dir/$extracted_path || true
    cd $base_dir/$extracted_path

    git clone $url
}

