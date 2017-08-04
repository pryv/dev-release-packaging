#!/bin/bash
set -e
source /pd_build/buildconfig

header "NodeJs installation."

## Install Node.js
nodeversion=v8.2.1
version=x64
targz="node-${nodeversion}-linux-${version}.tar.gz"
binary_url="http://nodejs.org/dist/${nodeversion}/${targz}"
local_file="/var/spool/${targz}"
shasum="abcddeb95cc4465953b1edb0922d20e9b0b3de83688fc8150b863117032a978a"

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
