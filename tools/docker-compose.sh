#!/bin/bash

docker_compose_common() {
  local api_url="https://api.github.com/repos/docker/compose/releases/latest"
  local docker_compose_version
  docker_compose_version=$(curl -sSL "${api_url}" | jq -r .name)

  local download_file="docker-compose-Linux-x86_64"
  local download_url="https://github.com/docker/compose/releases/download/${docker_compose_version}/${download_file}"

  local prefix="/usr/bin"
  local download_dest="${prefix}/docker-compose"

  if [[ -f "${prefix}/docker-compose" ]]; then
    local docker_compose_installed
    docker_compose_installed="$("${prefix}"/docker-compose -v | awk '{print $3}' | cut -d ',' -f 1)"
  fi

  install_docker_compose() {
    echo "Installing ${download_file}..."
    curl -L "${download_url}" -o "${download_dest}"
    chmod +x "${download_dest}"
    echo "Done."
  }

  if [[ "${docker_compose_version}" != "${docker_compose_installed}" ]]; then
    install_docker_compose
  else
    echo "The latest docker-compose version ${docker_compose_version} is already installed."
  fi
}

ubuntu_16_docker-compose() {
  docker_compose_common
}

ubuntu_18_docker-compose() {
  docker_compose_common
}

debian_9_docker-compose() {
  docker_compose_common
}

debian_10_docker-compose() {
  docker_compose_common
}

centos_7_docker-compose() {
  docker_compose_common
}

centos_8_docker-compose() {
  docker_compose_common
}
