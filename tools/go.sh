#!/bin/bash

go_common() {
  local go_remote_version
  go_remote_version=$(curl -sSL https://golang.org/VERSION?m=text | cut -c 3-)
  local user_home_dir=""
  local go_gopath=""

  local download_file="go${go_remote_version}.linux-amd64.tar.gz"
  local download_url="https://dl.google.com/go/${download_file}"
  local download_dest="/tmp/${download_file}"

  local prefix="/usr"
  local userbin="${prefix}/bin"
  local gobin="${prefix}/go/bin"

  if [[ -f "${gobin}/go" ]]; then
    local go_local_version
    go_local_version=$("${gobin}"/go version | awk '{print $3}' | cut -c 3-)
  fi

  set_user_home() {
    if [[ -n "${SUDO_USER}" ]]  && ! [[ "${SUDO_USER}" = "root" ]]; then
      user_home_dir="/home/${SUDO_USER}"
    else
      user_home_dir="${HOME}"
    fi
  }

  create_gopath() {
    set_user_home

    go_gopath="${user_home_dir}/.go"
    # Create GOPATH directory if doesn't exist
    if ! [[ -d "${go_gopath}" ]]; then
      mkdir -p "${go_gopath}"
    fi
  }

  change_gopath_owner() {
    # If a sudo user is running this script,
    # switch GOPATH owner from root to this sudo user.
    if [[ -n "${SUDO_USER}" ]]; then
      chown -R "${SUDO_USER}":"${SUDO_USER}" "${go_gopath}"
    fi
  }

  download_go() {
    echo "Downloading ${download_file}..."
    curl -sSL "${download_url}" -o "${download_dest}"
    echo "Done."
  }

  install_go() {
    download_go

    rm -rf ${userbin}/go
    rm -rf ${userbin}/gofmt
    rm -rf ${prefix}/go

    echo "Installing Go ${go_remote_version}..."
    tar -C ${prefix} -xf "${download_dest}"

    # Create symbolic links in to /usr/local/bin which is set in PATH
    ln -sf ${gobin}/go* ${userbin}/

    # Add GOPATH to .bashrc if not exists or update if exists
    if ! grep "export GOPATH" "${user_home_dir}/.bashrc"; then
      echo "export GOPATH=${go_gopath}" >> "${user_home_dir}/.bashrc"
    else
      sed -i "/export GOPATH=.*/c\export GOPATH=${go_gopath}" "${user_home_dir}/.bashrc"
    fi

    rm -rf /tmp/go*

    echo "Done."
  }

  if [[ "${go_remote_version}" != "${go_local_version}" ]]; then
    create_gopath
    install_go
    change_gopath_owner
  else
    echo "The latest Go version ${go_local_version} is already installed."
  fi
}

debian_9_go() {
  go_common
}

debian_10_go() {
  go_common
}

ubuntu_16_go() {
  go_common
}

ubuntu_18_go() {
  go_common
}

ubuntu_20_go() {
  go_common
}

centos_7_go() {
  go_common
}

centos_8_go() {
  go_common
}
