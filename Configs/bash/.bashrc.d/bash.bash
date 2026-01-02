########################################################################################################################
# Some nice aliases and functions
########################################################################################################################
alias hs="history | grep -i"
alias ll="ls -lah --group-directories-first"
alias la='ls -A'
alias l='ls -CF'
alias gitdirs="find ${DEFAULT_CODE_DIR:-$PWD} -type d -name '.git' -exec dirname {} \;"
alias gitchooser='cd $(gitdirs | fzf)'
alias dotenv="[[ -f .env ]] && set -a && source .env && set +a"
alias histoff="set +o history"
alias histon="set -o history"

# create a file and the leading directories
function touchpath { mkdir -p "$(dirname "$1")" && touch "$1" ; }

# load a dotenv file at .env or specified via an alternate filename
# $1 = the filepath, default .env
function dotenv {
    local f=${1:-".env"}
    if [ -f ${f} ]; then
        set -a
        source $f
        set +a
    fi
}

function git-clonepath {
    bd=${DEFAULT_CODE_DIR:-${PWD}}
    re='^(https?:\/\/.+:.+@|https?:\/\/|git@|git\+ssh@)(.*\/)([^\/]*\.git)$'

    if [[ $1 =~ $re ]]; then
        ep=${BASH_REMATCH[2]}
        pathchk $ep

        echo "Cloning $1 to $bd/$ep"
        mkdir -p $bd/$ep || true
        cd $bd/$ep

        git clone $1
    else
        echo "Could not pass $1"
        exit 1
    fi

}

########################################################################################################################
# Enable local settings if available.
# This file can contain whatever env vars you like
########################################################################################################################
# if local settings file is present, then treat as a .env file and export the variables by default
if [ -f ~/.localsettings ]; then
    set -a
    source ~/.localsettings
    set +a
fi

########################################################################################################################
# Load completions from standard areas
########################################################################################################################
[[ -f /usr/share/bash-completion/bash_completion ]] &&  source /usr/share/bash-completion/bash_completion
local_completions_dir=~/.local/share/bash-completion/completions/

if [ -d $local_completions_dir ]; then
    for c in $(ls $local_completions_dir); do
        source ${local_completions_dir}/$c
    done
fi

########################################################################################################################
# Some nice history settings
HISTFILE=~/.histfile
export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=10000
export HISTSIZE=10000
export SAVEHIST=10000
export HISTIGNORE="ls:ps:history"
