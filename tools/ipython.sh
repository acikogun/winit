#!/bin/bash

ipython_common() {
  pip3 install --no-warn-script-location --upgrade ipython
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
