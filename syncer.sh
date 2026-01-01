#!/bin/bash

GITDIR=${1:-$HOME/.config/dotfiles_bhp/}
SYNCDIRS="bin Configs Hooks lib"

for d in $SYNCDIRS; do
    rsync -av $GITDIR/$d .
done
