#!/bin/bash

source functions/globals.sh
source functions/common.sh
source test/common.sh

test_list=$(get_tool_list)

# Test tool(s)
for test_pkg in ${test_list}; do
  if [[ "${test_pkg:0:1}" == "#" ]]; then
    print_yellow "Skipped ${test_pkg:1}"
  else
    "test_${test_pkg}"
  fi
done
