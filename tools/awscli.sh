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
debian_9_awscli() {
  awscli_common
}

debian_10_awscli() {
  awscli_common
}

# Ubuntu handlers
ubuntu_16_awscli() {
  awscli_common
}

ubuntu_18_awscli() {
  awscli_common
}

# Centos handlers
centos_7_awscli() {
  awscli_common
}

# Fedora handlers
fedora_30_awscli() {
  awscli_common
}
