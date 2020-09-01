FROM pryv/base:1.3.40
MAINTAINER "Tech@Pryv" <tech@pryv.com>

RUN apt-get update -y && apt-get install libcurl3
ADD . /pd_build
# create script that could be run easily after the mongo starts in docker-compose file
#ADD setFeatureCompatibilityVersion.sh /app/setFeatureCompatibilityVersion.sh
#ADD convertToReplicaSet.sh /app/convertToReplicaSet.sh

RUN /pd_build/install.sh

# Remove cron and sshd entirely, unless we use them
RUN rm -r /etc/service/sshd && rm /etc/my_init.d/00_regen_ssh_host_keys.sh
RUN rm -r /etc/service/cron

# Clean up after ourselves.
RUN apt-get remove -y autoconf automake
RUN apt-get autoremove
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN rm -rf /pd_build

# Ports: (par exemple)
#   27017        mongodb port
#
#
EXPOSE 27017

