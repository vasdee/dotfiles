#!/bin/sh

. ../../lib/lib.sh

linux() {

    rm -rf ~/.local/pycharm/
    rootdo unlink /usr/local/share/applications/pycharm.desktop
    rootdo rm -rf /opt/pycharm/
}
