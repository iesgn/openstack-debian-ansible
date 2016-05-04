openstack-debian-ansible
========================

Ansible playbooks for installing OpenStack Mitaka on Debian jessie using Debian backports

These playbooks have been written in the hope of using them in a real deployment
with physical servers, but thay can be used too to deploy a OpenStack test
environment with vagrant inside a computer.

**This is still a work in progress**

## Software used (specific versions):

- Debian GNU/Linux: jessie (amd64). 
- Linux kernel: 3.16.0-4-amd64
- Open vSwitch: 2.3.0
- OpenStack: Mitaka
- Ansible: 1.7.2
- Vagrant: 1.6.5
- VirtualBox: 4.3.14

## OpenStack componens included:

Keystone, Glance, Nova, Neutron and Cinder

## Deployment schema

[Per tenant router with private networks](http://docs.openstack.org/havana/install-guide/install/apt/content/section_networking-routers-with-private-networks.html)

## Get a debian jessie vagrant box:

Tested using the debian "official" jessie vagrant box available at:

    https://atlas.hashicorp.com/debian/boxes/jessie64

You can download and install it locally with:

    vagrant box add debian/jessie64

If you are going to use these playbooks with physical serves, ignore the
Vagranfile and configure ansible.cfg properly.

## Configuration

![schema](https://raw.githubusercontent.com/iesgn/openstack-debian-ansible/master/img/openstack-debian-ansible.png)

**At this moment the playbooks are tested only in an "AllinOneNode" schema.**

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

## Bring up the scenario

    chmod 400 vagrant_private_key
	vagrant up

## Run ansible playbooks to configure the cloud

    ansible-playbook site.yml --sudo

## Using OpenStack

Open your browser and type in the notification bar http://192.168.1.101 or the corresponding external IP chosen.

## References

- [https://github.com/openstack-ansible](https://github.com/openstack-ansible)
- [https://github.com/djoreilly/quantum-ansible](https://github.com/djoreilly/quantum-ansible)
