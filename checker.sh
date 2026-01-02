#!/bin/sh

HOOK_SCRIPTS=$(find Hooks/ -name "pre*" -or -name "post*" -or -name "rm*" -type f)
RET_CODE=0

for hs in $HOOK_SCRIPTS; do
    echo "Checking $hs for executable bit"
    if [ ! -x $hs ]; then
        chmod +x $hs
        RET_CODE=1
    fi
done

exit $RET_CODE
