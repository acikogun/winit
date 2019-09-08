#!/bin/bash

enable_pip_bash_completion() {
  pip_bash_dest="/etc/profile.d/pip_bash.sh"
  rm -f "${pip_bash_dest}"
  pip completion --bash > "${pip_bash_dest}"
}

upgrade_pip() {
  echo "Installing pip..."
  pip3 install --no-cache-dir --upgrade pip >/dev/null

  # Create a symbolic link to /usr/bin since new pip3
  # executable is installed into /usr/local/bin/ after upgrade
  # and sudo doesn't export "/usr/local/bin" path on Centos
  ln -sf /usr/local/bin/pip3 /usr/bin/pip3

  # Install virtualenv for future use
  pip3 install --no-cache-dir --upgrade virtualenv >/dev/null

  # Enable bash completion
  enable_pip_bash_completion
  echo "$(pip3 -V) installed."
  echo
}

# Debian handlers
debian_python3() {
  apt-get update >/dev/null
  echo "Installing Python3..."
  apt-get -y install python3 >/dev/null
  echo "Done."
  echo
}

debian_pip3() {
  apt-get update >/dev/null
  apt-get -y install python3-pip >/dev/null
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
  yum install -y python36 >/dev/null
}

centos_pip3() {
  yum install -y python36-pip >/dev/null
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
  yum install -y python3 >/dev/null
}

fedora_pip3() {
  yum install -y python3-pip >/dev/null
  upgrade_pip
}

fedora_30_python3() {
  fedora_python3
}

fedora_30_pip() {
  fedora_pip3
}
