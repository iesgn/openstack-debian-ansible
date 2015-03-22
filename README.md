openstack-debian-ansible
========================

Ansible playbooks for installing "AllinOneNode" OpenStack Icehouse on Debian testing (jessie)

**This is still a work in progress**

## Software used (specific releases):

- Debian GNU/Linux: testing amd64 (jessie)
- Linux kernel: 3.16.0-4-amd64
- Open vSwitch: 2.3.0
- OpenStack: Icehouse (2014.1)
- Ansible: 1.7.2
- Vagrant: 1.6.5
- VirtualBox: 4.3.14

## OpenStack componens included:

Keystone, Glance, Nova, Neutron and Cinder

## Deployment schema

Per tenant router with private networks

## Get a debian jessie vagrant box:

Tested using the debian jessie vagrant box available at:

    https://vagrantcloud.com/albertomolina/boxes/debian-jessie-amd64

Download and install it locally with:

    vagrant box add --name albertomolina/debian-jessie-amd64 https://vagrantcloud.com/albertomolina/boxes/debian-jessie-amd64

## Configuration

![schema](https://raw.githubusercontent.com/iesgn/openstack-debian-ansible/master/img/openstack-debian-ansible.png)

The file groups_var/all contains all variables needed by ansible playbooks and they can be customized. It's **mandatory** to define the following variables according your LAN:

    controller_external_ip: 192.168.1.101
	storage_external_ip: 192.168.1.101
	network_node_external_ip: 192.168.1.101
	network_node_external_netmask: 255.255.255.0
	network_node_external_CIDR: 24
	external_gateway: 192.168.1.1

In the Vagranfile, the line:

    controller.vm.network :public_network, bridge: "wlan0" ,ip: "192.168.1.101" # eth2 external

must be modified too.

## Bring up the scenario

    chmod 400 vagrant_private_key
	vagrant up

## Run ansible playbooks to configure the cloud

    ansible-playbook site.yml --sudo

## Using OpenStack

Open your browser and type in the notification bar http://192.168.1.101 or the corresponding external IP choosen.

## References

- [https://github.com/openstack-ansible](https://github.com/openstack-ansible)
- [https://github.com/djoreilly/quantum-ansible](https://github.com/djoreilly/quantum-ansible)
