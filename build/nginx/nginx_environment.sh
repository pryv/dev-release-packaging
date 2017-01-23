#!/bin/bash
set -e
source /pd_build/buildconfig

header "(Pre-)Configuring nginx."

logs_dir="/app/log/nginx"
conf_dir="/app/conf"

# Create relevant directories.
run mkdir -p $logs_dir
run mkdir -p $conf_dir

# Copy configuration template
run cp /pd_build/conf/nginx.conf /app/conf/
run cp /pd_build/conf/site.conf /app/conf/

# And delegate configuration to our default templates below /app/conf
run cp /pd_build/conf/delegate.conf /etc/nginx/nginx.conf
