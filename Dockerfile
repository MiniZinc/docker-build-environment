FROM alpine:latest
RUN apk add --no-cache \
    bash \
    cmake \
    curl \
    git \
    g++ \
    make \
    perl \
    subversion \
    unzip \
    zlib
