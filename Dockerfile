FROM swiftwasm/swiftwasm-builder AS build

RUN mkdir /home/builder/unpack && cd /home/builder/unpack && \
  tar xzf /home/builder/source/swift-wasm-DEVELOPMENT-SNAPSHOT-linux.tar.gz --strip-components=1

# Container image that runs your code
FROM ubuntu:18.04

LABEL maintainer="SwiftWasm Maintainers <hello@swiftwasm.org>"
LABEL Description="Docker Container for the SwiftWasm toolchain and SDK"

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && apt-get -q update && \
    apt-get -q install -y \
    libatomic1 \
    libcurl4 \
    libxml2 \
    libedit2 \
    libsqlite3-0 \
    libc6-dev \
    binutils \
    libgcc-5-dev \
    libstdc++-5-dev \
    zlib1g-dev \
    libpython2.7 \
    tzdata \
    git \
    pkg-config \
    && rm -r /var/lib/apt/lists/*

COPY --from=build /home/builder/unpack/ /
RUN set -e; \
    chmod -R o+r /usr/lib/swift

COPY entrypoint.sh /home/builder/entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/home/builder/entrypoint.sh"]

# Set the default command to run
CMD ["--help"]