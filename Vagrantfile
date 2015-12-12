# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|  
  config.vm.define :controller do |controller|
    controller.vm.box = "debian/jessie64"
    controller.vm.hostname = "controller"
    controller.vm.network :private_network, ip: "192.168.221.101" # eth1 internal
    controller.vm.network :public_network, bridge: "eth0" ,ip: "192.168.1.101" # eth2 external
    controller.vm.provider "virtualbox" do |vbox|
      vbox.customize ["modifyvm", :id, "--memory", "3072"]
      vbox.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"] # eth2
      vbox.customize ["createhd",
                      '--filename', "tmp/disk.vdi",
                      '--size', "3000" ]
      vbox.customize ['storageattach', :id, 
                     '--storagectl', 'IDE Controller', 
                     '--port', 1, 
                     '--device', 1, 
                     '--type', 'hdd', 
                     '--medium', "tmp/disk.vdi"]
    end
  end
end
