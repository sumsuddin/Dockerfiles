FROM ubuntu:20.04

LABEL MAINTAINER = "Sumsuddin Shojib"
LABEL EMAIL = "sumsuddinshojib@gmail.com"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update \
  && apt install -y --no-install-recommends \
    sudo \
    wget \
    fish \
    && apt clean

RUN wget --no-check-certificate https://raw.githubusercontent.com/JetBrains/clion-wsl/630dd9f9f20d13e0baf9d3f39693d21a7b93fb11/ubuntu_setup_env.sh && bash ubuntu_setup_env.sh
RUN echo "echo 'dockeruser' | sudo -S service ssh --full-restart && tail -f /dev/null" > ssh.sh
RUN useradd -ms /bin/bash -g root -G sudo -p dockeruser dockeruser
RUN echo dockeruser:dockeruser | chpasswd
RUN chown dockeruser: /ssh.sh \
  && chmod +x /ssh.sh

USER dockeruser

CMD "/ssh.sh"
