#!/bin/bash
set -e
source /pd_build/buildconfig

# Remove services from our own base image that we will not use
# (removal code here)

# Create base directory for Pryv installs
mkdir -p /var/pryv
