#!/bin/bash
set -e

# Easily install workspace tools to Linux(Debian, Ubuntu, Fedora, CentOS)
#
# Available tools: go, docker, pip, awscli, cloudsdk. 
#
# Copyright (C) 2019 Ogun Acik
#
# Requirements: su permission, git, curl, python"

source ./tools/awscli.sh
source ./tools/cloudsdk.sh
source ./tools/docker.sh
source ./tools/go.sh
source ./tools/pip.sh

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

      $ sudo v=1.11.13 p=~/go ./install.sh go -f
      Install Go 1.11.13 and export GOPATH=~/go
      Remove the existing Go installation if present

      $ sudo ./install.sh docker
      Install the latest version of Docker

    NOTE: Don't forget to run source ~/.bashrc\ after installations.

EOF
}

get_distribution() {
  lsb_dist=""

  if [ -r /etc/os-release ]; then
    source /etc/os-release
    id="${ID}"
    version_id=$(echo "${VERSION_ID}" | cut -d "." -f 1)
  fi

  lsb_dist="$(echo "${id}"_"${version_id}" | tr '[:upper:]' '[:lower:]')"
  echo "${lsb_dist}"
}

cmd="$(get_distribution)"_"${app}"

  if c=$(command -v "${cmd}"); then
    "${cmd}"
    exit 0
  else
    display_help
  fi
