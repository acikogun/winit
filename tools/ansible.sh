#!/bin/bash

ansible_common() {
  echo "Installing ansible..."
  pip3 install --no-cache-dir --upgrade ansible >/dev/null
  echo "Done."
  echo
}

# Debian handlers
debian_ansible() {
  debian_pip3
  ansible_common
}

debian_9_ansible() {
  debian_ansible
}

debian_10_ansible() {
  debian_ansible
}

# Ubuntu handlers
ubuntu_16_ansible() {
  debian_ansible
}

ubuntu_18_ansible() {
  debian_ansible
}

# Centos handlers
centos_ansible() {
  centos_pip3
  ansible_common
}

centos_7_ansible() {
  centos_ansible
}

# Fedora handlers
fedora_ansible() {
  fedora_pip3
  ansible_common
}

fedora_30_ansible() {
  fedora_ansible
}
