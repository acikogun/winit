#!/bin/bash

awscli_common() {
  pip3 install --upgrade awscli
}

# Debian handlers
debian_awscli() {
  debian_pip3
  awscli_common
}

debian_9_awscli() {
  debian_pip3
  awscli_common
}

debian_9_awscli() {
  debian_pip3
  awscli_common
}

# Ubuntu handlers
ubuntu_16_awscli() {
  debian_pip3
  awscli_common
}

ubuntu_18_awscli() {
  debian_pip3
  awscli_common
}

# Centos handlers
centos_awscli() {
  centos_pip3
  awscli_common
}

centos_7_awscli() {
  centos_awscli
}

# Fedora handlers
fedora_awscli() {
  fedora_pip3
  awscli_common
}

fedora_30_awscli() {
  fedora_awscli
}
