#!/bin/bash

ipython_common() {
  echo "Installing IPython..."
  pip3 install -qqq --no-cache-dir --upgrade ipython
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
