#!/bin/bash

# Disable interactive prompts for Debian based distros
export DEBIAN_FRONTEND=noninteractive

reset="\033[0m"
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
cyan="\033[36m"

logdir="/var/log/winit"
mkdir -p "${logdir}"

print_red() {
  printf "${red}%s${reset}\n" "$*"
}

print_yellow() {
  printf "${yellow}%s${reset}\n" "$*"
}

print_green() {
  printf "${green}%s${reset}\n" "$*"
}

print_cyan() {
  printf "${cyan}%s${reset}\n" "$*"
}

display_help() {

  local tools_file="tools.txt"

  # echo command combines multiple lines into one
  # shellcheck disable=SC2005
  available_tools_help="$(echo "$(cat ${tools_file})")"

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
  -a - Install all tools listed in tools.txt. No other arguments required.
       If you want to ignore any tool in tools.txt, comment it out with hash sign (#).

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
