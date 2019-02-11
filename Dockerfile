FROM centos/devtoolset-7-toolchain-centos7

USER 0
RUN yum install -y --setopt=tsflags=nodocs epel-release \
 && yum install -y --setopt=tsflags=nodocs \
    cmake3 \
    git \
    fontconfig \
    mesa-libGL-devel \
    ninja-build \
    perl \
    zlib && yum clean all -y && rm -rf /var/cache/yum

RUN ln -s /usr/bin/cmake3 /usr/bin/cmake

## Local
# ADD qt-opensource-linux-x64-5.9.7.run /qt-installer.run
## Remote 
ADD http://qt.mirror.constant.com/official_releases/qt/5.9/5.9.7/qt-opensource-linux-x64-5.9.7.run /qt-installer.run

ADD qt-installer-noninteractive.qs /qt-installer-noninteractive.qs

RUN chmod +x /qt-installer.run && /qt-installer.run --script /qt-installer-noninteractive.qs -platform minimal
RUN rm /qt-installer.run /qt-installer-noninteractive.qs

# Linux deploy QT script
ADD https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage /opt/linuxdeployqt.AppImage
RUN chmod +x /opt/linuxdeployqt.AppImage
RUN cd / && /opt/linuxdeployqt.AppImage --appimage-extract
RUN rm -rf /opt/linuxdeployqt.AppImage
ENV PATH=/squashfs-root/usr/bin:$PATH

USER 1001
