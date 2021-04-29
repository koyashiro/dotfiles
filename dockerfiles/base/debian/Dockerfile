FROM debian:latest
WORKDIR /root

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*
