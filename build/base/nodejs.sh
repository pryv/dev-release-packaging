#!/bin/bash
set -e
source /pd_build/buildconfig

header "NodeJs installation."

## Install Node.js
nodeversion=v0.12.7
version=x64
targz="node-${nodeversion}-linux-${version}.tar.gz"
binary_url="http://nodejs.org/dist/${nodeversion}/${targz}"
shasums_url="http://nodejs.org/dist/${nodeversion}/SHASUMS256.txt.asc"
local_file="/var/spool/${targz}"

cd /var/spool

# Fetch the actual binary release
run curl -O $binary_url

# Fetch the verification sums
run curl -O $shasums_url
# Check the binary tar.gz against its sha256 sum
run grep $targz SHASUMS256.txt.asc  | sha256sum -c -

# NOTE we could try to do more here and also verify the signature of the 
#   SHASUMS256.txt.asc file. But then we'd need to establish trust into 
#   GPG keys that are used to sign this - ultimately too big a task for a simple
#   Dockerfile. The above detects modification in transfer, not hacking of the
#   nodejs.org domain. 

# Install the binaries to where they want to go
pushd /usr/
run tar --strip-components 1 -xzf $local_file

# Cleanup
popd
run rm $local_file
run rm SHASUMS256.txt.asc


