#!/bin/sh

. ../../lib/lib.sh


steamos() {
    rootdo pacman -S --noconfirm yt-dlp
}
