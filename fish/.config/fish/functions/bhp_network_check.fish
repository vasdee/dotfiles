# Get the list of BHP CONNECTION UUIDs via ( this can be VPN or WIFI)
# nmcli connection
# Place this file in $HOME/.config/fish/functions
# add bhp_network_check to the bottom of $HOME/.config/fish/config.fish

set BHP_CONNECTION_UUIDS 39a026f2-91e1-4279-bbf9-45d49d41c1a0 81cf5c38-6fe5-4c17-bfe5-d247ca3d0f1e
set -x PROXY_AUTH millrt9:Sniffles1111%21

function bhp_network_check

    set ACTIVE_CONNECTION_UUIDS (nmcli -t -f uuid connection show --active)

    for con in $BHP_CONNECTION_UUIDS

        if contains $con $ACTIVE_CONNECTION_UUIDS
            bhp_pproxy_on
	    echo -n '(bhp)'
            return
        end

    end

    bhp_proxy_off
    echo -n '(home)'
end


function bhp_proxy_on
    set -x -g https_proxy http://$PROXY_AUTH@10.17.236.44:8081
    set -x -g http_proxy http://$PROXY_AUTH@10.17.236.44:8080
    set -x -g no_proxy localhost,.bhpbilliton.net
	
    sed -i 's/^ #ProxyCommand/ ProxyCommand/g' ~/.ssh/config
end



function bhp_proxy_off
    set -e -g https_proxy
    set -e -g http_proxy
    set -e -g HTTP_PROXY
    set -e -g HTTPS_PROXY
    set -e -g no_proxy
	
    sed -i 's/^ ProxyCommand/ #ProxyCommand/g' ~/.ssh/config
end
