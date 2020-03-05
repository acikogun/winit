#!/bin/bash

vagrant_common() {
  local api_url="https://releases.hashicorp.com/vagrant/index.json"

  local vagrant_remote_version
  vagrant_remote_version=$(curl -sSL "${api_url}" | jq -r '.versions[].version' |\
  sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | grep -E -v 'alpha|beta|rc' | tail -1)

  local download_file="vagrant_${vagrant_remote_version}_linux_amd64.zip"
  local download_url="https://releases.hashicorp.com/vagrant/${vagrant_remote_version}/${download_file}"
  local prefix="/usr/bin"
  local download_dest="/tmp/${download_file}"

  if [[ -f "${prefix}/vagrant" ]]; then
    local vagrant_local_version
    vagrant_local_version=$("${prefix}"/vagrant -v | head -1 | awk '{print $2}')
  fi

  download_vagrant() {
    echo "Downloading ${download_file}..."
    curl -sSL "${download_url}" -o "${download_dest}"
    echo "Done."
  }

  install_vagrant() {
    rm -rf ${prefix}/vagrant

    echo "Installing Vagrant ${vagrant_remote_version}..."
    unzip "${download_dest}" -d /tmp >/dev/null 2>&1
    cp /tmp/vagrant $prefix

    rm -rf /tmp/vagrant*
    echo "Done."
  }

  if [[ "${vagrant_remote_version}" != "${vagrant_local_version}" ]]; then
    download_vagrant
    install_vagrant
  else
    echo "The latest Vagrant version ${vagrant_local_version} is already installed."
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

centos_8_vagrant() {
  vagrant_common
}
