#!/bin/bash

ubuntu_docker() {
  local apt_repo="deb [arch=amd64] https://download.docker.com/linux/ubuntu\
  $(lsb_release -cs) stable"

  local apt_repo_file="/etc/apt/sources.list.d/docker-ce.list"
  local apt_key_url="https://download.docker.com/linux/ubuntu/gpg"

  # Set up the stable repository
  echo "${apt_repo}" > "${apt_repo_file}"

  # Add Docker’s official GPG key
  curl -sS "${apt_key_url}" | apt-key add - >/dev/null 2>&1

  apt-get update >/dev/null 2>&1

  # Uninstall old versions
  apt-get remove -y docker \
                    docker-engine \
                    docker.io >/dev/null 2>&1

  # Install the latest version of Docker CE
  echo "Installing docker-ce..."
  apt-get install -y docker-ce >/dev/null 2>&1
  echo "Done."
  echo
}

debian_docker() {
  local apt_repo="deb [arch=amd64] https://download.docker.com/linux/debian\
  $(lsb_release -cs) stable"

  local apt_repo_file="/etc/apt/sources.list.d/docker-ce.list"
  local apt_key_url="https://download.docker.com/linux/debian/gpg"

  # Add Docker’s official GPG key
  curl -sS "${apt_key_url}" | apt-key add - >/dev/null 2>&1

  # Set up the stable repository
  echo "${apt_repo}" > "${apt_repo_file}"

  apt-get update >/dev/null 2>&1

  # Uninstall old versions
  apt-get remove -y docker \
                    docker-engine \
                    docker.io \
                    containerd \
                    runc >/dev/null 2>&1

  # Install the latest version of Docker CE
  echo "Installing docker-ce..."
  apt-get install -y docker-ce \
                     docker-ce-cli \
                     containerd.io >/dev/null 2>&1
  echo "Done."
  echo
}

fedora_docker() {
  local fedora_repo="https://download.docker.com/linux/fedora/docker-ce.repo"

  # Install the dnf-plugins-core package which provides the commands
  # to manage your DNF repositories from the command line
  dnf install -y dnf-plugins-core >/dev/null 2>&1

  # Set up the stable repository
  dnf config-manager --add-repo "${fedora_repo}" >/dev/null 2>&1

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
                docker-engine >/dev/null 2>&1

  # Install the latest version of Docker CE
  echo "Installing docker-ce..."
  dnf install -y docker-ce \
                 docker-ce-cli \
                 containerd.io >/dev/null 2>&1

  # Enable and start docker.service
  systemctl enable docker
  systemctl start docker
  echo "Done."
  echo
}

centos_docker() {
  local yum_repo="https://download.docker.com/linux/centos/docker-ce.repo"

  # Install required packages. yum-utils,device-mapper-persistent-data
  # lvm2 are required by the devicemapper storage driver.
  yum install -y yum-utils \
                 device-mapper-persistent-data \
                 lvm2 >/dev/null 2>&1

  # Set up the stable repository
  yum-config-manager --add-repo "${yum_repo}" >/dev/null 2>&1

  # Uninstall old versions
  yum remove -y docker \
                docker-common \
                docker-selinux \
                docker-engine >/dev/null 2>&1

  # Install the latest version of Docker CE
  echo "Installing docker-ce..."
  yum install -y docker-ce >/dev/null 2>&1

  # Enable and start docker.service
  systemctl enable docker
  systemctl start docker
  echo "Done."
  echo
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
