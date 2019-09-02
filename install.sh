#!/bin/bash
set -e

# Easily install workspace tools to Linux(Debian, Ubuntu, Fedora, CentOS)
#
# Available tools: go, docker, pip, awscli, cloudsdk. 
#
# Copyright (C) 2019 Ogun Acik
#
# Requirements: su permission, git, curl, python"

app=${1}
gopt=${2}
cmd=""

display_help() {
  cat << EOF

  Usage: $0 [TOOL] [OPTION]
    Available tools: go, docker, pip, awscli, cloudsdk 

    Option flags:
      -h : Show this help text and exit
      -f : Remove the existing go installation if present prior to install
   
    Environments (only Go):
      v : Go version  default: (LATEST)
      p : GOPATH      default: /opt/go
   
    Examples:
      $ sudo ./install.sh go
      Install the latest version of Go and export GOPATH=/opt/go
   
      $ sudo v=1.11.13 p=~/goworkspace ./install.sh go -f
      Install Go 1.11.13 and export GOPATH=~/goworkspace
      Remove the existing Go installation if present
   
      $ sudo ./install.sh docker
      Install the latest version of Docker
  
    NOTE: Don't forget to run source ~/.bashrc\ after installations.

EOF
}

get_distribution() {
  lsb_dist=""
  
  if [ -r /etc/os-release ]; then
    lsb_dist="$(source /etc/os-release && echo "$ID")"
  fi
  
  lsb_dist="$(echo "$lsb_dist" | tr '[:upper:]' '[:lower:]')"
  echo "${lsb_dist}"
}


lsb_dist=$(get_distribution)

case "${lsb_dist}" in
  ubuntu)
    cmd="ubuntu_"
    ;;
  centos)
    cmd="centos_"
    ;;
  debian)
    cmd="debian_"
    ;;
  fedora)
    cmd="fedora_"
    ;;
esac

case "${app}" in
  go)
    source ./tools/go.sh "${gopt}"
    exit 0
    ;;
  docker)
    cmd="${cmd}docker"
    source ./tools/docker.sh
    "${cmd}"
    exit 0
    ;;
  cloudsdk)
    cmd="${cmd}cloudsdk"
    source ./tools/cloudsdk.sh
    "${cmd}"
    exit 0
    ;;
  pip)
    source ./tools/pip.sh
    pip_install
    exit 0
    ;;
  awscli)
    source ./tools/awscli.sh
    awscli
    exit 0
    ;;
  *)
    display_help
    exit 0
    ;;
esac