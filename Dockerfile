FROM ubuntu AS build

ADD https://github.com/swiftwasm/swift/releases/download/\
swift-wasm-5.3-SNAPSHOT-2020-10-15-a/\
swift-wasm-5.3-SNAPSHOT-2020-10-15-a-ubuntu20.04-x86_64.tar.gz \
  /swift-wasm-5.3-SNAPSHOT.tar.gz
RUN mkdir -p /home/builder/.carton/sdk && cd /home/builder/.carton/sdk && \
  tar xzf /swift-wasm-5.3-SNAPSHOT.tar.gz

# Container image that runs your code
FROM ubuntu:20.04

LABEL maintainer="SwiftWasm Maintainers <hello@swiftwasm.org>"
LABEL Description="Docker Container for the SwiftWasm toolchain and SDK"

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && apt-get -q update && \
    apt-get -q install -y \
    curl \
    sudo \
    libatomic1 \
    libcurl4 \
    libxml2 \
    libedit2 \
    libsqlite3-0 \
    libsqlite3-dev \
    libc6-dev \
    binutils \
    libgcc-10-dev \
    libstdc++-10-dev \
    libz3-4 \
    zlib1g-dev \
    unzip \
    libpython2.7 \
    tzdata \
    git \
    pkg-config \
  && curl https://get.wasmer.io -sSfL | sh && \
    rm -r /var/lib/apt/lists/*

COPY --from=build /home/builder/.carton /root/.carton

RUN ln -s /root/.carton/sdk/swift-wasm-5.3-SNAPSHOT-2020-10-15-a/usr/bin/swift /usr/bin/swift

RUN git clone https://github.com/swiftwasm/carton.git && \
  cd carton && \
  ./install_ubuntu_deps.sh && \
  swift build -c release && \
  cd TestApp && ../.build/release/carton test && cd .. && \
  mv .build/release/carton /usr/bin && \
  cd .. && \
  rm -rf carton

COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

# Set the default command to run
CMD ["--help"]