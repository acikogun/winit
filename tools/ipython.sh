#!/bin/bash

ipython_common() {
  echo
  echo "Installing IPython..."
  pip3 install --upgrade ipython
  echo "Done."
  echo
}

# Debian handlers
debian_ipython() {
  debian_pip3
  ipython_common
}

debian_9_ipython() {
  debian_ipython
}

debian_10_ipython() {
  debian_ipython
}

# Ubuntu handlers
ubuntu_16_ipython() {
  debian_ipython
}

ubuntu_18_ipython() {
  debian_ipython
}

# Centos handlers
centos_ipython() {
  centos_pip3
  ipython_common
}

centos_7_ipython() {
  centos_ipython
}

# Fedora handlers
fedora_ipython() {
  fedora_pip3
  ipython_common
}

fedora_30_ipython() {
  fedora_ipython
}
