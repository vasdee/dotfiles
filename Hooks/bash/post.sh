#!/bin/bash
echo "Attempting to run bash post install script"

SOURCE_LOCAL_BASHRC_CMD=". ~/.bashrc-local.bash"

if ! grep -q "$SOURCE_LOCAL_BASHRC_CMD" ~/.bashrc; then
    echo "Adding $SOURCE_LOCAL_BASHRC_CMD local bashrc for to .bashrc"
    echo "$SOURCE_LOCAL_BASHRC_CMD" >> ~/.bashrc
fi

