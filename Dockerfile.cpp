FROM centos:7

RUN yum install -y epel-release centos-release-scl-rh && yum install -y \
	bison \
	ccache \
	cmake3 \
	devtoolset-10-gcc \
	devtoolset-10-gcc-c++ \
	flex \
	git \
	make \
	ninja-build \
	subversion \
	unzip \
	zlib-devel && yum clean all -y && rm -rf /var/cache/yum
RUN ln -s /usr/bin/cmake3 /usr/bin/cmake
ENV BASH_ENV=/opt/rh/devtoolset-10/enable \
	ENV=/opt/rh/devtoolset-10/enable \
	PROMPT_COMMAND=". /opt/rh/devtoolset-10/enable"
