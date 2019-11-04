#!/bin/bash

ansible_common() {
  echo "Installing ansible..."
  pip3 install -qqq --no-cache-dir --upgrade ansible
  echo "Done."
  echo
}

# Debian handlers
debian_9_ansible() {
  ansible_common
}

debian_10_ansible() {
  ansible_common
}

# Ubuntu handlers
ubuntu_16_ansible() {
  ansible_common
}

ubuntu_18_ansible() {
  ansible_common
}

# Centos handlers
centos_7_ansible() {
  ansible_common
}
