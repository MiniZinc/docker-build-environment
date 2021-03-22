FROM alpine:edge
RUN apk add --no-cache \
    clang \
    clang-extra-tools \
    cmake \
    git \
    g++ \
    ninja \
    python2

ADD https://raw.githubusercontent.com/Sarcasm/run-clang-format/master/run-clang-format.py /usr/local/bin/run-clang-format
RUN chmod +x /usr/local/bin/run-clang-format
