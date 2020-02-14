# Disable interactive prompts for Debian based distros
export DEBIAN_FRONTEND=noninteractive

export reset="\033[0m"
export red="\033[31m"
export green="\033[32m"
export yellow="\033[33m"
export cyan="\033[36m"

export tools_file="tools.txt"
export available_tools="$(cat ${tools_file})"

export log_dir="/var/log/winit"
export cache_dir="/var/cache/winit"
export commons_cache="commons_installed"
export commons_cache_path="${cache_dir}/${commons_cache}"
