#!/bin/sh

. ../../lib/lib.sh

generic_install() {
    PS3='Please select a control tower instance: '
    options=("trial.bhp.avassa.net" "Quit")
    select opt in "${options[@]}"
    do
       case $opt in
          "trial.bhp.avassa.net")
             env="trial.bhp.avassa.net"
             break
             ;;
          "Quit")
             exit 0
             ;;
          "*")
             echo "Invalid option"
             exit 1
       esac
    done
    curl --create-dirs -O --output-dir ~/.local/bin/ https://api.${env}/supctl
    chmod +x ~/.local/bin/supctl
    [[ -d ~/.bashrc.d/ ]] && supctl completion bash > ~/.bashrc.d/supctl.bash
    [[ -d ~/.zshrc.d/ ]] && supctl completion zsh > ~/.zshrc.d/supctl.zsh
}

install_for_os
