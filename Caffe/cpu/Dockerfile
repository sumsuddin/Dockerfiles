FROM ubuntu:16.04
LABEL maintainer sumsuddinshojib@gmail.com

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        wget \
        nano \
        git \
        curl \
        fish \
        sudo \
        htop \
        zip \
        unzip \
        mlocate \
        libopenblas-dev \
        libatlas-base-dev \
        libboost-all-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libhdf5-serial-dev \
        libleveldb-dev \
        liblmdb-dev \
        libopencv-dev \
        libprotobuf-dev \
        libsnappy-dev \
        protobuf-compiler \
        python-dev \
        python-numpy \
        python-pip \
        python-opencv \
        python-setuptools \
        python-scipy && \
    rm -rf /var/lib/apt/lists/*

ENV CAFFE_ROOT=/opt/caffe
WORKDIR $CAFFE_ROOT

# FIXME: use ARG instead of ENV once DockerHub supports this
# https://github.com/docker/hub-feedback/issues/460
ENV CLONE_TAG=1.0

ENV OPENBLAS_NUM_THREADS=$(nproc)

RUN git clone -b ${CLONE_TAG} --depth 1 https://github.com/BVLC/caffe.git .

RUN pip install --upgrade pip
RUN cd python && pip install -r requirements.txt && cd .. && \
    mkdir build && cd build && \
    cmake -DCPU_ONLY=1 -DBLAS=open .. && \
    make -j"$(nproc)"

ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH
RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

RUN useradd -ms /bin/bash -g root -G sudo -p dockeruser dockeruser
RUN echo dockeruser:dockeruser | chpasswd
USER dockeruser
WORKDIR /
