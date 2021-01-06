# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.network "public_network", ip: "192.168.1.21"
  config.vm.provider "virtualbox" do |vb|
     vb.name = "Rancher_Cluster"
     vb.cpus = 4
     vb.memory = "8196"
  end
  
  config.vm.provision "file", source: "create_rancher.sh", destination: "/tmp/"
  config.vm.provision "shell",inline: "/bin/bash /tmp/create_rancher.sh"
end
