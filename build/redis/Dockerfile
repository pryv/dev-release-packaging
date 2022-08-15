FROM eu.gcr.io/pryvio/base:1.8.0-rc2
MAINTAINER "Tech@Pryv" <tech@pryv.com>

ADD . /pd_build
RUN /pd_build/install.sh

# Ports: (par exemple)
#   6379        default redis port
#
EXPOSE 6379
