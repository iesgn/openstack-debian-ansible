#!/bin/sh

# This script checks if default route is defined via br-ex, when it's not
# all the configuration is made in order to define properly the external
# connection via br-ex

/sbin/ip route |grep default |grep br-ex

if [ $? -ne 0 ]; then
    /sbin/ip route del default
    /sbin/ip addr del {{ network_node_external_ip }}/{{ network_node_external_CIDR }} dev {{ ext_net_nic }}
    /sbin/ip link set br-ex up
    /usr/bin/ovs-vsctl add-port br-ex {{ ext_net_nic }}
    /sbin/ip link set {{ ext_net_nic }} promisc on
    /sbin/ip addr add {{ network_node_external_ip }}/{{ network_node_external_CIDR }} dev br-ex
    /sbin/ip route add default via {{ external_gateway }}
fi

