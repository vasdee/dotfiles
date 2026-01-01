
alias hs="history | grep -i"
alias ll="ls -lah --group-directories-first"
alias la='ls -A'
alias l='ls -CF'
alias gitdirs="find ${DEFAULT_CODE_DIR:-$PWD} -type d -name '.git' -exec dirname {} \;"
alias gitchooser='cd $(gitdirs | fzf)'

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

if [ -n "$WSLENV" ]; then
    echo "We are in WSL environment, setting some custom hacks..."

    alias explorer="explorer.exe"

    # Set an alias for the Windows User profile area
    export WINPROFILE=/mnt/c/Users/${USER}

    # Just because it's provided, doesn't mean you should use this area
    export PROJECTS=/mnt/c/Projects/

    # A stupid workaround to WSLg losing the X11 server socket
    function wsl_fix_x11_socket()
    {
	sudo rm -r /tmp/.X11-unix && ln -s /mnt/wslg/.X11-unix /tmp/.X11-unix
    }

    #wsl_fix_x11_socket

    # For use within az login commands, this allows windows edge browser to open the interactive
    # login auth screen. This may no longer be required with recent versions of azure cli
    #export BROWSER=/usr/bin/wslview


    export COLORTERM=truecolor
fi

# if local settings file is present, then treat as a .env file and export the variables by default
if [ -f ~/.localsettings ]; then
    set -a
    source ~/.localsettings
    set +a
fi
