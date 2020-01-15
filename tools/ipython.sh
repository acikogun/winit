#!/bin/bash

ipython_common() {
  echo "Installing IPython..."
  pip3 install -qqq --no-cache-dir --upgrade ipython

  # Create symbolic links to /usr/bin since IPython
  # executables is installed into /usr/local/bin/
  # and sudo doesn't export "/usr/local/bin" on CentOS
  ln -sf /usr/local/bin/ipython* /usr/bin/

  echo "Done."
  echo
}

debian_9_ipython() {
  ipython_common
}

debian_10_ipython() {
  ipython_common
}

ubuntu_16_ipython() {
  ipython_common
}

ubuntu_18_ipython() {
  ipython_common
}

centos_7_ipython() {
  ipython_common
}

centos_8_ipython() {
  ipython_common
}
