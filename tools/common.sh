#!/bin/bash

debian_common() {
  echo
  echo "Installing requirements..."
  apt-get update >/dev/null
  apt-get install -y git \
                     curl \
                     apt-transport-https \
                     ca-certificates \
                     software-properties-common \
                     lsb-release \
                     gnupg2 \
                     bash-completion >/dev/null
  echo "Done."
  echo
}

centos_common() {
  echo
  echo "Installing requirements..."
  yum install -y git \
                 epel-release \
                 curl \
                 gnupg2 \
                 bash-completion >/dev/null
  echo "Done."
  echo
}

fedora_common() {
  echo
  echo "Installing requirements..."
  dnf install -y git \
                 curl \
                 gnupg2 \
                 bash-completion >/dev/null
  echo "Done."
  echo
}

debian_9_common() {
  debian_common
}

debian_10_common() {
  debian_common
}

ubuntu_16_common() {
  debian_common
}

ubuntu_18_common() {
  debian_common
}

centos_7_common() {
  centos_common
}

fedora_30_common() {
  fedora_common
}
