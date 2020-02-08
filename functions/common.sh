#!/bin/bash

# Disable interactive prompts for Debian based distros
export DEBIAN_FRONTEND=noninteractive;

readonly RESET="\033[0m"
readonly RED="\033[31m"
readonly GREEN="\033[32m"
readonly YELLOW="\033[33m"
readonly CYAN="\033[36m"

print_red() {
  printf "${RED}%s${RESET}\n" "$*"
}

print_yellow() {
  printf "${YELLOW}%s${RESET}\n" "$*"
}

print_green() {
  printf "${GREEN}%s${RESET}\n" "$*"
}

print_cyan() {
  printf "${CYAN}%s${RESET}\n" "$*"
}

display_help() {
  cat << EOF

USAGE: $(basename "$0") [OPTIONS] [TOOL...]

COPYRIGHT:  Copyright (c) 2019 Ogun Acik

DESCRIPTION:
  Provisioner for tools I use on my development workstation.
  Supported platforms : linux/amd64
  Supported distros   : Debian{9,10} Ubuntu{16,18} Centos{7,8}
  Available tools     :
    ${available_tools_help}

OPTIONS:
  -h - Show this help and exit
  -a - Install all tools listed in ${tools_file}. No other arguments required.
       If you want to ignore any tool in ${tools_file}, comment it out with hash sign (#).

EXAMPLES:
  $ sudo ./$(basename "$0") go docker cloudsdk
    # Install go, docker and cloudsdk

  $ sudo ./$(basename "$0") ansible
    # Install ansible

  $ sudo ./$(basename "$0") -a
    # Install all available tools:
    ${available_tools_help}

EOF
}

get_distribution() {
  lsb_dist=""

  if [ -r /etc/os-release ]; then
    # shellcheck disable=SC1091
    source /etc/os-release
    id="${ID}"
    version_id_inline=$(echo "${VERSION_ID}" | cut -d "." -f 1)
  fi

  lsb_dist="$(echo "${id}_${version_id_inline}" | tr '[:upper:]' '[:lower:]')"
  echo "${lsb_dist}"
}
