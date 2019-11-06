#!/bin/bash

packer_common() {
  local latest_release_url="https://github.com/hashicorp/packer/releases/latest"
  # Get the latest version
  packer_version=$(curl -Ls -o /dev/null -w %{url_effective} $latest_release_url | \
  grep -oE "[^/]+$" | cut -d 'v' -f2 )

  download_file="packer_${packer_version}_linux_amd64.zip"
  download_url="https://releases.hashicorp.com/packer/${packer_version}/${download_file}"

  prefix="/usr/bin"

  download_packer() {
    echo "Downloading "${download_file}"..."
    curl -sS ${download_url} -o /tmp/${download_file}
    echo "Done."
    echo
  }

  install_packer() {
    rm -rf ${prefix}/packer

    echo "Installing packer ${packer_version}..."
    unzip /tmp/$download_file -d /tmp >/dev/null 2>&1
    cp /tmp/packer $prefix

    rm -rf /tmp/packer*
    echo "Done."
    echo
  }

  pre_clean
  download_packer
  install_packer
  post_clean
}

debian_9_packer() {
  packer_common
}

debian_10_packer() {
  packer_common
}

ubuntu_16_packer() {
  packer_common
}

ubuntu_18_packer() {
  packer_common
}

centos_7_packer() {
  packer_common
}
