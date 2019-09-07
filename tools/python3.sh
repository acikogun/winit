#!/bin/bash

# Debian handlers
debian_python3() {
  apt-get update
  apt-get -y install python3 
}

debian_pip3() {
  apt-get update
  apt-get -y install python3-pip
  pip3 install --upgrade pip
  pip3 install --upgrade virtualenv
}

debian_9_python3() {
  debian_python3
}

debian_10_python3() {
  debian_python3
}

debian_9_pip() {
  debian_pip3
}

debian_10_pip() {
  debian_pip3
}

# Ubuntu handlers
ubuntu_16_python3() {
  debian_python3
}

ubuntu_18_python3() {
  debian_python3
}

ubuntu_16_pip() {
  debian_pip3
}

ubuntu_18_pip() {
  debian_pip3
}

# Centos handlers
centos_python3() {
  yum install -y epel-release
  yum install -y python36
}

centos_pip3() {
  yum install -y epel-release
  yum install -y python36-pip
  pip3 install --upgrade pip
  pip3 install --upgrade virtualenv
}

centos_7_python3() {
  centos_python3
}

centos_7_pip() {
  centos_pip3
}

# Fedora handlers
fedora_python3() {
  yum install -y python3 python3-pip
}

fedora_pip3() {
  yum install -y python3-pip
  pip3 install --upgrade pip
  pip3 install --upgrade virtualenv
}

fedora_30_python3() {
  fedora_python3
}

fedora_30_pip() {
  fedora_pip3
}
