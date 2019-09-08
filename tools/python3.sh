#!/bin/bash

upgrade_pip() {
  echo
  echo "Installing pip and virtualenv..."
  pip3 install --upgrade pip >/dev/null

  # Create a symbolic link to /usr/bin since new pip3
  # executable is installed into /usr/local/bin/ after upgrade
  # and sudo doesn't export "/usr/local/bin" path on Centos
  ln -sf /usr/local/bin/pip3 /usr/bin/pip3

  # Install virtualenv for future use
  pip3 install --upgrade virtualenv >/dev/null
  echo
  echo "$(pip3 -V) installed."
  echo
}

# Debian handlers
debian_python3() {
  apt-get update >/dev/null
  apt-get -y install python3
}

debian_pip3() {
  apt-get update >/dev/null
  apt-get -y install python3-pip
  upgrade_pip
}

debian_9_python3() {
  debian_python3
}

debian_10_python3() {
  debian_python3
}

debian_9_pip() {
  debian_pip3
}

debian_10_pip() {
  debian_pip3
}

# Ubuntu handlers
ubuntu_16_python3() {
  debian_python3
}

ubuntu_18_python3() {
  debian_python3
}

ubuntu_16_pip() {
  debian_pip3
}

ubuntu_18_pip() {
  debian_pip3
}

# Centos handlers
centos_python3() {
  yum install -y python36
}

centos_pip3() {
  yum install -y python36-pip
  upgrade_pip
}

centos_7_python3() {
  centos_python3
}

centos_7_pip() {
  centos_pip3
}

# Fedora handlers
fedora_python3() {
  yum install -y python3
}

fedora_pip3() {
  yum install -y python3-pip
  upgrade_pip
}

fedora_30_python3() {
  fedora_python3
}

fedora_30_pip() {
  fedora_pip3
}
