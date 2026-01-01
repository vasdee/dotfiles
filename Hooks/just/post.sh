#!/bin/sh


if [ -d ~/.bashrc.d/ ]; then
    just --completions bash > ~/.bashrc.d/just-completions.bash
fi

if [ -d ~/.zshrc.d/ ]; then
    just --completions zsh > ~/.zshrc.d/just-completions.zsh
fi
