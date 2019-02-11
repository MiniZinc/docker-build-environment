FROM centos/devtoolset-7-toolchain-centos7

USER 0
RUN yum install -y epel-release && yum install -y \
    bison \
    ccache \
    cmake3 \
    flex \
    git \
    make \
    ninja-build \
    subversion && yum clean all -y && rm -rf /var/cache/yum

RUN ln -s /usr/bin/cmake3 /usr/bin/cmake
USER 1001
