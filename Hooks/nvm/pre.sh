#!/bin/sh

. ../../lib/lib.sh


has "bash"
has "curl"

# disable the automatic profile installation because it tampers directly with the ~/.bashrc or ~/.zshrc files
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash'
