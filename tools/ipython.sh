#!/bin/bash

ipython_common() {
  echo "Installing IPython..."
  pip3 install -qqq --no-cache-dir --upgrade ipython
  echo "Done."
  echo
}

# Debian handlers
debian_9_ipython() {
  ipython_common
}

debian_10_ipython() {
  ipython_common
}

# Ubuntu handlers
ubuntu_16_ipython() {
  ipython_common
}

ubuntu_18_ipython() {
  ipython_common
}

# Centos handlers
centos_7_ipython() {
  ipython_common
}

# Fedora handlers
fedora_30_ipython() {
  ipython_common
}
