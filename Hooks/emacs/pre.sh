#!/bin/sh

. ../../lib/lib.sh

fedora_install() {
   installs="emacs-pgtk aspell aspell-en"

   if [ -n "$WSLENV" ] ; then
       installs="$installs wl-clipboard"

   fi

   sudo dnf install -y $installs
}


steamos_install() {
	echo "installing emacs"
	rootdo pacman -S --noconfirm \
               emacs \
               ttf-hack-nerd \
               ttf-dejavu-nerd \
               ttf-cascadia-mono-nerd \
               ttf-jetbrains-mono-nerd \
               ttf-inconsolata-nerd \
               ttf-nerd-fonts-symbols-mono \
               ttf-nerd-fonts-symbols
}

install_for_os

