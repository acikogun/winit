#!/bin/bash

ansible_common() {
  echo "Installing ansible..."
  pip3 install --no-cache-dir --upgrade ansible

  # Create symbolic links to /usr/bin since ansible
  # executables is installed into /usr/local/bin/
  # and sudo doesn't export "/usr/local/bin" on CentOS
  ln -sf /usr/local/bin/ansible* /usr/bin/

  echo "Done."
}

debian_9_ansible() {
  ansible_common
}

debian_10_ansible() {
  ansible_common
}

ubuntu_16_ansible() {
  ansible_common
}

ubuntu_18_ansible() {
  ansible_common
}

centos_7_ansible() {
  ansible_common
}

centos_8_ansible() {
  ansible_common
}
