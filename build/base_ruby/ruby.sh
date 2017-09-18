#!/bin/bash
set -e
source /pd_build/buildconfig

header "Installing ruby-build"

minimal_apt_get_install libssl-dev libyaml-dev libreadline6-dev zlib1g-dev \
  libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

run mkdir -p /srv/ruby-build
cd /srv/ruby-build
git clone https://github.com/rbenv/ruby-build.git .
git checkout v20170914

header "Installing ruby 2.4.0"
run bin/ruby-build 2.4.0 /usr/local/


