#!/bin/bash

shellcheck_common() {
  local download_file="shellcheck-stable.linux.x86_64.tar.xz"
  local download_url="https://github.com/koalaman/shellcheck/\
releases/download/stable/${download_file}"

  local prefix="/usr/bin"
  local download_dest="/tmp/${download_file}"

  download_shellcheck() {
    echo "Downloading ${download_file}..."
    curl -sSL "${download_url}" -o "${download_dest}"
    echo "Done."
  }

  install_shellcheck() {
    rm -rf ${prefix}/shellcheck

    echo "Installing shellcheck..."
    tar -C "${prefix}" -xf "${download_dest}" --strip 1

    rm -rf /tmp/shellcheck*
    echo "Done."
  }

    download_shellcheck
    install_shellcheck
}

debian_9_shellcheck() {
  shellcheck_common
}

debian_10_shellcheck() {
  shellcheck_common
}

ubuntu_16_shellcheck() {
  shellcheck_common
}

ubuntu_18_shellcheck() {
  shellcheck_common
}

centos_7_shellcheck() {
  shellcheck_common
}

centos_8_shellcheck() {
  shellcheck_common
}
