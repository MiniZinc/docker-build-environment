FROM ubuntu:xenial AS EXTRACT

### Linux deploy QT script
ADD https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage /opt/linuxdeployqt.AppImage
RUN chmod +x /opt/linuxdeployqt.AppImage
RUN /opt/linuxdeployqt.AppImage --appimage-extract
RUN rm -rf /opt/linuxdeployqt.AppImage
RUN mv /squashfs-root/usr /linuxdeployqt && rm -rf /squashfs-root/
RUN chmod -R 755 /linuxdeployqt

FROM ubuntu:xenial

RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:beineri/opt-qt-5.12.9-xenial
# RUN echo "deb http://ppa.launchpad.net/beineri/opt-qt-5.12.9-xenial/ubuntu xenial main\ndeb-src http://ppa.launchpad.net/beineri/opt-qt-5.12.9-xenial/ubuntu xenial main" >> /etc/apt/sources.list.d/qt.list

RUN apt-get update -y && apt-get install -y \
    bison \
    build-essential \
    ccache \
    cmake \
    curl \
    flex \
    git \
    libgl1-mesa-dev \
    ninja-build \
    perl \
    unzip \
    zlib1g-dev \
    qt512-meta-minimal \
    qt512webengine

COPY --from=EXTRACT /linuxdeployqt /linuxdeployqt

ENV QT_BASE_DIR=/opt/qt512
ENV QTDIR=$QT_BASE_DIR
ENV PATH=/linuxdeployqt/bin:$QT_BASE_DIR/bin:$PATH
ENV LD_LIBRARY_PATH=$QT_BASE_DIR/lib/x86_64-linux-gnu:$QT_BASE_DIR/lib:$LD_LIBRARY_PATH
ENV PKG_CONFIG_PATH=$QT_BASE_DIR/lib/pkgconfig:$PKG_CONFIG_PATH
