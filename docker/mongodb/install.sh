#!/bin/bash
set -e
source /pd_build/helpers

main() {
  mongodb
  cleanup
}

mongodb() {
  # Versions and URLs/paths
  mongo_tar_gz="mongodb-linux-x86_64-ubuntu2204-v6.0-latest.tgz"
  mongo_url="https://fastdl.mongodb.org/linux/"${mongo_tar_gz}

  mongotools_tar_gz="mongodb-database-tools-ubuntu2204-x86_64-100.7.0.tgz"
  mongotools_url="https://fastdl.mongodb.org/tools/db/"${mongotools_tar_gz}

  mongoshell_tar_gz="mongosh-1.8.2-linux-x64.tgz"
  mongoshell_url="https://downloads.mongodb.com/compass/"${mongoshell_tar_gz}

  target_dir="/app/bin"

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

  # config, data, log and backup directories are mapped as Docker volumes
  # so don't need to be created here (see the runit file for their respective paths)

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
