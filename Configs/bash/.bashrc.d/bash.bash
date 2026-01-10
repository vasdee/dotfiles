########################################################################################################################
# Some nice aliases and functions
########################################################################################################################
alias hs="history | grep -i"
alias ll="ls -1ABhlv --group-directories-first"
alias la='ls -A'
alias l='ls -CF'

# If we have fd, use it for faster git dir finding
if command -v "fd" >/dev/null 2>&1; then
    alias gitdirs="fd -t d --prune -H "\.git" -c never ${DEFAULT_CODE_DIR:-$PWD} | xargs -n 1 dirname | sort -u"
else
    alias gitdirs="find ${DEFAULT_CODE_DIR:-$PWD} -type d -name '.git' -prune -exec dirname {} \; | sort -u"
fi

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

# parse your netrc file for a credential from a given machine
# $1 machine match criteria
# $2 credential [machine|login|password] default password
function netrc-credential {
    match=$1
    case "$2" in
        machine)
            field_num=2
            ;;
        login)
            field_num=4
            ;;
        password)
            field_num=6
            ;;
        *)
            exit 1
            ;;
    esac
    awk -v machine="$match" -v RS="" -v field_num="$field_num" \
        '/^machine[[:space:]]*(.*)[[:space:]]*login(.*)[[:space:]]*password(.*)$/ $2 ~ machine { print $field_num }' \
        ~/.netrc
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
