#!/bin/fish

# from the environment comes
# CONNECTION_UUID, action= up | vpn-up
# $1 == The Device name, e.g eth0/enp0s25, tun0
# $2 == The Connection state, e.g up/down, vpn-up
set LOG /tmp/NetworkManager_dispatcher.d.log

set USER vasdee
set UID 1000

set BHP_CONNECTION_UUIDS 39a026f2-91e1-4279-bbf9-45d49d41c1a0 81cf5c38-6fe5-4c17-bfe5-d247ca3d0f1e a0cb3713-6bab-4a75-bbcc-0a7a7917e686

echo "Checking network type for $argv and $CONNECTION_UUID" >> $LOG

switch $argv[2]
    case up vpn-up
        for con in $BHP_CONNECTION_UUIDS
            if contains $con $CONNECTION_UUID
                echo "BHP Network detected" >> $LOG
	            sudo -u $USER DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$UID/bus gsettings set org.gnome.system.proxy autoconfig-url 'http://proxypac.ha.bhpbilliton.net/syd-igw3-proxy.pac'
	            sudo -u $USER DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$UID/bus gsettings set org.gnome.system.proxy mode 'auto'
		    exit
            end
        end
        echo "no BHP network detected" >> $LOG
        sudo -u $USER DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$UID/bus gsettings set org.gnome.system.proxy mode 'none'
    case  '*'
        exit
end

