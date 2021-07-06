FROM eu.gcr.io/pryvio/base:1.3.40
MAINTAINER "Tech@Pryv" <tech@pryv.com>

ADD . /pd_build
RUN /pd_build/install.sh

# Ports: (par exemple)
#   27017        mongodb port
#
EXPOSE 27017

