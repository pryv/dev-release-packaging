#!/bin/bash
set -e
source /pd_build/buildconfig

# Install configuration and other parts of our own nginx environment. 
run /pd_build/nginx_environment.sh

# Clean up after ourselves.
run /pd_build/finalize.sh
