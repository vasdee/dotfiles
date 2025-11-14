# Start starship if it is present
if [ -f ~/.starship.toml ]; then
    export STARSHIP_CONFIG=~/.starship.toml
    eval "$(starship init bash)"
fi
