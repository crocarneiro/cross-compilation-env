FROM ubuntu:18.04

VOLUME [ "/source" ]

RUN apt-get update
RUN apt-get --yes install \
    apt-utils \
    build-essential \
    curl \
    libcurl4-openssl-dev \
    mingw-w64 \
    gdb\
    valgrind\
    git

RUN apt-get update
RUN apt-get --yes install \
    autoconf \
    automake \
    autopoint \
    bash \
    bison \
    bzip2 \
    flex \
    g++ \
    g++-multilib \
    gettext \
    git \
    gperf \
    intltool \
    libc6-dev-i386 \
    libgdk-pixbuf2.0-dev \
    libltdl-dev \
    libssl-dev \
    libtool-bin \
    libxml-parser-perl \
    lzip \
    make \
    openssl \
    p7zip-full \
    patch \
    perl \
    pkg-config \
    python \
    ruby \
    sed \
    unzip \
    wget \
    xz-utils

RUN git clone https://github.com/crocarneiro/mxe.git
RUN mv mxe/ /opt/mxe
RUN cd /opt/mxe && make cc
RUN cd /opt/mxe && make curl
RUN cd /opt/mxe && make libstring-utils

ENV PATH=/opt/mxe/usr/bin:$PATH

RUN git clone https://github.com/crocarneiro/string-utils.git
RUN cd string-utils && autoreconf --install
RUN cd string-utils && ./configure
RUN cd string-utils && make
RUN cd string-utils && make install

RUN apt-get update
RUN apt-get --yes install openssh-server

RUN git clone https://github.com/DaveGamble/cJSON.git
RUN cd cJSON && make
RUN cd cJSON && make install

ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH