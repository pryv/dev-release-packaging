#!/bin/bash
set -e
source /pd_build/buildconfig

run /pd_build/enable_repos.sh
run /pd_build/prepare.sh
run /pd_build/utilities.sh

# Install various things that are used by most of the Pryv images:
run /pd_build/nodejs.sh

# (Pre-)Configure the image
run /pd_build/configure.sh

# Clean up after ourselves.
run /pd_build/finalize.sh
