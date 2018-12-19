FROM ubuntu:bionic
RUN apt-get update -y && apt-get install -y \
    build-essential \
    cmake \
    curl \
    gcc \
    git \
    libglu1-mesa-dev \
    mesa-common-dev \
    ninja-build \
    qt5-default \
    qtwebengine5-dev \
    libqt5svg5-dev \
    unzip

# Linux deploy QT script
ADD https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage /opt/linuxdeployqt.AppImage
RUN chmod +x /opt/linuxdeployqt.AppImage
RUN /opt/linuxdeployqt.AppImage --appimage-extract
RUN rm -rf /opt/linuxdeployqt.AppImage
ENV PATH=/squashfs-root/usr/bin:$PATH
