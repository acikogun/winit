#!/bin/bash

enable_eksctl_bash_completion() {
  eksctl_bash_dest="/etc/profile.d/eksctl_bash.sh"
  echo "source <(eksctl completion bash)" > "${eksctl_bash_dest}"
}

eksctl_common() {
  local download_file="eksctl_Linux_amd64.tar.gz"
  local download_url="https://github.com/weaveworks/eksctl/releases/download/latest_release/${download_file}"
  local prefix="/usr/bin"
  local download_dest="/tmp/${download_file}"
  curl -sSL https://api.github.com/repos/weaveworks/eksctl/releases/latest | jq -r .prerelease

  download_eksctl() {
    echo "Downloading ${download_file}..."
    curl -sSL "${download_url}" -o "${download_dest}"
    echo "Done."
    echo
  }

  install_eksctl() {
    rm -rf ${prefix}/eksctl

    echo "Installing eksctl..."
    tar -C "${prefix}" -xf "${download_dest}"

    rm -rf /tmp/eksctl*
    echo "Done."
    echo
  }

  download_eksctl
  install_eksctl
  enable_eksctl_bash_completion
}

debian_9_eksctl() {
  eksctl_common
}

debian_10_eksctl() {
  eksctl_common
}

ubuntu_16_eksctl() {
  eksctl_common
}

ubuntu_18_eksctl() {
  eksctl_common
}

centos_7_eksctl() {
  eksctl_common
}

centos_8_eksctl() {
  eksctl_common
}
