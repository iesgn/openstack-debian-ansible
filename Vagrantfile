# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|  
  config.vm.define :controller do |controller|
    controller.vm.box = "debian/buster64"
    controller.vm.hostname = "controller"
    controller.vm.network :private_network, ip: "192.168.98.101" 
    controller.vm.network :private_network, ip: "192.168.99.101" 
    controller.vm.provider "libvirt" do |libvirt|
      libvirt.memory = "4098"
      libvirt.storage :file, :size => '3G', :path => 'disk.img', :allow_existing => true, :shareable => true, :type => 'raw'
    end
  end
  config.vm.define :compute do |compute|
    compute.vm.box = "debian/buster64"
    compute.vm.hostname = "compute1"
    compute.vm.network :private_network, ip: "192.168.99.102"
    compute.vm.provider "libvirt" do |libvirt|
      libvirt.memory = "2048"
    end
  end
end
