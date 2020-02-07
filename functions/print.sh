#!/bin/bash

readonly SGR_RESET="\033[0m"
readonly SGR_RED="\033[31m"
readonly SGR_GREEN="\033[32m"
readonly SGR_YELLOW="\033[33m"
readonly SGR_CYAN="\033[36m"

print_red() {
  printf "${SGR_RED}%s${SGR_RESET}\n" "$*"
}

print_yellow() {
  printf "${SGR_YELLOW}%s${SGR_RESET}\n" "$*"
}

print_green() {
  printf "${SGR_GREEN}%s${SGR_RESET}\n" "$*"
}

print_cyan() {
  printf "${SGR_CYAN}%s${SGR_RESET}\n" "$*"
}
