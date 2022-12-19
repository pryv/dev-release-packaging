#!/bin/bash
set -e
source /pd_build/buildconfig

run /pd_build/redis.sh

# Remove cron and sshd entirely, unless we use them
run rm -r /etc/service/sshd && rm /etc/my_init.d/00_regen_ssh_host_keys.sh
run rm -r /etc/service/cron

# Clean up after ourselves.
run /pd_build/finalize.sh
