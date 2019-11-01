FROM ubuntu:18.04

RUN apt-get update -y && apt-get install -y \
    binutils \
    curl \
    snapcraft \
    unzip
