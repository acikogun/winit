#!/bin/bash

enable_pip_bash_completion() {
  pip_bash_dest="/etc/profile.d/pip_bash.sh"
  pip -qqq completion --bash > "${pip_bash_dest}"
}

config_virtualenvwrapper() {
  local venvwrapper_config_dest="/etc/profile.d/venvwrapper.sh"

  cat > "${venvwrapper_config_dest}" << EOM
export WORKON_HOME=\$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh
EOM
}

install_devsuite() {
  print_yellow "Installing pip..."
  pip3 -q install --no-cache-dir --upgrade pip
  # Create a symbolic link to /usr/bin since new pip3
  # executable is installed into /usr/local/bin/ after upgrade
  # and sudo doesn't export "/usr/local/bin" path on CentOS
  ln -sf /usr/local/bin/pip* /usr/bin/
  print_green "pip installed successfully."

  print_yellow "Installing virtualenv..."
  pip3 -q install --no-cache-dir --upgrade virtualenv
  ln -sf /usr/local/bin/virtualenv* /usr/bin/
  print_green "virtualenv installed successfully."

  print_yellow "Installing virtualenvwrapper..."
  pip3 -q install --no-cache-dir --upgrade virtualenvwrapper
  ln -sf /usr/local/bin/virtualenvwrapper* /usr/bin/
  config_virtualenvwrapper
  print_green "virtualenvwrapper installed successfully."

  print_yellow "Installing IPython..."
  pip3 -q install --no-cache-dir --upgrade ipython
  ln -sf /usr/local/bin/ipython* /usr/bin/
  print_green "IPython installed successfully."
}

apt_common() {
  print_yellow "Installing requirements..."
  apt-get -qq update
  apt-get -qqq install -y git \
                     curl \
                     apt-transport-https \
                     ca-certificates \
                     software-properties-common \
                     lsb-release \
                     gnupg \
                     unzip \
                     jq \
                     bash-completion

  apt-get -qqq install -y python3 python3-pip

  print_green "Requirements installed successfully."

  install_devsuite
  enable_pip_bash_completion
}

yum_common() {
  print_yellow "Installing requirements..."
  yum -q install -y epel-release

  yum -q install -y git \
                 curl \
                 gnupg \
                 unzip \
                 jq \
                 which \
                 bash-completion

  yum -q install -y python3

  print_green "Requirements installed successfully."

  install_devsuite
  enable_pip_bash_completion
}

dnf_common() {
  print_yellow "Installing requirements..."
  dnf -q install -y git \
                 curl \
                 gnupg \
                 unzip \
                 jq \
                 which \
                 bash-completion

  dnf -q install -y python3

  print_green "Requirements installed successfully."

  install_devsuite
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

ubuntu_20_common() {
  apt_common
}

centos_7_common() {
  yum_common
}

centos_8_common() {
  dnf_common
}
