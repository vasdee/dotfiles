#!/bin/bash

CLONE_URL=${CLONE_URL:="https://github.com/vasdee/dotfiles.git"}
LOCAL_CLONE_PATH=${LOCAL_CLONE_PATH:="private/github.com/vasdee/dotfiles"}

echo "Starting dotfile install"

read -p "Enter your default code base directory. [default: ~/code]" DEFAULT_CODE_DIR
DEFAULT_CODE_DIR=${DEFAULT_CODE_DIR:-~/code}

echo "Creating ~/.localsettings file with DEFAULT_CODE_DIR=$DEFAULT_CODE_DIR entry"
echo "DEFAULT_CODE_DIR=${DEFAULT_CODE_DIR}" >> ~/.localsettings

CLONE_DIR=${DEFAULT_CODE_DIR}/${LOCAL_CLONE_PATH}
echo "Cloning $CLONE_URL to $CLONE_DIR"
mkdir -p $CLONE_DIR
git clone $CLONE_URL $CLONE_DIR
cd $CLONE_DIR

echo "linking tuckr to ~/.local/bin/tuckr - make sure this is set in your path or run bash or zsh hooks"
if [ ! -f $HOME/.local/bin/tuckr ]; then
    ln -s $PWD/bin/$(uname -s)/$(uname -m)/tuckr $HOME/.local/bin/tuckr
else
    echo "link to tuckr in $HOME/.local/bin/tuckr already exists!"
fi

echo "linking dot files to common config area - ~/.config/dotfiles"
if [ ! -d $HOME/.config/dotfiles ]; then
    ln -s $PWD $HOME/.config/dotfiles
else
    echo "$HOME/.config/dotfiles already exists!"
fi

LOCAL_BIN="$HOME/.local/bin"

if [[ ! ":$PATH:" == *:"$LOCAL_BIN":* ]]; then
   PATH=$LOCAL_BIN:$PATH
fi

echo "Finished install!"
echo "$HOME/.local/bin has been added to PATH for the current session only."
echo "Consider adding ~/.local/bin permanently to your PATH or; "
echo "run tuckr set bash ( or zsh ) to get it linked in for you now"
