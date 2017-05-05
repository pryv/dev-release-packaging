#!/bin/bash
set -e
source /pd_build/buildconfig

# Versions and urls/paths
mongo_version="2.6.12"
mongo_tar_gz="mongodb-linux-x86_64-$mongo_version.tgz"
mongo_url="http://downloads.mongodb.org/linux/$mongo_tar_gz"
mongo_sha256="6d6415ac068825d1aed23f9482080ce3551bfac828d9570be1d72990d5f441b0"

target_dir="/app/bin"
data_dir="/app/data"
log_dir="/app/log"
config_dir="/app/conf"

header "Install mongodb"

mkdir -p $target_dir

# Add users to the system
run groupadd -r mongodb 
run useradd -r -g mongodb mongodb

# Download, check and unpack mongodb
pushd $target_dir
run curl -O $mongo_url
echo -n "$mongo_sha256 $mongo_tar_gz" | sha256sum -c -

mkdir mongodb
pushd $target_dir/mongodb
run tar --strip-components=1 -xzf ../$mongo_tar_gz
run chown -R mongodb:mongodb .
popd

run rm $mongo_tar_gz
popd

# Create mongodb data dirs
run mkdir -p $data_dir && chown -R mongodb:mongodb $data_dir

# And the log file
run mkdir -p $log_dir && \
  touch $log_dir/mongodb.log && chown mongodb:mongodb $log_dir/mongodb.log

# Copy our config file over. 
run mkdir -p $config_dir && \
  cp /pd_build/config/mongodb.conf $config_dir/

# Have mongodb start on container start
run mkdir /etc/service/mongodb && \
  cp /pd_build/runit/mongodb /etc/service/mongodb/run
