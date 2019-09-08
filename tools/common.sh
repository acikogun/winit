#!/bin/bash

apt_common() {
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
}

yum_common() {
  echo "Installing requirements..."
  yum install -y git \
                 curl \
                 gnupg2 \
                 bash-completion >/dev/null
  echo "Done."
}

debian_9_common() {
  apt_common
}

debian_10_common() {
  apt_common
}

ubuntu_16_common() {
  apt_common
}

ubuntu_18_common() {
  apt_common
}

centos_7_common() {
  yum_common
}

fedora_30_common() {
  yum_common
}
