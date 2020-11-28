openstack-debian-ansible
========================

Ansible playbooks for installing OpenStack Victoria on Debian Buster
using debian backports repository. The steps taken follow a standard
OpenStack deployment:
[OpenStack Victoria Installation Guide](https://docs.openstack.org/victoria/install/)
with some minors modifications to use with Debian.

The networking option used is Self-service networks using linux bridges.

These playbooks have been written with the idea of using them in a real deployment
with physical servers, but thay can be used to deploy a OpenStack test
environment with:

* Vagrant using vagrant-libvirt plugin.
* OpenStack Heat

**This is a work in progress, feel free to open issues on github**

## Software used (specific versions):

- Debian GNU/Linux: buster (amd64). 
- Linux kernel: 4.19.0-8-amd64
- OpenStack: Victoria
- Ansible: 2.10.3
- Vagrant: 2.2.3+dfsg-1
- vagrant-libvirt: vagrant-libvirt
- qemu-kvm: 1:3.1+dfsg-8+deb10u3

## OpenStack components included:

Keystone, Glance, Placement, Nova, Neutron, Horizon, Cinder and Heat

## Vagrant Setup

![schema](https://raw.githubusercontent.com/iesgn/openstack-debian-ansible/master/img/openstack-debian-ansible.png)

The file *groups_var/all* contains all variables needed by ansible playbooks and
they can be customized if needed.

## Bring up the scenario:

	vagrant up

## Run the ansible playbooks to configure the cloud

    ansible-playbook site.yml -b

## Using OpenStack

Open your browser and type in the notification bar http://192.168.98.101 or the corresponding external IP chosen.

