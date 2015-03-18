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

## Deployment schema

Per tenant router with private networks

## Get a debian jessie vagrant box:

Tested using debian jessie vagrant box available at:

    https://vagrantcloud.com/binarydata/boxes/debian-jessie
	https://downloads.sourceforge.net/project/vagrantboxjessie/debian80.box

Download and install it locally with:

    vagrant box add --name binarydata/debian-jessie https://vagrantcloud.com/binarydata/boxes/debian-jessie

## Bring up the scenario

    chmod 400 vagrant_private_key
	vagrant up

## Run ansible playbooks to configure the cloud

    ansible-playbook site.yml --sudo
   

## References

- [https://github.com/openstack-ansible](https://github.com/openstack-ansible)
- [https://github.com/djoreilly/quantum-ansible](https://github.com/djoreilly/quantum-ansible)
