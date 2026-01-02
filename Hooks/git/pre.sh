#!/bin/sh

. ../../lib/lib.sh

echo "Gathering some information that will be used for git work or private  configurations"
printf "%-50s\n" "Is this a [work] or [private] configuration? [default private]"
read conf_type
printf "%-50s\n" 'Author name for git commits? '
read git_author
printf "%-50s\n" 'Email for git commits? '
read git_email
printf "%-50s\n" 'Base directory for git clones? [default ~/code/] '
read default_dir

default_dir=${default_dir:-~/code}
conf_type=${conf_type:-private}
conf_type_lower=$(echo $conf_type | tr '[:upper:]' '[:lower:]')
conf_type_upper=$(echo $conf_type | tr '[:lower:]' '[:upper:]')

add_line_to_file "${conf_type_upper}_GIT_AUTHOR_NAME=\"$git_author\"" ~/.localsettings
add_line_to_file "${conf_type_upper}_GIT_AUTHOR_EMAIL=\"$git_email\"" ~/.localsettings
add_line_to_file "DEFAULT_CODE_DIR=$default_dir" ~/.localsettings

echo "Contents of ~/.localsettings"
cat ~/.localsettings
echo

cat <<EOF >~/.gitconfig-${conf_type_lower}
[user]
        name = ${git_author}
        email = ${git_email}
EOF

echo "Custom work include for gitconfig has been created at ~/.gitconfig-${conf_type_lower}"
cat ~/.gitconfig-${conf_type_lower}
