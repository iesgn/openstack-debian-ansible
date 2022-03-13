# Post Install

## Subir imagen Cirros

```
source admin_openrc.sh

wget http://download.cirros-cloud.net/0.5.1/cirros-0.5.1-x86_64-disk.img

openstack image create --container-format=bare --disk-format=qcow2 \
 --file cirros-0.5.1-x86_64-disk.img "Cirros 0.5.1"

openstack image set --public "Cirros 0.5.1"
```

## Crear flavor

```
openstack flavor create m1.tiny --id 1 \
    --ram 512 --disk 1 --vcpus 1
```

## Crear red externa

```
openstack network create  --share --external \
  --provider-physical-network provider \
  --provider-network-type flat ext-net

openstack subnet create --network ext-net \
  --allocation-pool start=172.22.200.1,end=172.22.201.254 \
  --dns-nameserver 192.168.202.2 --gateway 172.22.0.1 \
  --subnet-range 172.22.0.0/16 ext-subnet
```

## Crear red y router demo

```
source demo_openrc.sh
openstack network create red_demo
openstack subnet create --network red_demo --subnet-range 10.0.0.0/24 subred_demo

openstack router create router_demo
openstack router set router_demo --external-gateway ext-net
openstack router add subnet router_demo subred_demo
```

## Crear instancia

```
openstack server create --flavor m1.tiny \
 --image "Cirros 0.5.1" \
 --security-group default \
 --network "red_demo" \
 instancia_prueba
```

```
openstack security group rule create --protocol tcp --remote-ip 0.0.0.0/0 --dst-port 80 default

openstack security group rule create --protocol icmp  default
```


```
openstack floating ip create ext-net

openstack server add floating ip instancia_prueba <IP>
```
