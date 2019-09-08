#!/bin/bash

enable_kubectl_bash_completion() {
  kubeclt_bash_dest="/etc/profile.d/kubectl_bash.sh"
  rm -f "${kubeclt_bash_dest}"
  echo "source <(kubectl completion bash)" >> "${kubeclt_bash_dest}"
}

ubuntu_cloudsdk() {
  local apt_repo="deb [signed-by=/usr/share/keyrings/cloud.google.gpg] \
  http://packages.cloud.google.com/apt cloud-sdk main"

  local apt_key_url="https://packages.cloud.google.com/apt/doc/apt-key.gpg"
  local apt_key_dest="/usr/share/keyrings/cloud.google.gpg"

  # Add the Cloud SDK distribution URI as a package source
  echo "${apt_repo}" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

  # Import the Google Cloud Platform public key
  curl -sS "${apt_key_url}" | apt-key --keyring "${apt_key_dest}" add -

  # Update the package list and install the Cloud SDK, kubectl and bash-completion
  apt-get update -y

  apt-get install -y google-cloud-sdk \
                     kubectl \

  # Enable autocompletion for kubectl
  enable_kubectl_bash_completion
}

centos_cloudsdk() {
  local rpm_baseurl="https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64"
  local rpm_key="https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg"
  local yum_key="https://packages.cloud.google.com/yum/doc/yum-key.gpg"

  # Update YUM with Cloud SDK repo information:
  tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=${rpm_baseurl}
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=${yum_key}
       ${rpm_key}
EOM

  # Install the Cloud SDK, kubectl and bash-completion
  yum install -y google-cloud-sdk \
                 kubectl \

  # Enable autocompletion for kubectl
  enable_kubectl_bash_completion
}

ubuntu_16_cloudsdk() {
  ubuntu_cloudsdk
}

ubuntu_18_cloudsdk() {
  ubuntu_cloudsdk
}

debian_9_cloudsdk() {
  ubuntu_cloudsdk
}

debian_10_cloudsdk() {
  ubuntu_cloudsdk
}

centos_7_cloudsdk() {
  centos_cloudsdk
}

fedora_30_cloudsdk() {
  centos_cloudsdk
}
