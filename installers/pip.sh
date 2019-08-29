#!/bin/bash

pipurl="https://bootstrap.pypa.io/get-pip.py"

pip_install() {
  if ! pip=$(command -v pip); then
    pybin=$(command -v python)

    # Download, install and update pip
    curl -fsSL $pipurl -o /tmp/get-pip.py
    "${pybin}" /tmp/get-pip.py --user

    export PATH=$PATH:~/.local/bin

    if ! $(grep "export PATH" ~/.bashrc | grep  -w "~/.local/bin"); then 
      echo "export PATH=$PATH:~/.local/bin" >> ~/.bashrc
    fi

    "${pipbin}" install --upgrade pip
}
