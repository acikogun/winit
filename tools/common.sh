#!/bin/bash

enable_pip_bash_completion() {
  pip_bash_dest="/etc/profile.d/pip_bash.sh"
  pip completion --bash > "${pip_bash_dest}"
}

upgrade_pip() {
  echo "Installing pip and virtualenv..."
  pip3 install --no-cache-dir --upgrade pip >/dev/null

  # Create a symbolic link to /usr/bin since new pip3
  # executable is installed into /usr/local/bin/ after upgrade
  # and sudo doesn't export "/usr/local/bin" path on Centos
  ln -sf /usr/local/bin/pip3 /usr/bin/pip3
  ln -sf /usr/local/bin/pip3 /usr/bin/pip

  # Install virtualenv for future use
  pip3 install --no-cache-dir --upgrade virtualenv >/dev/null

  echo "Done."
  echo
}

debian_common() {
  echo "Installing requirements..."
  apt-get update >/dev/null
  apt-get install -y git \
                     curl \
                     apt-transport-https \
                     ca-certificates \
                     software-properties-common \
                     lsb-release \
                     gnupg2 \
                     bash-completion \
                     python3 \
                     python3-pip >/dev/null

  echo "Done."
  echo

  upgrade_pip
  enable_pip_bash_completion
}

centos_common() {
  echo "Installing requirements..."
  yum install -y epel-release \
                 git \
                 curl \
                 gnupg2 \
                 bash-completion > /dev/null

  yum install -y python36 \
                 python36-pip >/dev/null

  echo "Done."
  echo

  upgrade_pip
  enable_pip_bash_completion
}

fedora_common() {
  echo "Installing requirements..."
  dnf install -y git \
                 curl \
                 gnupg2 \
                 bash-completion \
                 python3 \
                 python3-pip >/dev/null

  echo "Done."
  echo

  upgrade_pip
  enable_pip_bash_completion
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
