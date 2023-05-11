#!/bin/bash
set -e
source /pd_build/helpers

main() {
  mongodb
  cleanup
}

mongodb() {
  # Versions and urls/paths
  mongo_tar_gz="mongodb-linux-x86_64-3.6.23.tgz"
  mongo_url="https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.6.23.tgz"

  target_dir="/app/bin"
  data_dir="/app/data"
  log_dir="/app/log"
  config_dir="/app/conf"

  header "Installing MongoDB"

  mkdir -p $target_dir

  # Add users to the system
  run groupadd -r mongodb
  run useradd -r -g mongodb mongodb

  # Download and unpack mongodb
  pushd $target_dir
  run curl -O $mongo_url

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
}


cleanup() {
  header "Finalizing"

  run apt-get remove -y autoconf automake
  cleanup_common
}

main "$@"
