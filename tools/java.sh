#!/bin/bash

apt_java_repo() {
  local apt_repo="https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/"
  local apt_key_url="https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public"

  curl -sSL "${apt_key_url}" | apt-key add -

  add-apt-repository --yes "${apt_repo}"
}

apt_java() {
  local java_version="${1}"
  apt_java_repo

  apt-get update

  echo "Installing java${java_version}..."
  apt-get install -y "adoptopenjdk-${java_version}-hotspot"
  echo "Done."
  echo
}

yum_java_repo() {
  local rpm_baseurl="http://adoptopenjdk.jfrog.io/adoptopenjdk/rpm/centos/7/x86_64"
  local rpm_key="https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public"
  local repo_file="/etc/yum.repos.d/adoptopenjdk.repo"

  cat > "${repo_file}" << EOM
[AdoptOpenJDK]
name=AdoptOpenJDK
baseurl=${rpm_baseurl}
enabled=1
gpgcheck=1
gpgkey=${rpm_key}
EOM
}

yum_java() {
  local java_version="${1}"
  yum_java_repo

  echo "Installing java${java_version}..."
  yum install -y "adoptopenjdk-${java_version}-hotspot"
  echo "Done."
  echo
}

# Debian handlers
debian_9_java8() {
  apt_java 8
}

debian_9_java11() {
  apt_java 11
}

debian_10_java8() {
  apt_java 8
}

debian_10_java11() {
  apt_java 11
}

# Ubuntu handlers
ubuntu_16_java8() {
  apt_java 8
}

ubuntu_16_java11() {
  apt_java 11
}

ubuntu_18_java8() {
  apt_java 8
}

ubuntu_18_java11() {
  apt_java 11
}

# CentOS handlers
centos_7_java8() {
  yum_java 8
}

centos_7_java11() {
  yum_java 11
}

centos_8_java8() {
  yum_java 8
}

centos_8_java11() {
  yum_java 11
}
