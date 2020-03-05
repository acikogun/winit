#!/bin/bash

enable_npm_bash_completion() {
  npm_bash_dest="/etc/profile.d/npm_bash.sh"
  echo "source <(npm completion bash)" > "${npm_bash_dest}"
}

node_npm() {
  echo "Updating npm..."
  npm install -g npm@latest
  echo "Done."
}

node_yarn() {
  echo "Installing Yarn..."
  npm install -g yarn
  echo "Done."
}

node_common() {
  local api_url="https://nodejs.org/dist/index.tab"

  local lts_codename="Erbium"
  local node_remote_version
  node_remote_version=$(curl -sSL "${api_url}" | grep "${lts_codename}" | head -1 | awk '{print $1}')

  local download_file="node-${node_remote_version}-linux-x64.tar.xz"

  local download_url="https://nodejs.org/dist/${node_remote_version}/${download_file}"
  local prefix="/usr/bin"
  local download_dest="/tmp/${download_file}"

  if [[ -f "${prefix}/node" ]]; then
    local node_local_version
    node_local_version=$("${prefix}"/node -v)
  fi

  download_node() {
    echo "Downloading ${download_file}..."
    curl -sSL "${download_url}" -o "${download_dest}"
    echo "Done."
  }

  install_node() {
    echo "Installing node ${node_remote_version}..."
    tar -C /usr -xf "${download_dest}" --overwrite --strip 1

    rm -rf /tmp/node*

    echo "Done."
  }

  if [[ "${node_remote_version}" != "${node_local_version}" ]]; then
    download_node
    install_node
    node_npm
    node_yarn
    enable_npm_bash_completion
  else
    echo "The latest node version ${node_local_version} is already installed."
  fi
}

debian_9_node() {
  node_common
}

debian_10_node() {
  node_common
}

ubuntu_16_node() {
  node_common
}

ubuntu_18_node() {
  node_common
}

centos_7_node() {
  node_common
}

centos_8_node() {
  node_common
}
