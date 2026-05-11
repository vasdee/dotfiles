#!/bin/sh


# Make the completions directory in advance, which will be used for dynamic and static completions
generic() {
    add_line_to_file "source ~/.bashrc-custom" ~/.bashrc
    mkdir -p ~/.local/share/bash-completion/completions/
    mkdir -p ~/.bashrc.d/

    # Generate a ~/.localsettings file and DEFAULT_CODE_DIR variable
    if [ ! -f ~/.localsettings ] && [ -z "$DEFAULT_CODE_DIR" ] ; then
        echo "Base directory for git clones? [default ~/code/]"
        read -r default_dir
        default_dir=${default_dir:-~/code}
        echo "DEFAULT_CODE_DIR=$default_dir" > ~/.localsettings
    fi
}
