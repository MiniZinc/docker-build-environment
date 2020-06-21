FROM debian:oldstable-slim AS EXTRACT

### Linux deploy QT script
ADD https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage /opt/linuxdeployqt.AppImage
RUN chmod +x /opt/linuxdeployqt.AppImage
RUN /opt/linuxdeployqt.AppImage --appimage-extract
RUN rm -rf /opt/linuxdeployqt.AppImage
RUN mv /squashfs-root/usr /linuxdeployqt && rm -rf /squashfs-root/
RUN chmod -R 755 /linuxdeployqt

FROM debian:oldstable-slim

RUN apt-get update -y && apt-get install -y \
    bison \
    build-essential \
    ccache \
    cmake \
    flex \
    git \
    ninja-build \
    perl \
    qt5-default \
    qtwebengine5-dev \
    zlib1g-dev

COPY --from=EXTRACT /linuxdeployqt /linuxdeployqt
ENV PATH=/linuxdeployqt/bin:$PATH

