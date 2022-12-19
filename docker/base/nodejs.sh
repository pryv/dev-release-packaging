#!/bin/bash
set -e
source /pd_build/buildconfig

header "Installing Node.js"

## Install Node.js
nodeversion=v16.16.0
version=x64
targz="node-${nodeversion}-linux-${version}.tar.xz"
binary_url="https://nodejs.org/dist/${nodeversion}/${targz}"
local_file="/var/spool/${targz}"
shasum="edcb6e9bb049ae365611aa209fc03c4bfc7e0295dbcc5b2f1e710ac70384a8ec"

cd /var/spool

# Fetch the actual binary release
run curl -O $binary_url

# Check the binary tar.gz against its sha256 sum
run echo -n "$shasum $targz" | sha256sum -c -

# Install the binaries to where they want to go
pushd /usr/
run tar --strip-components 1 -xf $local_file

# Cleanup
popd
run rm $local_file
