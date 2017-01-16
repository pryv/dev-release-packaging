
# See http://phusion.github.io/baseimage-docker/
FROM phusion/baseimage:0.9.19
MAINTAINER "Tech@Pryv" <tech@pryv.com>

# NOTE Some details of the package construction below are copied verbatim from 
#   the phusion passenger-docker recipe at 
#     https://github.com/phusion/passenger-docker. 
#
#   They have implemented a number of useful patterns, would be a shame not 
#   to use those. (ksc, 13Jan17)

ADD . /pd_build

RUN /pd_build/install.sh

