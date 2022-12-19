
#!/bin/bash
set -e
source /pd_build/buildconfig

run minimal_apt_get_install curl
run minimal_apt_get_install ca-certificates
## Many NPM packages contain native extensions and require a compiler
run minimal_apt_get_install build-essential
## Bundler has to be able to pull dependencies from git
run minimal_apt_get_install git
## We need this for dist directory prep
run minimal_apt_get_install rsync
