FROM ubuntu:xenial
RUN apt-get update -y && apt-get install -y \
    build-essential \
    cmake \
    curl \
    gcc \
    git \
    software-properties-common \
    unzip

# Qt 5.9.6
RUN add-apt-repository -y ppa:beineri/opt-qt596-xenial && apt-get update -y && apt-get install -y \
    qt59base \
    qt59webengine \
    qt59svg \
    mesa-common-dev \
    libglu1-mesa-dev
ENV QTDIR=/opt/qt59
ENV PATH=$QTDIR/bin:$PATH
ENV LD_LIBRARY_PATH=$QT_BASE_DIR/lib/x86_64-linux-gnu:$QT_BASE_DIR/lib:$LD_LIBRARY_PATH

RUN apt-get autoremove -y software-properties-common

# Linux deploy QT script
ADD https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage /opt/linuxdeployqt.AppImage
RUN chmod +x /opt/linuxdeployqt.AppImage
RUN /opt/linuxdeployqt.AppImage --appimage-extract
RUN rm -rf /opt/linuxdeployqt.AppImage
ENV PATH=/squashfs-root/usr/bin:$PATH
