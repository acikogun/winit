#!/bin/bash

clear_logs() {
  rm -f "${log_dir:?}"/*
}

create_dirs() {
  mkdir -p "${log_dir:?}"
  mkdir -p "${cache_dir:?}"
}

print_red() {
  printf "${red:?}%s${reset:?}\n" "$*"
}

print_yellow() {
  printf "${yellow:?}%s${reset:?}\n" "$*"
}

print_green() {
  printf "${green:?}%s${reset:?}\n" "$*"
}

print_cyan() {
  printf "${cyan:?}%s${reset:?}\n" "$*"
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

get_tool_list() {
  echo "${available_tools:?}"
}

print_available_tools() {
  local tools=${available_tools:?}

  for tool in ${tools}; do
    print_cyan "  ${tool}"
  done
}

get_fail_list() {
  if [[ -n "${failed_tools:-}" ]];then
    echo "${failed_tools:?}"
  fi
}

display_help() {
  cat << EOF

USAGE: $(basename "$0") [OPTIONS] [TOOL...]

COPYRIGHT:  Copyright (c) 2019- Ogun Acik

DESCRIPTION:
  An extensible installer for tools I use on my development workstation.
  Supported platforms : linux/amd64
  Supported distros   : Debian{9,10} Ubuntu{16,18} Centos{7,8}

OPTIONS:
  -h - Show this help
  -l - List all available tools
  -a - Install all tools listed in ${tools_file:?}. No other arguments required.
       If you want to ignore any tool in ${tools_file}, comment it out with hash sign (#).

EXAMPLES:
  $ sudo ./$(basename "$0") go docker cloudsdk
    # Install go, docker and cloudsdk

  $ sudo ./$(basename "$0") ansible
    # Install ansible

  $ sudo ./$(basename "$0") -a
    # Install all available tools

EOF
}
