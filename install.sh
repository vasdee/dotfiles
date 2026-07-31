#!/bin/sh

# Assume a netrc file exists with entries for github
export DEFAULT_CODE_DIR="${DEFAULT_CODE_DIR:-$HOME/code}"

mkdir -p ~/code/private/github/vasdee/ ~/.local/share/caifs-collections ~/.local/bin ~/.local/lib ~/code/private/github/caifs-org

# cloning these instead of using the installers because I work on them so often
echo "Installing CAIFS"
git clone https://github.com/caifs-org/caifs.git -C ~/code/private/github/caifs-org
cd ~/code/private/github/caifs-org/caifs
ln -s $PWD/src/bin/caifs ~/.local/bin/caifs
ln -s $PWD/src/lib/caifs ~/.local/lib/caifs

echo "Installing caifs-common"
git clone https://github.com/caifs-org/caifs-common.git -C ~/code/private/github/caifs-org
cd ~/code/private/github/caifs-org/caifs-common
ln -s $PWD ~/.local/share/caifs-collections/caifs-common

echo "installing dotfiles"
git clone https://github.com/vasdee/dotfiles.git -C ~/code/private/github/vasdee/
cd ~/code/private/github/vasdee/dotfiles
ln -s $PWD ~/.local/share/caifs-collections/dotfiles


echo "installing essentials...."

caifs add bootstrap nodejs uv

echo "installing all the rest..."

caifs add \
      ansible-language-server \
      bash \
      basedpyright \
      bash-language-server \
      bump-my-version \
      copier \
      docker \
      devcontainers \
      docker-language-server \
      editorconfig
      emacs \
      fzf \
      git-dev \
      gitu \
      glab \
      ripgrep \
      jq \
      just \
      just-lsp \
      netrc \
      pre-commit \
      ruff \
      rumdl \
      shellcheck \
      shfmt \
      ssh \
      starship \
      tmux \
      ty \
      watchexec \
      yaml-language-server
