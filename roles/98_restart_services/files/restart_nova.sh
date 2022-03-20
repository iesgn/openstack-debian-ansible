#!/bin/bash
for service in api api-metadata conductor scheduler spicehtml5proxy serialproxy; do
systemctl restart nova-$service
done 

