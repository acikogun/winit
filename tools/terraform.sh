#!/bin/bash

terraform_common() {
  local latest_release_url="https://github.com/hashicorp/terraform/releases/latest"
  local terraform_version=$(curl -Ls -o /dev/null -w %{url_effective} $latest_release_url | \
  grep -oE "[^/]+$" | cut -d 'v' -f2 )

  local download_file="terraform_${terraform_version}_linux_amd64.zip"
  local download_url="https://releases.hashicorp.com/terraform/${terraform_version}/${download_file}"
  local prefix="/usr/bin"

  download_terraform() {
    echo "Downloading "${download_file}"..."
    curl -sS ${download_url} -o /tmp/${download_file}
    echo "Done."
    echo
  }

  install_terraform() {
    rm -rf ${prefix}/terraform

    echo "Installing Terraform ${terraform_version}..."
    unzip /tmp/$download_file -d /tmp >/dev/null 2>&1
    cp /tmp/terraform $prefix

    rm -rf /tmp/terraform*
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
