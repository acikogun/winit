#!/bin/bash

enable_kubectl_bash_completion() {
  kubeclt_bash_dest="/etc/profile.d/kubectl_bash.sh"
  echo "source <(kubectl completion bash)" > "${kubeclt_bash_dest}"
}

apt_cloudsdk() {
  local apt_repo="deb [signed-by=/usr/share/keyrings/cloud.google.gpg]\
  http://packages.cloud.google.com/apt cloud-sdk main"
  local apt_repo_file="/etc/apt/sources.list.d/google-cloud-sdk.list"

  local apt_key_url="https://packages.cloud.google.com/apt/doc/apt-key.gpg"
  local apt_key_dest="/usr/share/keyrings/cloud.google.gpg"

  # Add the Cloud SDK distribution URI as a package source
  echo "${apt_repo}" > "${apt_repo_file}"

  # Import the Google Cloud Platform public key
  curl -sS "${apt_key_url}" | apt-key --keyring "${apt_key_dest}" add - >/dev/null 2>&1

  # Install the Cloud SDK and kubectl
  apt-get update >/dev/null 2>&1

  echo "Installing cloudsdk..."
  apt-get install -y google-cloud-sdk kubectl
  echo "Done."
  echo

  # Enable bash completion for kubectl
  enable_kubectl_bash_completion
}

yum_cloudsdk() {
  local rpm_baseurl="https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64"
  local rpm_key="https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg"
  local yum_key="https://packages.cloud.google.com/yum/doc/yum-key.gpg"
  local repo_file="/etc/yum.repos.d/google-cloud-sdk.repo"
  # Update YUM with Cloud SDK repo information:
  cat > "${repo_file}" << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=${rpm_baseurl}
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=${yum_key}
       ${rpm_key}
EOM

  echo "Installing cloudsdk..."
  yum install -y google-cloud-sdk kubectl
  echo "Done."
  echo

  # Enable autocompletion for kubectl
  enable_kubectl_bash_completion
}

ubuntu_16_cloudsdk() {
  apt_cloudsdk
}

ubuntu_18_cloudsdk() {
  apt_cloudsdk
}

debian_9_cloudsdk() {
  apt_cloudsdk
}

debian_10_cloudsdk() {
  apt_cloudsdk
}

centos_7_cloudsdk() {
  yum_cloudsdk
}

centos_8_cloudsdk() {
  yum_cloudsdk
}
