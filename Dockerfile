FROM ghcr.io/swiftwasm/carton:latest

LABEL maintainer="SwiftWasm Maintainers <hello@swiftwasm.org>"
LABEL Description="Docker Container for the SwiftWasm toolchain and SDK"

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && apt-get -q update && \
  apt-get -q install -y \
  wabt && \
  rm -r /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
