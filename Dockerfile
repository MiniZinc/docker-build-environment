ARG QT_VERSION=5.12.9
ARG BASE="ubuntu:18.04"

FROM $BASE AS EXTRACT
ARG QT_VERSION

### Linux deploy QT script
ADD https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage /opt/linuxdeployqt.AppImage
RUN chmod +x /opt/linuxdeployqt.AppImage
RUN /opt/linuxdeployqt.AppImage --appimage-extract
RUN rm -rf /opt/linuxdeployqt.AppImage
RUN mv /squashfs-root/usr /linuxdeployqt && rm -rf /squashfs-root/
RUN chmod -R 755 /linuxdeployqt
RUN apt-get update -y && apt-get install -y python3 python3-pip
RUN pip3 install aqtinstall
RUN aqt install -O /qt $QT_VERSION linux desktop -m qtwebengine

FROM $BASE 
ARG QT_VERSION

RUN apt-get update -y && apt-get install -y \
    bison \
    build-essential \
    ccache \
    cmake \
    curl \
    flex \
    git \
    libasound2 \
    libgl1-mesa-dev \
    libgtk-3-dev \
    libnss3 \
    libodbc1 \
    libpq5 \
    libxkbcommon-x11-0 \
    ninja-build \
    perl \
    unzip \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

COPY --from=EXTRACT /linuxdeployqt /linuxdeployqt
COPY --from=EXTRACT /qt /qt

ENV QTDIR=/qt/$QT_VERSION/gcc_64
ENV PATH=$QTDIR/bin:/linuxdeployqt/bin:$PATH
ENV QT_PLUGIN_PATH=$QTDIR/plugins
