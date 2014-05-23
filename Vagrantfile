# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|  
  config.vm.define :controller do |controller|
    controller.vm.box = "jessie"
    controller.vm.hostname = "controller"
    controller.vm.network :private_network, ip: "192.168.222.101" # eth1 internal
    controller.vm.network :private_network, ip: "192.168.221.101" # eth2 external
    controller.vm.provider "virtualbox" do |vbox|
      vbox.customize ["modifyvm", :id, "--memory", "1024"]
      vbox.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"] # eth2
    end
  end
end
