FROM ubuntu:16.04

RUN apt-get update -y && apt-get install -y \
    curl \
    snapcraft \
    tzdata \
    unzip

ENV TZ=Australia/Melbourne
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
