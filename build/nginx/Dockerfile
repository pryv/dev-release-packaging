FROM nginx:1.15.6
MAINTAINER "Tech@Pryv" <tech@pryv.com>

ADD . /pd_build
RUN /pd_build/install.sh

# Expose these ports to the world:
EXPOSE 80 443