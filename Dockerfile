FROM ubuntu:18.04

RUN apt-get update -y && apt-get install -y \
    bison \
    build-essential \
    ccache \
    cmake \
    curl \
    flex \
    git \
    ninja-build \
    subversion \
    unzip \
    zlib1g-dev \
		&& rm -rf /var/lib/apt/lists/*
