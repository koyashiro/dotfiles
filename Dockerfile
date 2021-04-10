FROM debian:buster

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*

ARG USER=koyashiro
ARG HOME=/home/$USER \
    SHELL=/usr/bin/bash
ENV USER=$USER \
    XDG_CONFIG_HOME=$HOME/.config \
    XDG_CACHE_HOME=$HOME/.cache \
    XDG_DATA_HOME=$HOME/.local/share

RUN useradd -m -s /usr/bin/bash $USER \
  && echo $USER:$USER | chpasswd \
  && echo "$USER ALL=(ALL) ALL" >>/etc/sudoers

COPY --chown=$USER:$USER . $HOME/.dotfiles

USER $USER
WORKDIR $HOME
RUN ~/.dotfiles/install.sh
CMD ["bash", "--login"]
