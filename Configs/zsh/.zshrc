# Sourced in interactive shells only.
# It should contain commands to set up aliases, functions, options, key bindings, etc.
# Lines configured by zsh-newuser-install

ZSH=/usr/share/oh-my-zsh/
ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"
plugins=(git dotnet)

pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

DISABLE_MAGIC_FUNCTIONS=true

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
source /etc/bash_completion.d/azure-cli

if [ -d ~/.zsh ]; then
    for f in ~/.zsh/*; do
        . ${f}
    done
fi
