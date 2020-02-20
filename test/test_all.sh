#!/bin/bash

source functions/globals.sh
source functions/common.sh
source test/common.sh

fail_list=$(get_fail_list)

if [[ -f "${fails_file:?}" ]]; then
  print_red "Failed tools:"
  cat "${fails_file:?}"

  for failed_tool in ${fail_list}; do
    if [[ -f "${log_dir:?}/${failed_tool}.log" ]]; then
      cat "${log_dir:?}/${failed_tool}.log"
    fi
  done
  exit 1
fi
