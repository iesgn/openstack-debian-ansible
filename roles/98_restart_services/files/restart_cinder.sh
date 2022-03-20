#!/bin/bash
for service in api scheduler; do
systemctl restart cinder-$service
done 
