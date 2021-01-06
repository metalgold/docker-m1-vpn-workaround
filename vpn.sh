# determine your utun interface by running "ifconfig" and look for the utun with an associated IPv4 address
export UTUN_INTF="utun2"

echo "## Previous Configuration"
sudo pfctl -a com.apple.internet-sharing/shared_v4 -s nat 2> /dev/null | tee /tmp/docker_vpn.conf
if sudo pfctl -a com.apple.internet-sharing/shared_v4 -s nat 2> /dev/null | grep 192.168.64.0 | grep -q $UTUN_INTF
then
        echo && echo "Not applying change"
else
        echo "nat on $UTUN_INTF inet from 192.168.64.0/24 to any -> ($UTUN_INTF) extfilter ei" >> /tmp/docker_vpn.conf
        sudo pfctl -a com.apple.internet-sharing/shared_v4 -N -f /tmp/docker_vpn.conf 2> /dev/null
        echo && echo "## New Configuration"
        cat /tmp/docker_vpn.conf
fi
