export JUST_IIOT_PATH=$HOME/code/iiot-platform/utilities/iiot-utils
export DEFAULT_CODE_DIR=$HOME/code/

# Source any user specfic credentials that can be used wtihin the customisations
if [ -f ~/.bash/.secrets ]; then
    . ~/.bash/.secrets
fi

[[ -f /usr/share/bash-completion/bash_completion ]] &&  source /usr/share/bash-completion/bash_completion
