#!/bin/sh

installs="emacs-pgtk aspell aspell-en"

if [ -n "$WSLENV" ]; then
    installs="$installs wl-clipboard"

fi

sudo dnf install -y $installs
