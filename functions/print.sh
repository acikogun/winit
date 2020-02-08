#!/bin/bash

readonly RESET="\033[0m"
readonly RED="\033[31m"
readonly GREEN="\033[32m"
readonly YELLOW="\033[33m"
readonly CYAN="\033[36m"

print_red() {
  printf "${RED}%s${RESET}\n" "$*"
}

print_yellow() {
  printf "${YELLOW}%s${RESET}\n" "$*"
}

print_green() {
  printf "${GREEN}%s${RESET}\n" "$*"
}

print_cyan() {
  printf "${CYAN}%s${RESET}\n" "$*"
}
