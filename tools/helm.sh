#!/bin/bash

enable_helm_bash_completion() {
  helm_bash_dest="/etc/profile.d/helm_bash.sh"
  helm completion bash > "${helm_bash_dest}"
}

helm_common() {
  enable_helm_bash_completion
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
