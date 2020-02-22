#!/bin/bash

apt_azurecli() {
  local az_repo
  az_repo=$(lsb_release -cs)
  local repo="deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $az_repo main"

  local repo_file="/etc/apt/sources.list.d/azure-cli.list"

  local key="https://packages.microsoft.com/keys/microsoft.asc"
  local key_dest="/etc/apt/trusted.gpg.d/microsoft.asc.gpg"

  # Add the azurecli distribution URI as a package source
  echo "${repo}" > "${repo_file}"

  # Import the azurecli apt repo signing key
  curl -sSL "${key}" | apt-key --keyring "${key_dest}" add -

  # Install azurecli
  apt-get update

  echo "Installing azurecli..."
  apt-get install -y azure-cli
  echo "Done."
  echo
}

yum_azurecli() {
  local baseurl="https://packages.microsoft.com/yumrepos/azure-cli"
  local gpg_key="https://packages.microsoft.com/keys/microsoft.asc"
  local repo_file="/etc/yum.repos.d/azure-cli.repo"

  cat > "${repo_file}" << EOM
[azure-cli]
name=Azure CLI
baseurl=${baseurl}
enabled=1
gpgcheck=1
gpgkey=${gpg_key}
EOM

  echo "Installing azurecli..."
  yum install -y azure-cli
  echo "Done."
  echo
}

ubuntu_16_azurecli() {
  apt_azurecli
}

ubuntu_18_azurecli() {
  apt_azurecli
}

debian_9_azurecli() {
  apt_azurecli
}

debian_10_azurecli() {
  apt_azurecli
}

centos_7_azurecli() {
  yum_azurecli
}

centos_8_azurecli() {
  yum_azurecli
}
