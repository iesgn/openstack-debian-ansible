openstack-debian-ansible
========================

Ansible playbooks for installing OpenStack Train on Debian Buster
using debian backports repository. The steps taken follow a standard
OpenStack deployment:
[OpenStack Train Installation Guide](https://docs.openstack.org/train/install/)
with some minors modifications to use with Debian.

The networking option used is Self-service networks using linux bridges.

These playbooks have been written with the idea of using them in a real deployment
with physical servers, but thay can be used too to deploy a OpenStack test
environment with vagrant using vagrant-libvirt plugin.

**This is a work in progress, feel free to open issues on github**

## Software used (specific versions):

- Debian GNU/Linux: buster (amd64). 
- Linux kernel: 4.19.0-8-amd64
- OpenStack: Train
- Ansible: 2.7.7
- Vagrant: 2.2.3+dfsg-1
- vagrant-libvirt: vagrant-libvirt
- qemu-kvm: 1:3.1+dfsg-8+deb10u3

## OpenStack componens included:

Keystone, Glance, Placement, Nova, Neutron, Horizon, Cinder and Heat

## Configuration

![schema](https://raw.githubusercontent.com/iesgn/openstack-debian-ansible/master/img/openstack-debian-ansible.png)

The file *groups_var/all* contains all variables needed by ansible playbooks and
they can be customized if needed. It's **mandatory** to define the following
variables according to your LAN:

    controller_external_ip: 192.168.1.101
	storage_external_ip: 192.168.1.101
	network_node_external_ip: 192.168.1.101
	network_node_external_netmask: 255.255.255.0
	network_node_external_CIDR: 24
	external_gateway: 192.168.1.1

The Vagranfile must be modified too:

    controller.vm.network :public_network, bridge: "wlan0" ,ip: "192.168.1.101" # eth2 external

## Bring up the scenario:

	vagrant up

## Run the ansible playbooks to configure the cloud

    ansible-playbook site.yml -b

## Using OpenStack

Open your browser and type in the notification bar http://192.168.99.101 or the corresponding external IP chosen.

