#!/bin/sh

. ../../lib/lib.sh

fedora() {
    rootdo dnf install -y pandoc
}
