#!/bin/bash
set -e
source /pd_build/buildconfig

# Disable CRON for now. 
touch /etc/service/cron/down

# Remove services from our own base image that we will not use now: 
rm -r /etc/service/syslog-ng
rm -r /etc/service/syslog-forwarder

# Create base directory for Pryv installs
mkdir -p /var/pryv

# Install yarn
npm install -g yarn
