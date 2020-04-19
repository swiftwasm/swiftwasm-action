FROM swiftwasm/swiftwasm-builder AS build

RUN mkdir /home/builder/unpack && cd /home/builder/unpack && \
  tar xzf /home/builder/source/swift-wasm-DEVELOPMENT-SNAPSHOT-linux.tar.gz

# Container image that runs your code
FROM ubuntu:18.04

# Set debconf to run non-interactively
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get install -y -q --no-install-recommends \
    ca-certificates \
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
    lsb-release \
    sudo && \
  apt-get clean all

RUN adduser --disabled-password --shell /bin/bash --gecos '' builder
RUN adduser builder sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER builder

RUN git clone https://github.com/kylef/swiftenv.git ~/.swiftenv

ENV PATH="/home/builder/.swiftenv/bin:${PATH}"

RUN mkdir -p /home/builder/.swiftenv/versions
COPY --from=build /home/builder/unpack/ /home/builder/.swiftenv/versions
RUN swiftenv global $(swiftenv versions | tail -1)

RUN echo 'eval "$(swiftenv init -)"' >> /home/builder/.bash_profile

COPY entrypoint.sh /home/builder/entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/home/builder/entrypoint.sh"]

# Set the default command to run
CMD ["--help"]