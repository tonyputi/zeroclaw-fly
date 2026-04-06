FROM ghcr.io/zeroclaw-labs/zeroclaw:debian AS base

FROM base
USER root
ENV SHELL=/bin/bash

# Personality seed — copied to /zeroclaw-data/workspace only on first boot (if empty)
ARG INSTANCE=antonello
COPY ${INSTANCE}/workspace /zeroclaw-seed

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 \
    -o /usr/local/bin/cloudflared-bin && chmod +x /usr/local/bin/cloudflared-bin

RUN printf '#!/bin/sh\ncloudflared-bin "$@" 2>&1 | awk -v h="$CLOUDFLARE_TUNNEL_HOSTNAME" '"'"'{print; fflush(); if(/Registered tunnel connection connIndex=0/ && h!=""){print "https://"h; fflush()}}'"'"'\n' \
    > /usr/local/bin/cloudflared && chmod +x /usr/local/bin/cloudflared

RUN cp /usr/local/bin/zeroclaw /usr/local/bin/zeroclaw-bin && \
    printf '#!/bin/sh\nHOME=/zeroclaw-data ZEROCLAW_WORKSPACE=/zeroclaw-data/workspace exec /usr/local/bin/zeroclaw-bin "$@"\n' \
    > /usr/local/bin/zeroclaw && \
    chmod +x /usr/local/bin/zeroclaw

# Init script: seeds workspace on first boot, then starts daemon
RUN printf '#!/bin/sh\n\
set -e\n\
WS=/zeroclaw-data/workspace\n\
SEED=/zeroclaw-seed\n\
if [ -d "$SEED" ] && [ -z "$(ls -A $WS 2>/dev/null)" ]; then\n\
  echo "[init] Seeding workspace from $SEED..."\n\
  cp -r $SEED/. $WS/\n\
fi\n\
exec zeroclaw daemon\n' \
    > /usr/local/bin/entrypoint.sh && chmod +x /usr/local/bin/entrypoint.sh

CMD ["/usr/local/bin/entrypoint.sh"]
