#!/bin/bash

apt_azurecli() {
  AZ_REPO=$(lsb_release -cs)
  local repo="deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main"

  local repo_dest="/etc/apt/sources.list.d/azure-cli.list"

  local key="https://packages.microsoft.com/keys/microsoft.asc"
  local key_dest="/etc/apt/trusted.gpg.d/microsoft.asc.gpg"

  # Add the azurecli distribution URI as a package source
  echo "${repo}" > "${repo_dest}"

  # Import the azurecli apt repo signing key
  curl -sL "${key}" | gpg --dearmor >/dev/null 2>&1

  # Install azurecli
  apt-get update >/dev/null 2>&1

  echo "Installing azurecli..."
  apt-get install -y azure-cli >/dev/null 2>&1
  echo "Done."
  echo

}

yum_azurecli() {
  local baseurl="https://packages.microsoft.com/yumrepos/azure-cli"
  local gpg_key="https://packages.microsoft.com/keys/microsoft.asc"


  cat > /etc/yum.repos.d/azure-cli.repo << EOM
[azure-cli]
name=Azure CLI
baseurl=${baseurl}
enabled=1
gpgcheck=1
gpgkey=${gpg_key}
EOM

  echo "Installing azurecli..."
  yum install -y azure-cli \
                 kubectl >/dev/null 2>&1
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
