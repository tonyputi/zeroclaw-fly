FROM ghcr.io/zeroclaw-labs/zeroclaw:debian AS base

FROM base
USER root
ENV SHELL=/bin/bash

RUN cp /usr/local/bin/zeroclaw /usr/local/bin/zeroclaw-bin && \
    printf '#!/bin/sh\nHOME=/zeroclaw-data ZEROCLAW_WORKSPACE=/zeroclaw-data/workspace exec /usr/local/bin/zeroclaw-bin "$@"\n' \
    > /usr/local/bin/zeroclaw && \
    chmod +x /usr/local/bin/zeroclaw
