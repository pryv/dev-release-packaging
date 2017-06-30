#!/bin/bash
set -e
source /pd_build/buildconfig

header "NodeJs installation."

## Install Node.js
nodeversion=v8.1.3
version=x64
targz="node-${nodeversion}-linux-${version}.tar.gz"
binary_url="http://nodejs.org/dist/${nodeversion}/${targz}"
local_file="/var/spool/${targz}"
shasum="d41dc375ea7e33fadf0fb1bf89d9dfd222a2fb85633fba3d2cf48ac03522ba71"

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
