FROM rockylinux/rockylinux:9

# install epel-release for ccache
RUN dnf install -y epel-release && \
	dnf install --enablerepo=crb -y \
	bison \
	ccache \
	cmake \
	gcc-toolset-14 \
	gcc-toolset-14-gcc-c++ \
	findutils \
	flex \
	git \
	make \
	ninja-build \
	subversion \
	unzip \
	zlib-devel && dnf clean all -y && rm -rf /var/cache/dnf
ENV BASH_ENV=/opt/rh/gcc-toolset-14/enable \
	ENV=/opt/rh/gcc-toolset-14/enable \
	PROMPT_COMMAND=". /opt/rh/gcc-toolset-14/enable"
