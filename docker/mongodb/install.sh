#!/bin/bash
set -e
source /pd_build/helpers

main() {
  mongodb
  cleanup
}

mongodb() {
  # Versions and urls/paths
  mongo_tar_gz="mongodb-linux-x86_64-ubuntu2204-v6.0-latest.tgz"
  mongo_url="https://fastdl.mongodb.org/linux/"${mongo_tar_gz}

  mongotools_tar_gz="mongodb-database-tools-ubuntu2204-x86_64-100.7.0.tgz"
  mongotools_url="https://fastdl.mongodb.org/tools/db/"${mongotools_tar_gz}


  mongoshell_tar_gz="mongosh-1.8.2-linux-x64.tgz"
  mongoshell_url="https://downloads.mongodb.com/compass/"${mongoshell_tar_gz}

  target_dir="/app/bin"
  #data_dir="/app/data"
  #log_dir="/app/log"
  #config_dir="/app/conf"

  header "Installing MongoDB"

  mkdir -p $target_dir

  # Add users to the system
  run groupadd -r mongodb
  run useradd -r -g mongodb mongodb

  # Download and unpack mongodb
  pushd $target_dir
  run curl -O $mongo_url
  run curl -O $mongotools_url
  run curl -O $mongoshell_url

  mkdir mongodb
  pushd $target_dir/mongodb
  run tar --strip-components=1 -xzf ../$mongo_tar_gz
  run tar --strip-components=1 -xzf ../$mongotools_tar_gz
  run tar --strip-components=1 -xzf ../$mongoshell_tar_gz
  run chown -R mongodb:mongodb .
  popd

  run rm $mongoshell_tar_gz
  run rm $mongotools_tar_gz
  run rm $mongo_tar_gz
  popd

  # Create mongodb data dirs
  run mkdir -p $data_dir && chown -R mongodb:mongodb $data_dir

  # And the log file
 # run mkdir -p $log_dir && \
  #  touch $log_dir/mongodb.log && chown mongodb:mongodb $log_dir/mongodb.log

  # Copy our config file over.
  #run mkdir -p $config_dir && \
   # cp /pd_build/config/mongodb.yml $config_dir/

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
