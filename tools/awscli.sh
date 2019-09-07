#!/bin/bash

enable_awscli_bash_completion() {
  awscli_bash_dest="/etc/profile.d/awcli_bash.sh"
  rm -f "${awscli_bash_dest}"
  echo "complete -C 'aws_completer' aws" >> "${awscli_bash_dest}"
}

awscli_common() {
  pip3 install --upgrade awscli
  enable_awscli_bash_completion
}

# Debian handlers
debian_awscli() {
  debian_pip3
  awscli_common
  apt-get update
  apt-get -y install bash-completion
}

debian_9_awscli() {
  debian_awscli
}

debian_10_awscli() {
  debian_awscli
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
  yum install -y bash-completion
}

centos_7_awscli() {
  centos_awscli
}

# Fedora handlers
fedora_awscli() {
  fedora_pip3
  awscli_common
  yum install -y bash-completion
}

fedora_30_awscli() {
  fedora_awscli
}
