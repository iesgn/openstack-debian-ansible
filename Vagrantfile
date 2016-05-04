# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|  
  config.vm.define :controller do |controller|
    controller.vm.box = "debian/jessie64"
    controller.vm.hostname = "controller"
    controller.vm.network :private_network, ip: "192.168.221.101" # eth1 internal
    controller.vm.network :public_network, bridge: "wlan0" ,ip: "172.22.50.241" # eth2 external
    controller.vm.provider "virtualbox" do |vbox|
      vbox.customize ["modifyvm", :id, "--memory", "2560"]
      vbox.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"] # eth2
      vbox.customize ["createhd",
                      '--filename', "tmp/disk",
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
end
