
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source any user specfic credentials that can be used wtihin the customisations
if [ -f ~/.bash/.secrets ]; then
    . ~/.bash/.secrets
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin/:$PATH"
fi

# Include the custom bash scripts
if [ -d ~/.bash ]; then
    for f in ~/.bash/*.bash; do
        . ${f}
    done
fi

[[ -f /usr/share/bash-completion/bash_completion ]] &&  source /usr/share/bash-completion/bash_completion

export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
