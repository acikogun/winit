#!/bin/bash

alias debian_cloudsdk=ubuntu_cloudsdk
alias fedora_cloudsdk=centos_cloudsdk

ubuntu_cloudsdk() {
  # Add the Cloud SDK distribution URI as a package source
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | \
  tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

  # Import the Google Cloud Platform public key
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
  apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

  # Update the package list and install the Cloud SDK
  apt-get update && apt-get install google-cloud-sdk -y

  # Install kubectl
  apt-get install kubectl -y

  # Enable autocompletion for kubectl
  echo "source <(kubectl completion bash)" >> ~/.bashrc
}

centos_cloudsdk() {
  # Update YUM with Cloud SDK repo information:
  tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
  
  # Install the Cloud SDK
  yum install google-cloud-sdk -y

  # Install kubectl
  yum install kubectl -y

  # Enable autocompletion for kubectl
  echo "source <(kubectl completion bash)" >> ~/.bashrc
}