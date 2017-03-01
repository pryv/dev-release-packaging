#!/bin/bash
set -e
source /pd_build/buildconfig

header "Performing miscellaneous preparation"

## Create a user for the web app.
run addgroup --gid 9999 app
run adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" app
run usermod -L app
run mkdir -p /home/app/.ssh
run chmod 700 /home/app/.ssh
run chown app:app /home/app/.ssh

# Remove services from our own base image that we will not use now: 
rm -r /etc/service/syslog-ng
rm -r /etc/service/syslog-forwarder
