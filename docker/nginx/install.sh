#!/bin/bash
set -e
source /pd_build/helpers

main() {
  configure
  cleanup
}

configure() {
  header "(Pre-)Configuring nginx"

  # config and log directories are mapped as Docker volumes
  # so don't need to be created here (see the runit file for their respective paths)

  # Delegate configuration to our default templates below /app/conf
  run cp /pd_build/conf/delegate.conf /etc/nginx/nginx.conf
}

cleanup() {
  header "Finalizing"

  cleanup_common
}

main "$@"
