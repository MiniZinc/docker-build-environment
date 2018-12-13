FROM alpine:latest
RUN apk add --no-cache \
    bash \
    bison \
    ccache \
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
