#!/bin/bash

enable_pip_bash_completion() {
  pip_bash_dest="/etc/profile.d/pip_bash.sh"
  pip -qqq completion --bash > "${pip_bash_dest}"
}

upgrade_pip() {
  echo "Upgrading pip..."
  pip3 install -qqq --no-cache-dir --upgrade pip

  # Create a symbolic link to /usr/bin since new pip3
  # executable is installed into /usr/local/bin/ after upgrade
  # and sudo doesn't export "/usr/local/bin" path on Centos
  ln -sf /usr/local/bin/pip3 /usr/bin/pip3
  ln -sf /usr/local/bin/pip3 /usr/bin/pip

  # Install virtualenv for future use
  pip3 install -qqq --no-cache-dir --upgrade virtualenv

  echo "Done."
  echo
}

apt_common() {
  echo "Installing requirements..."
  apt-get update >/dev/null 2>&1
  apt-get install -y git \
                     curl \
                     apt-transport-https \
                     ca-certificates \
                     software-properties-common \
                     lsb-release \
                     gnupg2 \
                     bash-completion \
                     python3 \
                     python3-pip >/dev/null 2>&1

  echo "Done."
  echo

  upgrade_pip
  enable_pip_bash_completion
}

yum_common() {
  echo "Installing requirements..."
  yum install -y epel-release \
                 git \
                 curl \
                 gnupg2 \
                 bash-completion >/dev/null 2>&1

  yum install -y python36 \
                 python36-pip >/dev/null 2>&1

  echo "Done."
  echo

  upgrade_pip
  enable_pip_bash_completion
}

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
