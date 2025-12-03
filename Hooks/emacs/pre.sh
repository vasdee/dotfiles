#!/bin/sh

installs="emacs-pgtk"

if [ -n "$WSLENV" ]; then
    installs="$installs wl-clipboard"

fi

sudo dnf install -y $installs
