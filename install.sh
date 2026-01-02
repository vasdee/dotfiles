#!/bin/bash

echo "Starting dotfile install"

read -p "Enter your default code base directory. [default: ~/code]" DEFAULT_CODE_DIR
DEFAULT_CODE_DIR=${DEFAULT_CODE_DIR:-~/code}

echo "Creating ~/.localsettings file with DEFAULT_CODE_DIR=$DEFAUL_CODE_DIR entry"
echo "DEFAULT_CODE_DIR=${DEFAULT_CODE_DIR}" >> ~/.localsettings

CLONE_DIR=$DEFAULT_CODE_DIR/github.com/vasdee/dotfiles
echo "Cloning https://github.com/vasdee/dotfiles.git to $CLONEDIR"
mkdir -p $CLONE_DIR
git clone https://github.com/vasdee/dotfiles.git $CLONEDIR
cd $CLONEDIR

echo "linking tuckr to ~/.local/bin/tuckr - make sure this is set in your path or run bash or zsh hooks"
ln -s $PWD/bin/$(uname -s)/tuckr $HOME/.local/bin/tuckr

echo "linking dot files to common config area - ~/.config/dotfiles"
ln -s $PWD $HOME/.config/dotfiles

echo "Finished install!"
echo "Consider adding ~/.local/bin to your PATH or "
echo "run ~/.local/bin/tuckr set bash ( or zsh ) to get"
echo "it linked in for you"
