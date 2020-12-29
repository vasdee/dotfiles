# Sourced in interactive shells only.
# It should contain commands to set up aliases, functions, options, key bindings, etc.
# Lines configured by zsh-newuser-install

#source <(antibody init)

unsetopt beep
setopt clobber
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/vasdee/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

if [ -d ~/.zsh ]; then
    for f in ~/.zsh/*; do
        . ${f}
    done
fi

source ~/.zsh_plugins.sh
