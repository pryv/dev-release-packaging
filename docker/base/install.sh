#!/bin/bash
set -e
source /pd_build/helpers

main() {
  prepare
  packages
  nodejs
  configure
  cleanup
}

prepare() {
  header "Create app user"

  run addgroup --gid 9999 app
  run adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" app
  run usermod -L app
  run mkdir -p /home/app/.ssh
  run chmod 700 /home/app/.ssh
  run chown app:app /home/app/.ssh
}

packages() {
  header "Install APT packages"

  # many NPM packages contain native extensions and require a compiler
  run apt_install_minimal build-essential
  # bundler has to be able to pull dependencies from git
  run apt_install_minimal git
  # we need this for dist directory prep
  run apt_install_minimal rsync
   # we need this to install node
  run apt_install_minimal curl ca-certificates 
  # install runit
  run apt_install_minimal runit-run
  # install just 
  run curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /usr/local/bin
}

nodejs() {
  header "Installing Node.js"

  nodeversion=v18.16.0
  version=x64
  targz="node-${nodeversion}-linux-${version}.tar.xz"
  binary_url="https://nodejs.org/dist/${nodeversion}/${targz}"
  local_file="/var/spool/${targz}"
  shasum="44d93d9b4627fe5ae343012d855491d62c7381b236c347f7666a7ad070f26548"

  cd /var/spool

  # fetch the actual binary release
  run curl -O $binary_url

  # check the binary tar.gz against its sha256 sum
  run echo -n "$shasum $targz" | sha256sum -c -

  # install the binaries to where they want to go
  pushd /usr/
  run tar --strip-components 1 -xf $local_file

  # cleanup
  popd
  run rm $local_file
}

configure() {
  # disable cron
  # touch /etc/service/cron/down

  # remove services from our own base image that we will not use
  # (removal code here)

  # create base directory for Pryv installs
  mkdir -p /var/pryv
}

cleanup() {
  header "Finalizing"

  run apt-get remove -y autoconf automake
  cleanup_common
}

main "$@"
