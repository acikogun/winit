#!/bin/bash

go_common() {
  go_version=$(curl -sS https://golang.org/VERSION?m=text | cut -c 3-)
  user_home_dir=""
  go_gopath=""

  example_project="github.com/golang/example/hello"
  download_file="go${go_version}.linux-amd64.tar.gz"
  download_url="https://dl.google.com/go/${download_file}"

  prefix="/usr"
  userbin="${prefix}/bin"
  gobin="${prefix}/go/bin"

  pre_clean() {
    rm -rf ${userbin}/go
    rm -rf ${userbin}/gofmt
    rm -rf ${prefix}/go
  }

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
    echo "Downloading "${download_file}"..."
    curl -sS ${download_url} -o /tmp/${download_file}
    echo "Done."
    echo
  }

  download_check() {
    if [[ -f "/tmp/${download_file}" ]]; then
      read -p "${download_file} found. Force redownload? [y / n] " redownload

      if [[ "${redownload}" = "y" ]]; then
        download_go
      fi
    else
      download_go
    fi
  }

  install_go() {
    download_check
    pre_clean

    echo "Installing Go ${go_version}..."
    tar -C ${prefix} -xf /tmp/$download_file

    # Create symbolic links in to /usr/local/bin which is set in PATH
    ln -sf ${gobin}/go ${userbin}/go
    ln -sf ${gobin}/gofmt ${userbin}/gofmt

    # Add GOPATH to .bashrc if not exists or update if exists
    if ! $(grep "export GOPATH" ${user_home_dir}/.bashrc); then
      echo "export GOPATH=${go_gopath}" >> "${user_home_dir}/.bashrc"
    else
      sed -i "/export GOPATH=.*/c\export GOPATH=${go_gopath}" "${user_home_dir}/.bashrc"
    fi

    echo "Done."
    echo
  }

  test_installation() {
    # Export current GOPATH for testing
    export GOPATH="${go_gopath}"

    echo "Testing Go installation..."
    ${userbin}/go get $example_project
    ${userbin}/go run $example_project
    echo "Done."
    echo
  }

  create_gopath
  install_go
  test_installation
  change_gopath_owner


}

ubuntu_16_go() {
  go_common
}

ubuntu_18_go() {
  go_common
}

debian_9_go() {
  go_common
}

debian_10_go() {
  go_common
}

centos_7_go() {
  go_common
}
