#!/bin/sh

# Assume a netrc file exists with entries for github
export DEFAULT_CODE_DIR="${DEFAULT_CODE_DIR:-$HOME/code}"

mkdir -p ~/code/private/github/vasdee/ ~/.local/share/caifs-collections ~/.local/bin ~/.local/lib

echo "Installing CAIFS and COMMON"
curl -sL https://raw.githubusercontent.com/caifs-org/caifs/refs/heads/main/install.sh | sh

echo "Installing dotfiles"
git clone https://github.com/vasdee/dotfiles.git -C ~/code/private/github/vasdee/
cd ~/code/private/github/vasdee/dotfiles || exit
ln -s "${PWD}" ~/.local/share/caifs-collections/dotfiles

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
      rust-dev \
      shellcheck \
      shfmt \
      ssh \
      starship \
      tmux \
      ty \
      watchexec \
      yaml-language-server
