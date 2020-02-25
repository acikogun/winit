#!/bin/bash

enable_pip_bash_completion() {
  pip_bash_dest="/etc/profile.d/pip_bash.sh"
  pip -qqq completion --bash > "${pip_bash_dest}"
}

upgrade_pip() {
  echo "Upgrading pip..."
  pip3 -q install --no-cache-dir --upgrade pip

  # Create a symbolic link to /usr/bin since new pip3
  # executable is installed into /usr/local/bin/ after upgrade
  # and sudo doesn't export "/usr/local/bin" path on CentOS
  ln -sf /usr/local/bin/pip* /usr/bin/

  echo "Installing virtualenv..."
  # Install virtualenv for future use
  pip3 -q install --no-cache-dir --upgrade virtualenv
  ln -sf /usr/local/bin/virtualenv* /usr/bin/

  echo "Done."
  echo
}

apt_common() {
  echo "Installing requirements..."
  apt-get -qq update
  apt-get -qq install -y git \
                     curl \
                     apt-transport-https \
                     ca-certificates \
                     software-properties-common \
                     lsb-release \
                     gnupg \
                     unzip \
                     jq \
                     bash-completion

  apt-get -qq install -y python3 python3-pip

  echo "Done."
  echo

  upgrade_pip
  enable_pip_bash_completion
}

yum_common() {
  echo "Installing requirements..."
  yum -q install -y epel-release

  yum -q install -y git \
                 curl \
                 gnupg \
                 unzip \
                 jq \
                 which \
                 bash-completion

  yum -q install -y python3

  echo "Done."
  echo

  upgrade_pip
  enable_pip_bash_completion
}

dnf_common() {
  echo "Installing requirements..."
  dnf -q install -y git \
                 curl \
                 gnupg \
                 unzip \
                 jq \
                 which \
                 bash-completion

  dnf -q install -y python3

  echo "Done."
  echo

  upgrade_pip
  enable_pip_bash_completion
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

centos_8_common() {
  dnf_common
}
