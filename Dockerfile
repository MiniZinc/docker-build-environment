FROM centos/devtoolset-7-toolchain-centos7 AS BASE
WORKDIR /

USER 0
RUN yum install -y --setopt=tsflags=nodocs epel-release \
 && yum install -y --setopt=tsflags=nodocs \
  # Qt Requirement:
    alsa-lib \
    cmake3 \
  # Qt Requirement:
    cups-libs \
    git \
  # Qt Requirement:
    fontconfig \
  # Qt Requirement:
    libXcomposite-devel \
  # Qt Requirement:
    libXcursor-devel \
  # Qt Requirement:
    libXi-devel \
  # Qt Requirement:
    libXrandr-devel \
  # Qt Requirement:
    libXtst-devel \
  # Qt Requirement:
    mesa-libGL-devel \
    make \
    ninja-build \
    perl \
    zlib && yum clean all -y && rm -rf /var/cache/yum

RUN ln -s /usr/bin/cmake3 /usr/bin/cmake

FROM BASE as WORKING

### Install official Qt version - Replace when CentOS supports webengine
## Local installer
# ADD qt-opensource-linux-x64-5.9.7.run /qt-installer.run
## Download installer 
ADD http://qt.mirror.constant.com/official_releases/qt/5.9/5.9.7/qt-opensource-linux-x64-5.9.7.run /qt-installer.run

ADD qt-installer-noninteractive.qs /qt-installer-noninteractive.qs

RUN chmod +x /qt-installer.run && /qt-installer.run --script /qt-installer-noninteractive.qs -platform minimal
RUN cp -R /qt-install/5.9.7/gcc_64/ /qt
RUN rm -rf /qt-install /qt-installer.run /qt-installer-noninteractive.qs

### Linux deploy QT script
ADD https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage /opt/linuxdeployqt.AppImage
RUN chmod +x /opt/linuxdeployqt.AppImage
RUN /opt/linuxdeployqt.AppImage --appimage-extract
RUN rm -rf /opt/linuxdeployqt.AppImage
RUN mv /squashfs-root/usr /linuxdeployqt && rm -rf /squashfs-root/
RUN chmod -R 755 /linuxdeployqt
ENV PATH=/linuxdeployqt/bin:$PATH


FROM BASE as RESULT

COPY --from=WORKING /qt /qt
ENV PATH=/qt/bin:$PATH
COPY --from=WORKING /linuxdeployqt /linuxdeployqt
ENV PATH=/linuxdeployqt/bin:$PATH
