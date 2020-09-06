export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=10000
export HISTSIZE=10000
export HISTIGNORE="ls:ps:history:youtube-dl"
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
