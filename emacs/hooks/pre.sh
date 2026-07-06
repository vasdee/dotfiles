#!/bin/sh


fedora() {
   installs="emacs-pgtk aspell aspell-en jetbrains-mono-fonts-all cascadia-code-nf-fonts cascadia-mono-nf-fonts source-foundry-hack-fonts"

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
    mkdir -p "${CAIFS_INSTALL_DIR}/share/font"

    LATEST_VERSION=$(gitlab_latest_release "ryanoasis/nerd-fonts")

    DL_LINK="https://github.com/ryanoasis/nerd-fonts/releases/download/v${LATEST_VERSION}"

    FONT_ARCHIVES="Iosevka FiraCode FiraMono Inconsolata"

    for archive in $FONT_ARCHIVES; do
        curl -LO "${DL_LINK}/${archive}.tar.xz"

        tar -xvf "${archive}" -C "${CAIFS_INSTALL_DIR}/share/font"
    done

    echo "updating font cache...."
    fc-cache -fv
}
