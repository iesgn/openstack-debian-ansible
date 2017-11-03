# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|  
  config.vm.define :controller do |controller|
    controller.vm.box = "debian/stretch64"
    controller.vm.hostname = "controller"
    controller.vm.network :private_network, ip: "192.168.221.101" # eth1 internal
    controller.vm.network :public_network, bridge: "br0" ,ip: "192.168.1.201" # eth2 external
    controller.vm.provider "virtualbox" do |vbox|
      vbox.customize ["modifyvm", :id, "--memory", "4098"]
      vbox.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"] # eth2
      vbox.customize ["createhd",
                      '--filename', "tmp/disk.vdi",
                      '--size', "3000" ]
      # vbox.customize ["storagectl", :id,
      #                 "--name",
      #                 "SATA Controller",
      #                 "--add", "sata"]
      vbox.customize ['storageattach', :id,
                     '--storagectl', 'SATA Controller',
                     '--port', 1,
                     '--device', 0,
                     '--type', 'hdd',
                     '--medium', "tmp/disk.vdi"]
    end
  end
  config.vm.define :compute do |compute|
    compute.vm.box = "remram/debian-9-amd64"
    compute.vm.hostname = "compute1"
    compute.vm.network :private_network, ip: "192.168.221.102" # eth1 internal
    compute.vm.provider "virtualbox" do |vbox|
      vbox.customize ["modifyvm", :id, "--memory", "2048"]
    end
  end
end
