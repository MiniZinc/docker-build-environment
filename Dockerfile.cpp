FROM rockylinux/rockylinux:8

# install epel-release for ccache
RUN dnf install -y epel-release && \
	dnf install --enablerepo=powertools -y \
	bison \
	ccache \
	cmake \
	gcc-toolset-11 \
	gcc-toolset-11-gcc-c++ \
	flex \
	git \
	make \
	ninja-build \
	subversion \
	unzip \
	zlib-devel && dnf clean all -y && rm -rf /var/cache/dnf
ENV BASH_ENV=/opt/rh/gcc-toolset-11/enable \
	ENV=/opt/rh/gcc-toolset-11/enable \
	PROMPT_COMMAND=". /opt/rh/gcc-toolset-11/enable"
