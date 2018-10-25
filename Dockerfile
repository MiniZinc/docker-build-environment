FROM alpine:latest
RUN apk add --no-cache \
    g++ \
    cmake \
    curl \
    git \
    make \
    subversion \
    unzip \
    zlib
