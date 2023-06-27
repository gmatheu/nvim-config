
FROM ubuntu:22.04

RUN apt update \
   && apt install -yq ripgrep curl git software-properties-common\ 
   && apt clean
RUN add-apt-repository -y ppa:neovim-ppa/unstable \
   && apt install -yq neovim python3-neovim  \
   && apt clean

ENV HOME /root
ENV NVIM_APPNAME nvim-config
WORKDIR $HOME/.config
ADD . $NVIM_APPNAME

WORKDIR $HOME/.config/$NVIM_APPNAME
RUN ./bootstrap.sh
