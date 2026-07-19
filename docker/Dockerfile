FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  bash \
  bc \
  binutils \
  build-essential \
  bzip2 \
  ca-certificates \
  cpio \
  diffutils \
  file \
  findutils \
  gawk \
  git \
  gzip \
  libncurses-dev \
  patch \
  perl \
  python3 \
  rsync \
  sed \
  tar \
  unzip \
  wget \
  which \
  xz-utils \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
