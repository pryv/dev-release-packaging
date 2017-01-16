#!/bin/bash
set -e
source /pd_build/buildconfig

# Disable CRON for now. 
touch /etc/service/cron/down

# Create base directory for Pryv installs
mkdir -p /var/pryv
