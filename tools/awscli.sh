#!/bin/bash

enable_awscli_bash_completion() {
  awscli_bash_dest="/etc/profile.d/awscli_bash.sh"
  echo "complete -C 'aws_completer' aws" > "${awscli_bash_dest}"
}

awscli_common() {
  echo "Installing awscli..."
  pip3 install -qqq --no-cache-dir --upgrade awscli

  # Enable bash completion
  enable_awscli_bash_completion
  echo "Done."
  echo
}

debian_9_awscli() {
  awscli_common
}

debian_10_awscli() {
  awscli_common
}

ubuntu_16_awscli() {
  awscli_common
}

ubuntu_18_awscli() {
  awscli_common
}

centos_7_awscli() {
  awscli_common
}
