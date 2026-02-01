FROM ubuntu:24.04

LABEL author="Borja Castellano" version="0.1.0"

ARG USERNAME=ubuntu

RUN apt-get update && \
    apt-get install -y \
    sudo \
    curl \
    git \
    build-essential \
    openssh-server
    
RUN deluser --remove-home ubuntu

RUN useradd -ms /bin/bash -U -G sudo $USERNAME
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN mkdir /var/run/sshd

EXPOSE 22

USER $USERNAME
WORKDIR /home/$USERNAME

COPY .bash_start /home/$USERNAME/.bash_start
RUN chmod +x /home/$USERNAME/.bash_start
RUN source /home/$USERNAME/.bash_start

# Install nvm and Node.js 22, needed for OpenClaw
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
RUN nvm install 22 && nvm use 22

# Install OpenClaw
RUN npm install -g openclaw@latest

USER root
CMD ["/usr/sbin/sshd", "-D"]
