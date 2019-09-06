#!/bin/bash

ubuntu_docker() {
  local apt_repo="deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable"

  local apt_key_url="https://download.docker.com/linux/ubuntu/gpg"

  apt-get update -y

  # Install packages to allow apt to use a repository over HTTPS
  apt-get install -y apt-transport-https \
                     ca-certificates \
                     curl \
                     software-properties-common \
                     lsb-release

  # Add Docker’s official GPG key
  curl -sS "${apt_key_url}" | apt-key add -

  # Set up the stable repository
  add-apt-repository "${apt_key_url}"

  apt-get update -y

  # Uninstall old versions
  apt-get remove -y docker \
                    docker-engine \
                    docker.io

  # Install the latest version of Docker CE
  apt-get install -y docker-ce 
}

debian_docker() {
  local apt_repo="deb [arch=amd64] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable"

  local apt_key_url="https://download.docker.com/linux/debian/gpg"

  apt-get update -y

  # Install packages to allow apt to use a repository over HTTPS
  apt-get install -y apt-transport-https \
                     ca-certificates \
                     curl \
                     gnupg2 \
                     software-properties-common \
                     lsb-release

  # Add Docker’s official GPG key
  curl -sS "${apt_key_url}" | apt-key add -

  # Set up the stable repository
  add-apt-repository "${apt_repo}"

  apt-get update -y

  # Uninstall old versions
  apt-get remove -y docker \
                    docker-engine \
                    docker.io \
                    containerd \
                    runc

  # Install the latest version of Docker CE
  apt-get install -y docker-ce \
                     docker-ce-cli \
                     containerd.io
}

fedora_docker() {
  local fedora_repo="https://download.docker.com/linux/fedora/docker-ce.repo"

  # Install the dnf-plugins-core package which provides the commands
  # to manage your DNF repositories from the command line
  dnf install -y dnf-plugins-core

  # Set up the stable repository
  dnf config-manager --add-repo "${fedora_repo}"

  # Uninstall old versions
  dnf remove -y docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-selinux \
                docker-engine-selinux \
                docker-engine

  # Install the latest version of Docker CE 
  dnf install -y docker-ce \
                 docker-ce-cli \
                 containerd.io

  # Enable and start docker.service
  systemctl enable docker
  systemctl start docker
}

centos_docker() {
  local yum_repo="https://download.docker.com/linux/centos/docker-ce.repo"
  # Install required packages. yum-utils,device-mapper-persistent-data
  # lvm2 are required by the devicemapper storage driver.
  yum install -y yum-utils \
                 device-mapper-persistent-data \
                 lvm2

  # Set up the stable repository
  yum-config-manager --add-repo "${yum_repo}"
 
  # Uninstall old versions
  yum remove -y docker \
                docker-common \
                docker-selinux \
                docker-engine

  # Install the latest version of Docker CE
  yum install -y docker-ce 

  # Enable and start docker.service
  systemctl enable docker
  systemctl start docker
}

ubuntu_16_docker() {
  ubuntu_docker
}

ubuntu_18_docker() {
  ubuntu_docker
}

debian_9_docker() {
  debian_docker
}

debian_10_docker() {
  debian_docker
}

centos_7_docker() {
  centos_docker
}

fedora_30_docker() {
  fedora_docker
}
