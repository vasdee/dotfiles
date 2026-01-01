#!/bin/sh

. ../../lib/lib.sh

linux_install() {
    # This works for both linux and macos, however some might prefer to install from homebrew
    curl -sL https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
}

macos_install() {
    brew install jesseduffield/lazydocker/lazydocker
}

install_for_os
