
$script = <<SCRIPT
cd /vagrant
chmod +x winit
sudo ./winit -a
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.provision "shell", inline: $script

    config.vm.define "deb9" do |h1|
      h1.vm.box = "debian/stretch64"
      h1.vm.network :private_network, ip: "192.168.50.11", virtualbox__intnet: "network0"
      h1.vm.hostname = "deb9"
    end

    config.vm.define "deb10" do |h2|
      h2.vm.box = "debian/buster64"
      h2.vm.network :private_network, ip: "192.168.50.12", virtualbox__intnet: "network0"
      h2.vm.hostname = "deb10"
    end

    config.vm.define "ub16" do |h3|
      h3.vm.box = "ubuntu/xenial64"
      h3.vm.network :private_network, ip: "192.168.50.13", virtualbox__intnet: "network0"
      h3.vm.hostname = "ub16"
    end

    config.vm.define "ub18" do |h4|
      h4.vm.box = "ubuntu/bionic64"
      h4.vm.network :private_network, ip: "192.168.50.14", virtualbox__intnet: "network0"
      h4.vm.hostname = "ub18"
    end

    config.vm.define "centos7" do |h5|
      h5.vm.box = "centos/7"
      h5.vm.network :private_network, ip: "192.168.50.15", virtualbox__intnet: "network0"
      h5.vm.hostname = "centos7"
    end

    config.vm.define "centos8" do |h6|
      h6.vm.box = "centos/8"
      h6.vm.network :private_network, ip: "192.168.50.16", virtualbox__intnet: "network0"
      h6.vm.hostname = "centos8"
    end

  config.vm.box_check_update = false
end
