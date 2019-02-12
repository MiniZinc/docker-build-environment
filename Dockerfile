FROM centos/devtoolset-7-toolchain-centos7

USER 0
RUN yum install -y --setopt=tsflags=nodocs epel-release && yum install -y  --setopt=tsflags=nodocs \
    bison \
    ccache \
    cmake3 \
    flex \
    git \
    make \
    ninja-build \
    subversion \
    zlib-devel && yum clean all -y && rm -rf /var/cache/yum

RUN ln -s /usr/bin/cmake3 /usr/bin/cmake
