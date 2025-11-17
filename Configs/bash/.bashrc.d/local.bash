export JUST_IIOT_PATH=$HOME/.config/just/justfile

# Source any user specfic credentials that can be used wtihin the customisations
if [ -f ~/.bash/.secrets ]; then
    . ~/.bash/.secrets
fi

[[ -f /usr/share/bash-completion/bash_completion ]] &&  source /usr/share/bash-completion/bash_completion
