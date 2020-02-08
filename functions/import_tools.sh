#!/bin/bash

# Include all installer scripts
for tool_installer in tools/*; do
  # shellcheck disable=SC1090
  source "${tool_installer}"
done
