
function touchpath { mkdir -p "$(dirname "$1")" && touch "$1" ; }

if [ -f ~/.localsettings ]; then
    set -a
    source ~/.localsettings
    set +a
fi
