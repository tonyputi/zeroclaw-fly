FROM ghcr.io/zeroclaw-labs/zeroclaw:debian AS base

FROM base
USER root
ENV SHELL=/bin/bash

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 \
    -o /usr/local/bin/cloudflared && chmod +x /usr/local/bin/cloudflared

RUN cp /usr/local/bin/zeroclaw /usr/local/bin/zeroclaw-bin && \
    printf '#!/bin/sh\nHOME=/zeroclaw-data ZEROCLAW_WORKSPACE=/zeroclaw-data/workspace exec /usr/local/bin/zeroclaw-bin "$@"\n' \
    > /usr/local/bin/zeroclaw && \
    chmod +x /usr/local/bin/zeroclaw
