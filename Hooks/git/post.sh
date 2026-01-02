#!/bin/sh
# Installs some nicely curated global ignores
# Check out https://github.com/github/gitignore for more

. ../../lib/lib.sh


GLOBAL_IGNORES="\
        Global/Ansible.gitignore \
        Global/JetBrains.gitignore \
        Global/Linux.gitignore \
        Global/Emacs.gitignore \
        Global/macOS.gitignore \
        Global/VisualStudioCode.gitignore \
        Global/VirtualEnv.gitignore \
        Global/Windows.gitignore \
        Dotnet.gitignore \
        Python.gitignore \
        Terraform.gitignore \
"

GLOBAL_IGNORE_FILE=${HOME}/.config/git/ignore

generic() {
    mkdir -p $(dirname ${GLOBAL_IGNORE_FILE})

    # reset the file or create it
    > ${GLOBAL_IGNORE_FILE}

    echo "Downloading common gitignores from https://github.com/github/gitignore..."
    for ignore_file in $GLOBAL_IGNORES; do
        echo "" >> ${GLOBAL_IGNORE_FILE}
        echo "## Start ${ignore_file}" >> ${GLOBAL_IGNORE_FILE}
        curl -sL https://raw.githubusercontent.com/github/gitignore/refs/heads/main/${ignore_file} >> ${GLOBAL_IGNORE_FILE}
        echo "## End ${ignore_file}" >> ${GLOBAL_IGNORE_FILE}
    done
}
