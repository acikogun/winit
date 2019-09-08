#!/bin/bash

enable_awscli_bash_completion() {
  awscli_bash_dest="/etc/profile.d/awcli_bash.sh"
  rm -f "${awscli_bash_dest}"
  echo "complete -C 'aws_completer' aws" >> "${awscli_bash_dest}"
}

awscli_common() {
  echo "Installing awscli..."
  pip3 install --no-cache-dir --upgrade awscli >/dev/null

  # Enable bash completion
  enable_awscli_bash_completion
  echo "Done."
  echo
}

# Debian handlers
debian_awscli() {
  debian_pip3
  awscli_common
}

debian_9_awscli() {
  debian_awscli
}

debian_10_awscli() {
  debian_awscli
}

# Ubuntu handlers
ubuntu_16_awscli() {
  debian_awscli
}

ubuntu_18_awscli() {
  debian_awscli
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
