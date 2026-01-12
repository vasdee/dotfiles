#!/bin/sh

CLONE_URL=${CLONE_URL:="https://github.com/vasdee/dotfiles.git"}
LOCAL_CLONE_PATH=${LOCAL_CLONE_PATH:=~/.config/dotfiles}
DOTFILES_TAG=""
LOCAL_BIN="$HOME/.local/bin"

echo "Starting dotfile install"

echo "Cloning $CLONE_URL to $CLONE_DIR"
mkdir -p $LOCAL_CLONE_PATH $LOCAL_BIN

GIT_OPTIONS=""
if [ -n "${DOTFILES_TAG}" ]; then
    GIT_OPTIONS="--branch $DOTFILES_TAG"
fi
git clone $GIT_OPTIONS $CLONE_URL $LOCAL_CLONE_PATH

echo "linking tuckr to ~/.local/bin/tuckr - make sure this is set in your path or run bash or zsh hooks"
ln -s $LOCAL_CLONE_PATH/bin/$(uname -s)/$(uname -m)/tuckr ~/.local/bin/tuckr

# Add the path temporarily
export PATH=$LOCAL_BIN:$PATH

echo "Finished install!"
echo "$HOME/.local/bin has been added to PATH for the current session only."
echo "Consider adding ~/.local/bin permanently to your PATH or; "
echo "run tuckr set bash ( or zsh ) to get it linked in for you now"
