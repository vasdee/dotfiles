#!/bin/sh

. ../../lib/lib.sh

echo "Gathering some information that will be used for git work configurations"
printf "%-50s\n" 'Author name for git commits? '
read work_name
printf "%-50s\n" 'Email for git commits? '
read work_email
printf "%-50s\n" 'Base directory for git clones? [default ~/code/] '
read default_dir

if [ -z "$default_dir" ]; then
    default_dir="~/code/"
fi

add_line_to_file "WORK_GIT_AUTHOR_NAME=\"$work_name\"" ~/.localsettings
add_line_to_file "WORK_GIT_AUTHOR_EMAIL=\"$work_email\"" ~/.localsettings
add_line_to_file "DEFAULT_CODE_DIR=$default_dir" ~/.localsettings

echo "Contents of ~/.localsettings"
cat ~/.localsettings
echo

cat <<EOF >~/.gitconfig-work
[user]
        name = $WORK_GIT_AUTHOR_NAME
        email = $WORK_GIT_AUTHOR_EMAIL
EOF

echo "Custom work include for gitconfig has been created at ~/.gitconfig-work"
cat ~/.gitconfig-work
