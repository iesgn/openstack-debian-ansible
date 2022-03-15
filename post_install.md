# Pre-install

En el nodo de red:

```
auto eth0 
iface eth0 inet manual 
up ip link set dev $IFACE up
down ip link set dev $IFACE down
```

Para que tenga internet ponemos como puerta enlace una máquina que haga SNAT.

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


## Lista de flavor

```
openstack flavor list
+----+------------+------+------+-----------+-------+-----------+
| ID | Name       |  RAM | Disk | Ephemeral | VCPUs | Is Public |
+----+------------+------+------+-----------+-------+-----------+
| 10 | m1.nano    |  128 |   10 |         0 |     1 | True      |
| 11 | m1.micro   |  256 |   10 |         0 |     1 | True      |
| 12 | m1.mini    |  512 |   10 |         0 |     1 | True      |
| 13 | m1.normal  | 1024 |   10 |         0 |     2 | True      |
| 14 | m1.medium  | 2048 |   20 |         0 |     2 | True      |
| 15 | m1.large   | 4096 |   20 |         0 |     2 | True      |
| 16 | m1.xlarge  | 8192 |   20 |         0 |     4 | True      |
| 22 | vol.mini   |  512 |    0 |         0 |     1 | True      |
| 23 | vol.normal | 1024 |    0 |         0 |     1 | True      |
| 24 | vol.medium | 2048 |    0 |         0 |     2 | True      |
| 25 | vol.large  | 4096 |    0 |         0 |     2 | True      |
| 26 | vol.xlarge | 8192 |    0 |         0 |     4 | True      |
| 33 | win.normal | 1024 |   20 |        10 |     1 | True      |
| 34 | win.medium | 2048 |   20 |        10 |     1 | True      |
| 35 | win.large  | 4096 |   20 |        10 |     2 | True      |
+----+------------+------+------+-----------+-------+-----------+


openstack flavor create m1.nano --id 1 --ram 128 --disk 10 --ephemeral 0 --vcpus 1 
openstack flavor create m1.micro --id 2 --ram 256 --disk 10 --ephemeral 0 --vcpus 1 
openstack flavor create m1.mini --id 3 --ram 512 --disk 10 --ephemeral 0 --vcpus 1 
openstack flavor create m1.normal --id 4 --ram 1024 --disk 10 --ephemeral 0 --vcpus 2 
openstack flavor create m1.medium --id 5 --ram 2048 --disk 20 --ephemeral 0 --vcpus 2 
openstack flavor create m1.large --id 6 --ram 4096 --disk 20 --ephemeral 0 --vcpus 2 
openstack flavor create m1.xlarge --id 7 --ram 8192 --disk 20 --ephemeral 0 --vcpus 4 
openstack flavor create vol.mini --id 8 --ram 512 --disk 0 --ephemeral 0 --vcpus 1 
openstack flavor create vol.normal --id 9 --ram 1024 --disk 0 --ephemeral 0 --vcpus  1
openstack flavor create vol.medium --id 10 --ram 2048 --disk 0 --ephemeral 0 --vcpus  2
openstack flavor create vol.large --id 11 --ram 4096 --disk 0 --ephemeral 0 --vcpus  2
openstack flavor create vol.xlarge --id 12 --ram 8192 --disk 0 --ephemeral 0 --vcpus  4
openstack flavor create win.normal --id 13 --ram 1024 --disk 20 --ephemeral 10 --vcpus  1
openstack flavor create win.medium --id 14 --ram 2048 --disk 20 --ephemeral 10 --vcpus  1
openstack flavor create win.large --id 15 --ram 4096 --disk 20 --ephemeral 10 --vcpus  2
openstack flavor create m1.prueba --id 16 --ram 512 --disk 3 --vcpus 1



openstack server create --flavor m1.mini \
 --image "Debian 11 Bullseye" \
 --security-group default \
 --network "red_demo" \
 instancia_prueba2

```

## Configuración de LDAP

En el fichero `/etc/keystone/domains/keystone.iesgn.conf`:

```
[identity]
driver = ldap

[ldap]
group_tree_dn = cn=openstackusers,ou=Group,dc=gonzalonazareno,dc=org
url = ldap://ldap.gonzalonazareno.org
user_filter = (memberOf=cn=openstackusers,ou=Group,dc=gonzalonazareno,dc=org)
user_id_attribute = cn
user_name_attribute = uid
user_objectclass = posixAccount
user_tree_dn = ou=People,dc=gonzalonazareno,dc=org
```

