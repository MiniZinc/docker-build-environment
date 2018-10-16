FROM alpine:latest
RUN apk add --no-cache \
    curl \
    git \
    tzdata \
    unzip

RUN cp /usr/share/zoneinfo/Australia/Melbourne /etc/localtime
RUN echo "Australia/Melbourne" > /etc/timezone
RUN apk del tzdata