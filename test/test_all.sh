#!/bin/bash

source functions/globals.sh
source functions/common.sh
source test/common.sh

if [[ -f "${log_dir:?}/fails.txt" ]]; then
  print_red "Failed tools:"
  cat "${log_dir:?}/fails.txt"
  exit 1
fi
