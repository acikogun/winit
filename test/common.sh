#!/bin/bash
#
# Tests that run after installation of each tool.
# Called inside from main script and doesn't exit if
# an installation fail
#

test_cmd() {
  if command -v "${1}" > /dev/null; then
    print_green "${1} installed successfully."
  else
    print_red "ERROR: Unable to install ${1}."
    print_red "See ${log_dir:?}/${pkg:?}.log"
    echo "${pkg}" >> "${log_dir:?}/fails.txt"
    echo "${1}" >> "${log_dir:?}/fails.txt"
  fi
}

test_ansible() {
  test_cmd ansible
}

test_awscli() {
  test_cmd aws
}

test_azurecli() {
  test_cmd az
}

test_cloudsdk() {
  test_cmd gcloud
  test_cmd kubectl
}

test_docker() {
  test_cmd docker
}

test_eksctl() {
  test_cmd eksctl
}

test_go() {
  test_cmd go
}

test_helm() {
  test_cmd helm
}

test_ipython() {
  test_cmd ipython
}

test_node() {
  test_cmd node
  test_cmd npm
  test_cmd yarn
}

test_packer() {
  test_cmd packer
}

test_shellcheck() {
  test_cmd shellcheck
}

test_terraform() {
  test_cmd terraform
}

test_vagrant() {
  test_cmd vagrant
}
