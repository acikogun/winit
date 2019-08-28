#!/bin/bash
set -e

# Easily install workspace tools to Linux(Debian, Ubuntu, Fedora, CentOS)
#
# Available tools: go, docker, awscli, cloudsdk. 
#
# TODO:
#  Implement versioning to tools other than Go.
#
# Copyright (C) 2019 Ogun ACIK
#
# Requirements: su permission, git, curl, python

app=${1}
gopt=${2}
cmd=""

display_help() {
  cat << EOF

  Usage: $0 [TOOL] [OPTION]
  Available tools: go, docker, pip, awscli, cloudsdk 

  Options:  -f: Redownload Go tar package even if it is downloaded   
  
  Globals (only for Go):
      v: Go version  default: 1.12.9
      p: GOPATH      default: /opt/go
   
  Examples:
      $ ./install.sh go
      Install Go 1.12.9 and export GOPATH=/opt/go
   
      $ v=1.11.13 p=~/goworkspace ./install.sh go -f
      Install Go 1.11.13 and export GOPATH=~/goworkspace
      Redownload Go tar package even if it is downloaded
   
      $ ./install.sh docker
      Install latest version of Docker
  
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

attach_dist() {
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
}

attach_app() {
  case "${app}" in
    go)
      source installers/go.sh "${gopt}"
      exit 0
      ;;
    docker)
      cmd="${cmd}docker"
      source installers/docker.sh
      "${cmd}"
      exit 0
      ;;
    cloudsdk)
      cmd="${cmd}cloudsdk"
      source installers/cloudsdk.sh
      "${cmd}"
      exit 0
      ;;
    awscli)
      source installers/awscli.sh
      awscli
      exit 0
      ;;
    *)
      display_help
      exit 0
      ;;
  esac
}


