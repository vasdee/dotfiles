# Do specific  WSL things if the conf file exists
# To force this to happen, sudo touch /etc/wsl.conf an empty file
if [ -n "$WSLENV" ]; then
    echo "We are in WSL environment, set some custom hacks..."

    # Set an alias for the Windows User profile area
    export WINPROFILE=/mnt/c/Users/${USER}

    export PROJECTS=/mnt/c/Projects/

    # A stupid workaround to WSLg losing the X11 server socket
    function wsl_fix_x11_socket()
    {
	sudo rm -r /tmp/.X11-unix && ln -s /mnt/wslg/.X11-unix /tmp/.X11-unix
    }

    #wsl_fix_x11_socket

    # For use within az login commands, this allows windows edge browser to open the interactive
    # loging auth screen
    export BROWSER=/usr/bin/wslview
    # Useful for x-server displaying of apps
    #export LIBGL_ALWAYS_INDIRECT=1
    export COLORTERM=truecolor
fi
