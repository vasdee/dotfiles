#!/bin/sh


fedora() {
    installs="emacs-pgtk \
              aspell aspell-en \
              jetbrains-mono-fonts-all \
              cascadia-code-nf-fonts \
              cascadia-mono-nf-fonts \
              source-foundry-hack-fonts \
              google-noto-emoji-color-fonts"

   if [ -n "$WSLENV" ] ; then
       installs="$installs wl-clipboard"

   fi

   rootdo dnf install -y $installs

   linux
}

bazzite() {
    flathub install org.gnu.emacs
    brew install --cask font-jetbrains-mono-nerd-font font-hack-nerd-font

    linux

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

    linux
}

linux() {

    # useful tool for multiplexing lsp servers outside of emacs
    uv_install rassumfrassum

    # install fonts
    mkdir -p "${CAIFS_INSTALL_DIR}/share/fonts"

    DL_LINK="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/"

    FONT_ARCHIVES="JetBrainsMono Iosevka FiraCode FiraMono Inconsolata"

    for archive in $FONT_ARCHIVES; do
        curl -LO "${DL_LINK}/${archive}.tar.xz"

        tar -xvf "${archive}.tar.xz" -C "${CAIFS_INSTALL_DIR}/share/fonts"
    done

    caifs_install

    echo "updating font cache...."
    fc-cache -fv
}
