#!/bin/sh


fedora() {
   installs="emacs-pgtk aspell aspell-en jetbrains-mono-fonts-all cascadia-code-nf-fonts cascadia-mono-nf-fonts source-foundry-hack-fonts"

   if [ -n "$WSLENV" ] ; then
       installs="$installs wl-clipboard"

   fi

   rootdo dnf install -y $installs
   uv_install rassumfrassum
}

bazzite() {
    flathub install org.gnu.emacs
    brew install --cask font-jetbrains-mono-nerd-font font-hack-nerd-font
    uv_install rassumfrassum
   
}

steamos() {
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

    uv_install rassumfrassum
}

linux() {

    # useful tool for multiplexing lsp servers outside of emacs
    uv_install rassumfrassum
}
