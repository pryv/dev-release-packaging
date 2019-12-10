#!/bin/bash
set -e
source /pd_build/buildconfig

header "NodeJs installation."

## Install Node.js
nodeversion=v12.13.1
version=x64
targz="node-${nodeversion}-linux-${version}.tar.gz"
binary_url="http://nodejs.org/dist/${nodeversion}/${targz}"
local_file="/var/spool/${targz}"
shasum="074a6129da34b768b791f39e8b74c6e4ab3349d1296f1a303ef3547a7f9cf9be"

cd /var/spool

# Fetch the actual binary release
run curl -O $binary_url

# Check the binary tar.gz against its sha256 sum
run echo -n "$shasum $targz" | sha256sum -c -

# Install the binaries to where they want to go
pushd /usr/
run tar --strip-components 1 -xzf $local_file

# Cleanup
popd
run rm $local_file
