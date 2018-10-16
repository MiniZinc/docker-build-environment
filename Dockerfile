FROM alpine:latest
RUN apk add --no-cache \
    clang \
    cmake \
    curl \
    git \
    subversion \
    unzip \
    zlib