#!/bin/sh

. ../../lib/lib.sh


linux() {
    VERSION=${PYCHARM_VERSION:-"2025.3.1"}
    curl -sL -o pycharm.tar.gz https://download-cf.jetbrains.com/python/pycharm-${VERSION}.tar.gz
    rootdo tar xzf pycharm.tar.gz -C /opt
    rootdo mv /opt/pycharm-${VERSION}/ /opt/pycharm/
}
