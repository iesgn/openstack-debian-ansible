#!/bin/bash
for service in api l3-agent linuxbridge-agent; do
systemctl restart neutron-$service
done 

