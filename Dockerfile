FROM debian:stable-slim
RUN apt-get update -y && apt-get install -y \
    build-essential \
    zlib1g-dev \
    cmake \
    git \
    gcc \
    subversion \
    curl \
    unzip \
    flex \
    bison

