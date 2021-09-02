FROM alpine:edge
RUN apk add --no-cache \
	bison \
	ccache \
	clang \
	clang-extra-tools \
	cmake \
	curl \
	flex \
	git \
	g++ \
	ninja \
	python2 \
	unzip \
	zlib-dev

ADD https://raw.githubusercontent.com/Sarcasm/run-clang-format/master/run-clang-format.py /usr/local/bin/run-clang-format
RUN chmod +x /usr/local/bin/run-clang-format
