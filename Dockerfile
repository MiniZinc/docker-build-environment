FROM centos/devtoolset-7-toolchain-centos7

USER 0
RUN yum install -y --setopt=tsflags=nodocs epel-release && yum install -y --setopt=tsflags=nodocs \
    cmake3 \
    git \
    ninja-build \
    qt5-qtbase-devel \
    subversion && yum clean all -y && rm -rf /var/cache/yum

RUN ln -s /usr/bin/cmake3 /usr/bin/cmake
RUN ln -s /usr/bin/qmake-qt5 /usr/bin/qmake

# Linux deploy QT script
ADD https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage /opt/linuxdeployqt.AppImage
RUN chmod +x /opt/linuxdeployqt.AppImage
RUN /opt/linuxdeployqt.AppImage --appimage-extract
RUN rm -rf /opt/linuxdeployqt.AppImage
ENV PATH=/squashfs-root/usr/bin:$PATH

USER 1001
