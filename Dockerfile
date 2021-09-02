ARG QT_VERSION=5.12.9

FROM centos:7 AS base 

RUN yum install -y epel-release centos-release-scl-rh && yum install -y \
# Qt Requirement:
	alsa-lib \
	cmake3 \
# Qt Requirement:
	cups-libs \
	devtoolset-10-gcc \
	devtoolset-10-gcc-c++ \
	git \
# Qt Requirement:
	fontconfig \
# Qt Requirement:
	libxkbcommon-x11 \
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
# Qt Requirement:
	postgresql-devel \
# Qt Requirement:
	unixODBC \
	unzip \
	zlib && yum clean all -y && rm -rf /var/cache/yum
RUN ln -s /usr/bin/cmake3 /usr/bin/cmake
ENV BASH_ENV=/opt/rh/devtoolset-10/enable \
	ENV=/opt/rh/devtoolset-10/enable \
	PROMPT_COMMAND=". /opt/rh/devtoolset-10/enable"

FROM base AS extract 
ARG QT_VERSION

### Linux deploy QT script
ADD https://github.com/probonopd/linuxdeployqt/releases/download/7/linuxdeployqt-7-x86_64.AppImage /opt/linuxdeployqt.AppImage
RUN chmod +x /opt/linuxdeployqt.AppImage
RUN /opt/linuxdeployqt.AppImage --appimage-extract
RUN rm -rf /opt/linuxdeployqt.AppImage
RUN mv /squashfs-root/usr /linuxdeployqt && rm -rf /squashfs-root/
RUN chmod -R 755 /linuxdeployqt

### Install Qt using aqt installer
RUN yum install -y \
	python3 \
	python3-devel \
	python3-pip && yum clean all -y && rm -rf /var/cache/yum
RUN source /opt/rh/devtoolset-10/enable && pip3 install aqtinstall
RUN aqt install -O /qt $QT_VERSION linux desktop -m qtwebengine

FROM base
ARG QT_VERSION

COPY --from=extract /linuxdeployqt /linuxdeployqt
COPY --from=extract /qt /qt

ENV QTDIR=/qt/$QT_VERSION/gcc_64
ENV PATH=$QTDIR/bin:/linuxdeployqt/bin:$PATH
ENV QT_PLUGIN_PATH=$QTDIR/plugins
