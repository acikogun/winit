#!/bin/bash

ubuntu_docker() {
  local apt_repo
  apt_repo="deb [arch=amd64] https://download.docker.com/linux/ubuntu\
  $(lsb_release -cs) stable"

  local apt_repo_file="/etc/apt/sources.list.d/docker-ce.list"
  local apt_key_url="https://download.docker.com/linux/ubuntu/gpg"

  # Set up the stable repository
  echo "${apt_repo}" > "${apt_repo_file}"

  # Add Docker's official GPG key
  curl -sSL "${apt_key_url}" | apt-key add -

  apt-get update

  # Install the latest version of Docker CE
  echo "Installing docker-ce..."
  apt-get install -y docker-ce
  echo "Done."
}

debian_docker() {
  local apt_repo
  apt_repo="deb [arch=amd64] https://download.docker.com/linux/debian\
  $(lsb_release -cs) stable"

  local apt_repo_file="/etc/apt/sources.list.d/docker-ce.list"
  local apt_key_url="https://download.docker.com/linux/debian/gpg"

  # Add Docker's official GPG key
  curl -sSL "${apt_key_url}" | apt-key add -

  # Set up the stable repository
  echo "${apt_repo}" > "${apt_repo_file}"

  apt-get update

  # Install the latest version of Docker CE
  echo "Installing docker-ce..."
  apt-get install -y docker-ce \
                     docker-ce-cli \
                     containerd.io
  echo "Done."
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

  # Install the latest version of Docker CE
  echo "Installing docker-ce..."
  yum install -y docker-ce docker-ce-cli containerd.io

  # Enable and start docker.service
  systemctl enable docker
  echo "Done."
}

ubuntu_16_docker() {
  ubuntu_docker
}

ubuntu_18_docker() {
  ubuntu_docker
}

ubuntu_20_docker() {
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

centos_8_docker() {
  centos_docker
}
