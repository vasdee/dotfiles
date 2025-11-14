VPN_USERNAME=robert.miller1@bhp.com
VPN_PASSWORD='!Sniffles1234'

VPN_CERTIFICATE=~/.ssh/millrt9.crt.pem
VPN_KEY=~/.ssh/millrt9.key.pem

VPN_DOMAINS_OLD="bhp.com bhpapps.com bhpappsdev.com private.birak.cloud ior-mgmt.bhpbilliton.net magnet.bhp.com ent.bhpbilliton.net bhpbilliton.net per0lpmgt01.ior-mgmt.bhpbilliton.net apac.ent.bhpbilliton.net"
VPN_DOMAINS="bhp.com,bhpapps.com,bhpappsdev.com,private.birak.cloud,bhpbilliton.net,bhpbilliton.com,portal.azure.com"
VPN_REMOTE_NETWORKS="10.0.0.0/8 portal.azure.com"

VPN_GATEWAY="vpn.bhp.com/anyconnect"
##BHP_1DESKTOP_ANYCONNECT_CHILE_DIRECT_IKEV2_CONNECTON_PROFILE
#VPN_GATEWAY="scl.vpn.bhp.com/BHP_1DESKTOP_ANYCONNECT_CHILE_DIRECT_IKEV2_CONNECTON_PROFILE"

function vpn_start() {
    echo "${VPN_PASSWORD}" | sudo openconnect \
                                  -v \
                                  --os=win \
                                  -u $VPN_USERNAME \
                                  --passwd-on-stdin \
                                  --certificate "${VPN_CERTIFICATE}"\
                                  --sslkey "${VPN_KEY}" \
                                  --script "vpn-slice --verbose --route-splits --domains-vpn-dns ${VPN_DOMAINS} ${VPN_REMOTE_NETWORKS}" \
                                  $VPN_GATEWAY
}


#vpn-slice --verbose --route-splits --domains-vpn-dns bhp.com,bhpapps.com,bhpappsdev.com,private.birak.cloud,bhpbilliton.net,bhpbilliton.com 10.0.0.0/8

