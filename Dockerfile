FROM alpine:latest
RUN apk add --no-cache \
    bash \
    bison \
    cmake \
    curl \
    flex \
    git \
    g++ \
    make \
    perl \
    subversion \
    unzip \
    zlib-dev
