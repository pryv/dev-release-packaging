#!/bin/bash
set -e
source /pd_build/buildconfig

header "Preparing APT repositories"

# For example:
#
# ## Phusion Passenger
# run apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
# if [[ "$PASSENGER_ENTERPRISE" ]]; then
# 	echo "+ Enabling Passenger Enterprise APT repo"
# 	echo deb https://download:$PASSENGER_ENTERPRISE_DOWNLOAD_TOKEN@www.phusionpassenger.com/enterprise_apt xenial main > /etc/apt/sources.list.d/passenger.list
# else
# 	echo "+ Enabling Passenger APT repo"
# 	echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list
# fi

# Setup Prebuilt-MPR
curl -q 'https://proget.makedeb.org/debian-feeds/prebuilt-mpr.pub' | gpg --dearmor | tee /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg 1> /dev/null
echo "deb [signed-by=/usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg] https://proget.makedeb.org prebuilt-mpr $(lsb_release -cs)" | tee /etc/apt/sources.list.d/prebuilt-mpr.list

run apt-get update
