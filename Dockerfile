FROM ubuntu:bionic
RUN apt-get update -y && apt-get install -y \
    build-essential \
    cmake \
    git \
    gcc \
    curl \
    unzip \
    qt5-default

# Linux deploy QT script
ADD https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage /opt/linuxdeployqt.AppImage
RUN chmod +x /opt/linuxdeployqt.AppImage
RUN /opt/linuxdeployqt.AppImage --appimage-extract
RUN rm -rf /opt/linuxdeployqt.AppImage
ENV PATH=/squashfs-root/usr/bin:$PATH

