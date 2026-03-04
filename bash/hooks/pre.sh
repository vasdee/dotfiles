#!/bin/sh


# Make the completions directory in advance, which will be used for dynamic and static completions
generic() {
    add_line_to_file "source ~/.bashrc-custom" ~/.bashrc
    mkdir -p ~/.local/share/bash-completion/completions/
    mkdir -p ~/.bashrc.d/
}
