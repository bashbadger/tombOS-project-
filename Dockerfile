# Dockerfile for TombOS build environment
FROM debian:bullseye-slim

# Install required packages for building the kernel, GrapheneOS GSI, and flashing
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        nasm \
        gcc \
        g++ \
        make \
        qemu-system-i386 \
        git \
        util-linux \
        parted \
        ca-certificates \
        dosfstools \
        coreutils \
        python3 \
        curl \
        rsync \
        libncurses5 \
        openjdk-17-jdk \
        unzip \
        zip \
    && rm -rf /var/lib/apt/lists/*

# Install Google 'repo' tool for Android source management
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo && chmod a+x /usr/local/bin/repo

WORKDIR /tombos
COPY . /tombos

# Ensure scripts are executable (they will be created later)
# RUN chmod +x scripts/package.sh scripts/flash_sdxc.sh build_tombos.sh

CMD ["/bin/bash", "./build_tombos.sh"]
