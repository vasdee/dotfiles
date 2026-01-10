#!/bin/sh

. ../../lib/lib.sh

linux() {
    if [ ! -f $HOME/.local/bin/tuckr ]; then
          ln -s $(realpath ../../bin/$(uname -s)/$(uname -m)/tuckr) $HOME/.local/bin/tuckr
    else
        echo "link to tuckr in $HOME/.local/bin/tuckr already exists!"
    fi

}
