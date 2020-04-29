# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

if [ -d ~/.bash ]; then
    for f in ~/.bash/*; do
        . ${f}
    done
fi

