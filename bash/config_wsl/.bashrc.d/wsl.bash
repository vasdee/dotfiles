if [ -n "$WSLENV" ]; then
    alias explorer="explorer.exe"
    # Set an alias for the Windows User profile area
    export WINPROFILE=/mnt/c/Users/${USER}
    export COLORTERM=truecolor
fi
