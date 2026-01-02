#!/bin/sh

. ../../lib/lib.sh


steamos_install() {
    rootdo pacman -S --noconfirm yt-dlp
}

install_for_os
