# Do specific  WSL things if the conf file exists
# To force this to happen, sudo touch /etc/wsl.conf an empty file
if [ -f /etc/wsl.conf ]; then

    # Set the display server from the gateway set by wsl
    export DISPLAY=$(awk '/nameserver/ {print $2}' /etc/resolv.conf):0.0

    # Set an alias for the Windows User profile area
    export WINPROFILE=/mnt/c/Users/${USER}

    # Useful for x-server displaying of apps
    export LIBGL_ALWAYS_INDIRECT=1
fi
