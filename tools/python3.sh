#!/bin/bash

# Debian handlers
debian_python3() {
  apt-get update
  apt-get -y install python3
}

debian_pip3() {
  # Install and upgrade pip
  apt-get update
  apt-get -y install python3-pip
  pip3 install --upgrade pip

  # Create a symbolic link to /usr/bin since new pip3
  # executable is installed into /usr/local/bin/ after pip upgrade
  ln -sf /usr/local/bin/pip3 /usr/bin/pip3

  # Install virtualenv
  pip3 install --upgrade virtualenv
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
  # Install and upgrade pip
  yum install -y python36-pip
  pip3 install --upgrade pip

  # Create a symbolic link to /usr/bin since new pip3
  # executable is installed into /usr/local/bin/ after upgrade
  # and sudo doesn't export "/usr/local/bin" path on Centos
  ln -sf /usr/local/bin/pip3 /usr/bin/pip3

  # Clear pip3 binary location cache since new pip3
  # binary is installed different location after pip upgrade
  hash -d pip3

  # Install virtualenv
  pip3 install --upgrade virtualenv
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
  # Install and upgrade pip
  yum install -y python3-pip
  pip3 install --upgrade pip

  # Create a symbolic link to /usr/bin since new pip3
  # executable is installed into /usr/local/bin/ after pip upgrade
  ln -sf /usr/local/bin/pip3 /usr/bin/pip3

  # Install virtualenv
  pip3 install --upgrade virtualenv
}

fedora_30_python3() {
  fedora_python3
}

fedora_30_pip() {
  fedora_pip3
}
