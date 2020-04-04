#!/bin/bash

enable_helm_bash_completion() {
  helm_bash_dest="/etc/profile.d/helm_bash.sh"
  helm completion bash > "${helm_bash_dest}"
}

helm_common() {
  local api_url="https://api.github.com/repos/helm/helm/releases"
  local helm_remote_version
  helm_remote_version=$(curl -sSL "${api_url}" | jq -r .[].tag_name | grep ^v3 | head -1)

  local download_file="helm-${helm_remote_version}-linux-amd64.tar.gz"
  local download_url="https://get.helm.sh/${download_file}"

  local prefix="/usr/bin"
  local download_dest="/tmp/${download_file}"

  if [[ -f "${prefix}/helm" ]]; then
    local helm_local_version
    helm_local_version=$("${prefix}"/helm version | cut -d '"' -f 2)
  fi

  download_helm() {
    echo "Downloading ${download_file}..."
    curl -sSL "${download_url}" -o "${download_dest}"
    echo "Done."
  }

  install_helm() {
    rm -rf ${prefix}/helm

    echo "Installing Helm..."

    tar -C "${prefix}" -xf "${download_dest}" --strip 1

    rm -f /usr/{LICENSE,README.md,CHANGELOG.md}

    rm -rf /tmp/helm*
    echo "Done."
  }

  if [[ "${helm_remote_version}" != "${helm_local_version}" ]]; then
    download_helm
    install_helm
    enable_helm_bash_completion
  else
    echo "The latest Helm version ${helm_remote_version} is already installed."
  fi
}

ubuntu_16_helm() {
  helm_common
}

ubuntu_18_helm() {
  helm_common
}

debian_9_helm() {
  helm_common
}

debian_10_helm() {
  helm_common
}

centos_7_helm() {
  helm_common
}

centos_8_helm() {
  helm_common
}
