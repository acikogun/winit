#!/bin/bash

node_npm() {
  echo "Updating npm..."
  npm install -g npm@latest
  echo "Done."
  echo
}

node_yarn() {
  echo "Installing Yarn..."
  npm install -g yarn
  echo "Done."
  echo
}

node_common() {
  local api_url="https://nodejs.org/dist/index.tab"

  local node_version
  local lts_codename="Erbium"
  node_version=$(curl -sSL "${api_url}" | grep "${lts_codename}" | head -1 | awk '{print $1}')

  local download_file="node-${node_version}-linux-x64.tar.xz"

  local download_url="https://nodejs.org/dist/${node_version}/${download_file}"
  local prefix="/usr/bin"
  local download_dest="/tmp/${download_file}"

  if [[ -f "${prefix}/node" ]]; then
    local node_installed
    node_installed=$("${prefix}"/node -v)
  fi

  download_node() {
    echo "Downloading ${download_file}..."
    curl -sSL "${download_url}" -o "${download_dest}"
    echo "Done."
    echo
  }

  install_node() {
    echo "Installing node ${node_version}..."
    tar -C /usr -xf "${download_dest}" --overwrite --strip 1

    rm -rf /tmp/node*

    echo "Done."
    echo
  }

  if [[ "${node_version}" != "${node_installed}" ]]; then
    download_node
    install_node
    node_npm
    node_yarn
  else
    echo "The latest node version ${node_installed} is already installed."
    echo
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
