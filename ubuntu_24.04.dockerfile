FROM ubuntu:24.04

LABEL author="Borja Castellano" version="0.1.0"

ARG USERNAME=ubuntu

RUN apt-get update && \
    apt-get install -y \
    sudo \
    curl \
    git \
    build-essential \
    cmake \
    gdb \
    gfortran \
    openssh-server \
    pkg-config

RUN deluser --remove-home ubuntu

RUN useradd -ms /bin/bash -U -G sudo $USERNAME
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN mkdir /var/run/sshd

EXPOSE 22

USER $USERNAME
WORKDIR /home/$USERNAME

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/home/${USERNAME}/.cargo/bin:${PATH}"

USER root
CMD ["/usr/sbin/sshd", "-D"]
