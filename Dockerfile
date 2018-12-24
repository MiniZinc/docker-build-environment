FROM ubuntu:latest
RUN apt-get update -y && apt-get install -y \
    bison \
    build-essential \
    ccache \
    cmake \
    curl \
    flex \
    gcc \
    git \
    ninja-build \
    subversion \
    unzip \
    zlib1g-dev
