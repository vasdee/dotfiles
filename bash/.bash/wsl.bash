# Do specific  WSL things if the conf file exists
# To force this to happen, sudo touch /etc/wsl.conf an empty file
if [ -f /etc/wsl.conf ]; then

    # Set the display server from the gateway set by wsl
    #export DISPLAY=$(awk '/nameserver/ {print $2}' /etc/resolv.conf):0.0

    # Set an alias for the Windows User profile area
    export WINPROFILE=/mnt/c/Users/${USER}

    export PROJECTS=/mnt/c/Projects/

    # A stupid workaround to WSLg losing the X11 server socket
    function wsl_fix_x11_socket()
    {
	sudo rm -r /tmp/.X11-unix && ln -s /mnt/wslg/.X11-unix /tmp/.X11-unix
    }

    wsl_fix_x11_socket
    # For use within az login commands, this allows windows edge browser to open the interactive
    # loging auth screen
    #export BROWSER='/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe'
    # Useful for x-server displaying of apps
    #export LIBGL_ALWAYS_INDIRECT=1
fi
