#!/bin/bash
#
# Easily install Go from official binaries to linux/amd64 platforms.
# Copyright (C) 2019 Ogun Acik
#
# Requirements: su permission, git, curl
#
# Option flags:
#   -f : Remove the existing go installation if present prior to install
#   
# Environments:
#    v : Go version  default: (LATEST)
#    p : GOPATH      default: /opt/go
#   
# Examples:
#    $ sudo ./go.sh go
#      Install the latest version of Go and export GOPATH=/opt/go
#   
#    $ sudo v=1.11.13 p=~/go ./go.sh go -f
#      Install Go 1.11.13 and export GOPATH=~/go
#      Remove the existing Go installation if present
#  
# NOTE: Don't forget to run source ~/.bashrc\ after installation.

# Get the latest stable version of Go
default_version=$(curl -sS https://golang.org/VERSION?m=text | cut -c 3-)
default_gopath="/opt/go"
v=${v:-$default_version}
p=${p:-$default_gopath}

example_project="github.com/golang/example/hello"
download_file="go${v}.linux-amd64.tar.gz"
download_url="https://dl.google.com/go/${download_file}"

prefix="/usr/local"
userbin="${prefix}/bin"
gobin="${prefix}/go/bin"

pre_clean() {
  rm -rf ${userbin}/go
  rm -rf ${userbin}/godoc
  rm -rf ${userbin}/gofmt
  rm -rf ${prefix}/go
}

download_go() {
  if [[ "${1}" = "-f" ]]; then
    rm -f /tmp/$download_file
  fi

  if ! [[ -f "/tmp/${download_file}" ]]; then
    echo -n "Downloading $download_file ..."
    curl -fsSL $download_url -o /tmp/$download_file
    echo -n "Done."
    echo
  fi
}

install_go() {
 if [[ -f "${gobin}/go" ]]; then
    go_version=$(${gobin}/go version | awk '{print $3}')
    read -p "$go_version found. Remove it? [y / n] " remove
   
    if [[ "${remove}" = "n" ]]; then
      exit
    fi
 fi

  download_go ${1}
  pre_clean

  echo -n "Installing Go $v ... "
  tar -C ${prefix} -xf /tmp/$download_file

  # Create symbolic links in to /usr/local/bin which is set in PATH
  ln -s ${gobin}/go ${userbin}/go
  ln -s ${gobin}/godoc ${userbin}/godoc
  ln -s ${gobin}/gofmt ${userbin}/gofmt
  
  # Create GOPATH directory if doesn't exist
  if ! [[ -d "${p}" ]]; then
    mkdir -p "${p}"
  fi

  # Add GOPATH to .bashrc if not exists or update if exists
  if ! $(grep "export GOPATH" ~/.bashrc); then 
    echo "export GOPATH=${p}" >> ~/.bashrc
  else
    sed -i "/export GOPATH=.*/c\export GOPATH=$p" ~/.bashrc
  fi

  echo -n "Done."
  echo
}

test_installation() {
  # Export current GOPATH for testing
  export GOPATH="${p}"
  
  echo "Testing installation... "
  ${userbin}/go get $example_project
  ${userbin}/go run $example_project
  echo "Done."
}

install_go ${1}
test_installation

echo "Go installed successfully."
echo "Run \"source ~/.bashrc\" to load GOPATH to current session"
