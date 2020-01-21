#!/bin/bash

# Copyright The Helm Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# The install script is based off of the MIT-licensed script from glide,
# the package manager for Go: https://github.com/Masterminds/glide.sh/blob/master/get

enable_helm_bash_completion() {
  helm_bash_dest="/etc/profile.d/helm_bash.sh"
  helm completion bash > "${helm_bash_dest}"
}

helm_common() {

  PROJECT_NAME="helm"

  : "${USE_SUDO:="true"}"
  : "${HELM_INSTALL_DIR:="/usr/bin"}"

  # initArch discovers the architecture for this system.
  initArch() {
    ARCH=$(uname -m)
    case $ARCH in
      armv5*) ARCH="armv5";;
      armv6*) ARCH="armv6";;
      armv7*) ARCH="arm";;
      aarch64) ARCH="arm64";;
      x86) ARCH="386";;
      x86_64) ARCH="amd64";;
      i686) ARCH="386";;
      i386) ARCH="386";;
    esac
  }

  # initOS discovers the operating system for this system.
  initOS() {
    OS=$(uname | tr '[:upper:]' '[:lower:]')

    case "$OS" in
      # Minimalist GNU for Windows
      mingw*) OS='windows';;
    esac
  }

  # runs the given command as root (detects if we are root already)
  runAsRoot() {
    local CMD="$*"

    if [ $EUID -ne 0 ] && [ $USE_SUDO = "true" ]; then
      CMD="sudo $CMD"
    fi

    $CMD
  }

  # verifySupported checks that the os/arch combination is supported for
  # binary builds.
  verifySupported() {
    local supported="darwin-386\ndarwin-amd64\nlinux-386\nlinux-amd64\nlinux-arm\nlinux-arm64\nlinux-ppc64le\nwindows-386\nwindows-amd64"
    if ! echo "${supported}" | grep -q "${OS}-${ARCH}"; then
      echo "No prebuilt binary for ${OS}-${ARCH}."
      echo "To build from source, go to https://github.com/helm/helm"
      exit 1
    fi
  }

  # checkDesiredVersion checks if the desired version is available.
  checkDesiredVersion() {
    if [ "x$DESIRED_VERSION" == "x" ]; then
      # Get tag from release URL
      local latest_release_url="https://github.com/helm/helm/releases/latest"
      TAG=$(curl -sSL -o /dev/null -w '%{url_effective}' ${latest_release_url} | grep -oE "[^/]+$" )
    else
      TAG=$DESIRED_VERSION
    fi
  }

  # checkHelmInstalledVersion checks which version of helm is installed and
  # if it needs to be changed.
  checkHelmInstalledVersion() {
    if [[ -f "${HELM_INSTALL_DIR}/${PROJECT_NAME}" ]]; then
      local version
      version=$("${HELM_INSTALL_DIR}/${PROJECT_NAME}" version --template="{{ .Version }}")
      if [[ "$version" == "$TAG" ]]; then
        echo "The latest Helm version ${version} is already installed"
        echo
        return 0
      else
        echo "Helm ${TAG} is available. Changing from version ${version}."
        return 1
      fi
    else
      return 1
    fi
  }

  # downloadFile downloads the latest binary package and also the checksum
  # for that binary.
  downloadFile() {
    HELM_DIST="helm-$TAG-$OS-$ARCH.tar.gz"
    DOWNLOAD_URL="https://get.helm.sh/$HELM_DIST"
    CHECKSUM_URL="$DOWNLOAD_URL.sha256"
    HELM_TMP_ROOT="$(mktemp -dt helm-installer-XXXXXX)"
    HELM_TMP_FILE="$HELM_TMP_ROOT/$HELM_DIST"
    HELM_SUM_FILE="$HELM_TMP_ROOT/$HELM_DIST.sha256"

    echo "Downloading $DOWNLOAD_URL"
    curl -sSL "$CHECKSUM_URL" -o "$HELM_SUM_FILE"
    curl -sSL "$DOWNLOAD_URL" -o "$HELM_TMP_FILE"
  }

  # installFile verifies the SHA256 for the file, then unpacks and
  # installs it.
  installFile() {
    HELM_TMP="$HELM_TMP_ROOT/$PROJECT_NAME"

    local sum
    sum=$(sha256sum "${HELM_TMP_FILE}" | awk '{print $1}')

    local expected_sum
    expected_sum=$(cat "${HELM_SUM_FILE}")

    if [ "$sum" != "$expected_sum" ]; then
      echo "SHA sum of ${HELM_TMP_FILE} does not match. Aborting."
      exit 1
    fi

    mkdir -p "$HELM_TMP"
    tar xf "$HELM_TMP_FILE" -C "$HELM_TMP"
    HELM_TMP_BIN="$HELM_TMP/$OS-$ARCH/$PROJECT_NAME"
    echo "Preparing to install $PROJECT_NAME into ${HELM_INSTALL_DIR}"
    runAsRoot cp "$HELM_TMP_BIN" "$HELM_INSTALL_DIR"
    echo "$PROJECT_NAME installed into $HELM_INSTALL_DIR/$PROJECT_NAME"
  }

  # fail_trap is executed if an error occurs.
  fail_trap() {
    result=$?
    if [ "$result" != "0" ]; then
      if [[ -n "$INPUT_ARGUMENTS" ]]; then
        echo "Failed to install $PROJECT_NAME with the arguments provided: $INPUT_ARGUMENTS"
        help
      else
        echo "Failed to install $PROJECT_NAME"
      fi
      echo -e "\tFor support, go to https://github.com/helm/helm."
    fi
    cleanup
    exit $result
  }

  # help provides possible cli installation arguments
  help () {
    echo "Accepted cli arguments are:"
    echo -e "\t[--help|-h ] ->> prints this help"
    echo -e "\t[--version|-v <desired_version>] . When not defined it fetches the latest release from GitHub"
    echo -e "\te.g. --version v3.0.0 or -v canary"
    echo -e "\t[--no-sudo]  ->> install without sudo"
  }

  # cleanup temporary files to avoid https://github.com/helm/helm/issues/2977
  cleanup() {
    if [[ -d "${HELM_TMP_ROOT:-}" ]]; then
      rm -rf "$HELM_TMP_ROOT"
    fi
  }

  # Execution

  #Stop execution on any error
  trap "fail_trap" EXIT
  set -e

  # Parsing input arguments (if any)
  export INPUT_ARGUMENTS=( "$@" )
  set -u
  while [[ $# -gt 0 ]]; do
    case $1 in
      '--version'|-v)
         shift
         if [[ $# -ne 0 ]]; then
             export DESIRED_VERSION="${1}"
         else
             echo -e "Please provide the desired version. e.g. --version v3.0.0 or -v canary"
             exit 0
         fi
         ;;
      '--no-sudo')
         USE_SUDO="false"
         ;;
      '--help'|-h)
         help
         exit 0
         ;;
      *) exit 1
         ;;
    esac
    shift
  done
  set +u

  initArch
  initOS
  verifySupported
  checkDesiredVersion

  if ! checkHelmInstalledVersion; then
    downloadFile
    installFile
  fi

  cleanup

  enable_helm_bash_completion
}

ubuntu_16_helm() {
  helm_common
}

ubuntu_18_helm() {
  helm_common
}

debian_9_helm() {
  helm_common
}

debian_10_helm() {
  helm_common
}

centos_7_helm() {
  helm_common
}

centos_8_helm() {
  helm_common
}
