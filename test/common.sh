#!/bin/bash

test_command() {
  if command -v "$1" > /dev/null; then
    print_green "$1 installed successfully."
  else
    print_red "ERROR: Unable to install ${pkg:?}."
    print_red "See ${log_dir:?}/${pkg:?}.log"
  fi
}

test_ansible() {
  test_command ansible
}

test_awscli() {
  test_command aws
}

test_azurecli() {
  test_command az
}

test_cloudsdk() {
  test_command gcloud
  test_command kubectl
}

test_docker() {
  test_command docker
}

test_eksctl() {
  test_command eksctl
}

test_go() {
  test_command go
}

test_helm() {
  test_command helm
}

test_ipython() {
  test_command ipython
}

test_node() {
  test_command node
  test_command npm
  test_command yarn
}

test_packer() {
  test_command packer
}

test_shellcheck() {
  test_command shellcheck
}

test_terraform() {
  test_command terraform
}

test_vagrant() {
  test_command vagrant
}
