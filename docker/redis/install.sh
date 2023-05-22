#!/bin/bash
set -e
source /pd_build/helpers

main() {
  redis
  cleanup
}

redis() {
  header "Installing Redis"

  # Inspired by https://github.com/docker-library/redis

  # What redis is installed?
  redis_version="5.0.14"
  redis_file="redis-$redis_version.tar.gz"
  redis_release_sha256="3ea5024766d983249e80d4aa9457c897a9f079957d0fb1f35682df233f997f32"
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

  # config, data, log and backup directories are mapped as Docker volumes
  # so don't need to be created here (see the runit file for their respective paths)

  # Have redis start on container start
  run mkdir /etc/service/redis && \
    cp /pd_build/runit/redis /etc/service/redis/run
}

cleanup() {
  header "Finalizing"

  run apt-get remove -y autoconf automake
  cleanup_common
}

main "$@"
