
if [ command -v starship &>/dev/null ] && [ -f ~/.starship.toml ]; then

    export STARSHIP_CONFIG=~/.starship.toml
    eval "$(starship init zsh)"

fi
