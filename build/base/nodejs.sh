#!/bin/bash
set -e
source /pd_build/buildconfig

header "NodeJs installation."

## Install Node.js
nodeversion=v16.4.1
version=x64
targz="node-${nodeversion}-linux-${version}.tar.xz"
binary_url="https://nodejs.org/dist/${nodeversion}/${targz}"
local_file="/var/spool/${targz}"
shasum="3c73b58051a4435d605f9842e582a252e100d5ff62e0a30e3961cab71e8477b1"

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
