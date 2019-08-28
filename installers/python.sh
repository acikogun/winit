#!/bin/bash

get_python() {
  py=$(command -v python)
  py3=$(command -v python3)
  echo ${py3:-"${py}"}
}

pip_install() {
  pybin=$(get_python)

  # Download, install and update pip
  curl -O https://bootstrap.pypa.io/get-pip.py
  $pybin get-pip.py --user

  export PATH=$PATH:~/.local/bin

  if ! $(grep "export PATH" .bashrc | grep  -w ".local/bin"); then 
    echo "export PATH=$PATH:~/.local/bin" >> ~/.bashrc
  fi

  ~/.local/bin/pip install --upgrade pip
}
