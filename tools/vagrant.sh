#!/bin/bash

vagrant_common() {
  local vagrant_version=$(curl -sL https://releases.hashicorp.com/vagrant/index.json | \
jq -r '.versions[].version' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | \
egrep -v 'alpha|beta|rc' | tail -1)

  local download_file="vagrant_${vagrant_version}_linux_amd64.zip"
  local download_url="https://releases.hashicorp.com/vagrant/${vagrant_version}/${download_file}"
  local prefix="/usr/bin"

  if [[ -f "${prefix}/vagrant" ]]; then
    local vagrant_installed=$("${prefix}"/vagrant -v | head -1 | awk '{print $2}')
  fi

  download_vagrant() {
    echo "Downloading "${download_file}"..."
    curl -sS ${download_url} -o /tmp/${download_file}
    echo "Done."
    echo
  }

  install_vagrant() {
    rm -rf ${prefix}/vagrant

    echo "Installing Vagrant ${vagrant_version}..."
    unzip /tmp/$download_file -d /tmp >/dev/null 2>&1
    cp /tmp/vagrant $prefix

    rm -rf /tmp/vagrant*
    echo "Done."
    echo
  }

  if [[ $vagrant_version != $vagrant_installed ]]; then
    download_vagrant
    install_vagrant
  else
    echo "The latest Vagrant version $vagrant_installed is already installed."
    echo
  fi
}

debian_9_vagrant() {
  vagrant_common
}

debian_10_vagrant() {
  vagrant_common
}

ubuntu_16_vagrant() {
  vagrant_common
}

ubuntu_18_vagrant() {
  vagrant_common
}

centos_7_vagrant() {
  vagrant_common
}
