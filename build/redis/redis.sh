#!/bin/bash
set -e
source /pd_build/buildconfig

header "Installing Redis"

# Inspired by https://github.com/docker-library/redis.

data_dir="/app/data"
log_dir="/app/log"
conf_dir="/app/conf"

# What redis is installed?
redis_version="5.0.2"
redis_file="redis-$redis_version.tar.gz"
redis_release_sha256="937dde6164001c083e87316aa20dad2f8542af089dfcb1cbb64f9c8300cd00ed"
redis_url="http://download.redis.io/releases/$redis_file"

# Redis user and group
run groupadd -r redis 
run useradd -r -g redis redis

# Download and unpack, make, make install - then clean up
pushd /var/spool/
run curl -O $redis_url
echo "$redis_release_sha256 $redis_file" | sha256sum -c -

mkdir redis-src
pushd redis-src
run tar --strip-components=1 -xzf ../$redis_file
run make && make install
popd 

run rm $redis_file
run rm -r redis-src
popd

# Create redis data directory
run mkdir -p $data_dir
run chown redis:redis $data_dir

# Copy redis configuration
run mkdir -p $conf_dir
run cp /pd_build/config/redis.conf $conf_dir/
run mkdir -p $log_dir && \
  touch $log_dir/redis.log && \
  chown redis:redis $log_dir/redis.log

# Copy redis start script
mkdir /etc/service/redis
run cp /pd_build/runit/redis /etc/service/redis/run
