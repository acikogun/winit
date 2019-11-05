#!/bin/bash

terraform_common() {
  local latest_release_url="https://github.com/hashicorp/terraform/releases/latest"
  # Get the latest version
  terraform_version=$(curl -Ls -o /dev/null -w %{url_effective} $latest_release_url | \
  grep -oE "[^/]+$" | cut -d 'v' -f2 )

  download_file="terraform_${terraform_version}_linux_amd64.zip"
  download_url="https://releases.hashicorp.com/terraform/${terraform_version}/${download_file}"

  prefix="/usr/bin"

  download_terraform() {
    echo "Downloading "${download_file}"..."
    curl -sS ${download_url} -o /tmp/${download_file}
    echo "Done."
    echo
  }

  pre_clean() {
    rm -rf ${prefix}/terraform
  }

  post_clean() {
    rm -rf /tmp/terraform*
  }

  install_terraform() {
    echo "Installing Terraform ${terraform_version}..."
    unzip /tmp/$download_file -d /tmp
    cp /tmp/terraform $prefix
    echo "Done."
    echo
  }

  pre_clean
  download_terraform
  install_terraform
  post_clean
}

debian_9_terraform() {
  terraform_common
}

debian_10_terraform() {
  terraform_common
}

ubuntu_16_terraform() {
  terraform_common
}

ubuntu_18_terraform() {
  terraform_common
}

centos_7_terraform() {
  terraform_common
}
