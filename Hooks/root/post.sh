#!/bin/bash

. /etc/os-release

echo "Running update-ca-trust for enterprise root certificate"

case "$ID" in
    ubuntu|debian)
        CA_PATH="/usr/local/share/ca-certificates/"
        CA_EXEC="update-ca-certificates"
        ;;
    fedora|rhel)
        echo "Appears to be a fedora or RHEL distrobution"
        CA_PATH="/etc/pki/ca-trust/source/anchors/"
        CA_EXEC="update-ca-trust"
        ;;
    *)
        echo "$PRETTY_NAME not supported as yet"
        ;;
esac

if [ -n "$CA_PATH" ] && [ -n "$CA_EXEC" ]; then

    echo "Importing Enterprise trust CA for $PRETTY_NAME"
    sudo cp /tmp/ent-ca.pem ${CA_PATH}
    eval "sudo $CA_EXEC"
    
fi

