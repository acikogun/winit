#!/bin/bash

# Disable interactive prompts for Debian based distros
export DEBIAN_FRONTEND=noninteractive

export reset="\033[0m"
export red="\033[31m"
export green="\033[32m"
export yellow="\033[33m"
export cyan="\033[36m"

export tools_file="tools.txt"
available_tools="$(cat "${tools_file}")"
export available_tools

export log_dir="/var/log/winit"

export fails_file="${log_dir}/fails.txt"

if [[ -f "${fails_file:?}" ]];then
  failed_tools="$(sort -n "${fails_file}" | uniq)"
  export failed_tools
fi

export cache_dir="/var/cache/winit"
export requirements_installed="requirements_installed"
export requirements_cache_file="${cache_dir}/${requirements_installed}"
