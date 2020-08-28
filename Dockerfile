FROM ubuntu:20.04

LABEL maintainer="Humberto Dias"
LABEL version="1.0"

# Set up Bionic
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y && apt install -y \
    tzdata \
    libssl-dev \
    openssl \
    zlib1g-dev \
    build-essential \
    checkinstall \
    libffi-dev \
    libsqlite3-dev \
    vim \
    curl \
    make \
    python3-pip \
    python3

# For x11
RUN apt install -qqy x11-apps xterm

# Pygame
RUN python3 -m pip install pip \
 && python3 -m pip install --upgrade pip \
 && python3 -m pip -V \
 && pip3 install pygame==2.0.0.dev10

ARG USER=docker
ARG UID=1000
ARG GID=1000
# default password for user
ARG PW=docker

# Option1: Using unencrypted password/ specifying password
RUN useradd -m ${USER} --shell /bin/bash --uid=${UID} && echo "${USER}:${PW}" | chpasswd \
&& adduser docker sudo

# Setup default user, when enter docker container
USER ${UID}:${GID}
WORKDIR /home/${USER}