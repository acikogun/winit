#!/bin/bash

awscli() {
  if ! pip=$(command -v pip); then
    source ./pip.sh
    pip_install
  fi

  # Install awscli 
  pip install --user awscli

  export PATH=$PATH:~/.local/bin

  # Register bin path and enable aws completer
  if ! $(grep "export PATH" ~/.bashrc | grep  -w ".local/bin"); then 
    echo "export PATH=$PATH:~/.local/bin" >> ~/.bashrc
  fi

  if ! $(grep -w "complete -C '~/.local/bin/aws_completer' aws" ~/.bashrc); then
    echo "complete -C '~/.local/bin/aws_completer' aws" >> ~/.bashrc
  fi
}