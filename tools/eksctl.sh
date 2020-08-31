#!/bin/bash

enable_eksctl_bash_completion() {
  eksctl_bash_dest="/etc/profile.d/eksctl_bash.sh"
  echo "source <(eksctl completion bash)" > "${eksctl_bash_dest}"
}

eksctl_common() {
  local api_url="https://api.github.com/repos/weaveworks/eksctl/releases/latest"
  local eksctl_remote_version
  eksctl_remote_version=$(curl -sSL "${api_url}" | jq -r .name | grep -E -v 'alpha|beta|rc' \
   | head -1 | awk '{print $2}')

  local download_file="eksctl_Linux_amd64.tar.gz"
  local download_url="https://github.com/weaveworks/eksctl/releases/download/\
${eksctl_remote_version}/${download_file}"

  local prefix="/usr/bin"
  local download_dest="/tmp/${download_file}"

  if [[ -f "${prefix}/eksctl" ]]; then
    local eksctl_local_version
    eksctl_local_version=$("${prefix}"/eksctl version | cut -d ',' -f 3 | cut -d '"' -f 2)
  fi

  download_eksctl() {
    echo "Downloading ${download_file}..."
    curl -sSL "${download_url}" -o "${download_dest}"
    echo "Done."
  }

  install_eksctl() {
    rm -rf ${prefix}/eksctl

    echo "Installing eksctl..."
    tar -C "${prefix}" -xf "${download_dest}"

    rm -rf /tmp/eksctl*
    echo "Done."
  }

  if [[ "${eksctl_remote_version}" != "${eksctl_local_version}" ]]; then
    download_eksctl
    install_eksctl
    enable_eksctl_bash_completion
  else
    echo "The latest Eksctl version ${eksctl_remote_version} is already installed."
  fi
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

ubuntu_20_eksctl() {
  eksctl_common
}

centos_7_eksctl() {
  eksctl_common
}

centos_8_eksctl() {
  eksctl_common
}
