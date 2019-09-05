#!/bin/bash

ubuntu_docker() {
  # Uninstall old versions
  apt-get remove docker docker-engine docker.io -y

  apt-get update -y

  # Install packages to allow apt to use a repository over HTTPS
  apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y

  # Add Docker’s official GPG key
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

  # Set up the stable repository
  add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

  apt-get update -y

  # Install the latest version of Docker CE
  apt-get install docker-ce -y 
}

debian_docker() {
  apt-get update -y

  # Install packages to allow apt to use a repository over HTTPS
  apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common -y

  # Add Docker’s official GPG key
  curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

  # Set up the stable repository
  add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

  apt-get update -y

  # Uninstall old versions
  apt-get remove docker docker-engine docker.io containerd runc -y

  # Install the latest version of Docker CE
   apt-get install docker-ce docker-ce-cli containerd.io -y
}

fedora_docker() {
  # Install the dnf-plugins-core package which provides the commands
  # to manage your DNF repositories from the command line
  dnf -y install dnf-plugins-core

  # Set up the stable repository
  dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo

  # Uninstall old versions
  dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine -y

  # Install the latest version of Docker CE 
  dnf -y install docker-ce docker-ce-cli containerd.io
  
  # Enable and start docker.service
  systemctl enable docker
  systemctl start docker
}

centos_docker() {
  # Install required packages. yum-utils,device-mapper-persistent-data
  # lvm2 are required by the devicemapper storage driver.
  yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2 -y

  # Set up the stable repository
  yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

  # Uninstall old versions
  yum remove docker \
                  docker-common \
                  docker-selinux \
                  docker-engine -y

  # Install the latest version of Docker CE
  yum install docker-ce -y

  # Enable and start docker.service
  systemctl enable docker
  systemctl start docker
}
