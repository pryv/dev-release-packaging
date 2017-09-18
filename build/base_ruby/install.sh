#!/bin/bash
set -e
source /pd_build/buildconfig

run /pd_build/ruby.sh

# Clean up after ourselves.
run /pd_build/finalize.sh
