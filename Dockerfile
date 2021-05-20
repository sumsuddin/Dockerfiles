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

ARG USERNAME=dockeruser
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && usermod -aG video dockeruser

USER $USERNAME