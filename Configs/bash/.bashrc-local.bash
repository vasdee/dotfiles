export JUST_IIOT_PATH=$HOME/.config/just/justfile

# Source any user specfic credentials that can be used wtihin the customisations
if [ -f ~/.bash/.secrets ]; then
    . ~/.bash/.secrets
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin/:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin/:$PATH"
fi


[[ -f /usr/share/bash-completion/bash_completion ]] &&  source /usr/share/bash-completion/bash_completion

export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
