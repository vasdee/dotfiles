#!/bin/sh

generic () {
    for conf_type in $(echo "private work"); do
        conf_file="$HOME/.gitconfig-${conf_type}"

        if [ ! -f "$conf_file" ]; then
            echo "Creating empty $conf_file ( you will need to fill this out )"

            echo "[user]" > "$conf_file"
            echo "    name = " >> "$conf_file"
            echo "    email = " >> "$conf_file"
        fi

    done
}
