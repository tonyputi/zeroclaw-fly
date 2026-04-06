# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

IaC repository for deploying [ZeroClaw](https://github.com/zeroclaw-labs/zeroclaw) AI agent instances to Fly.io. It does **not** build ZeroClaw from source — it extends the official pre-built GHCR image with thin wrappers for Cloudflare Tunnel support and correct environment setup, then deploys three independent assistant instances.

## Deploy commands

Each instance is deployed from its own subdirectory:

```bash
# Deploy a specific instance
fly deploy --config antonello/fly.toml
fly deploy --config benito/fly.toml
fly deploy --config rocco/fly.toml

# Manage secrets per instance
fly secrets set API_KEY="sk-..." --app antonello
fly secrets set API_KEY="sk-..." --app zeroclaw-benito
fly secrets set API_KEY="sk-..." --app zeroclaw-rocco
```

First-time setup for a new instance:
```bash
fly apps create <app-name>
fly volumes create zeroclaw_data --size 1 --app <app-name>
fly secrets set API_KEY="sk-..." --app <app-name>
fly deploy --config <instance>/fly.toml
```

## Architecture

**Dockerfile** — single-stage build extending `ghcr.io/zeroclaw-labs/zeroclaw:debian`:
1. Installs `cloudflared` binary from GitHub releases
2. Wraps it to emit `https://<CLOUDFLARE_TUNNEL_HOSTNAME>` to stdout when the tunnel connects (used by ZeroClaw for auto-detection)
3. Wraps the `zeroclaw` binary to force `HOME=/zeroclaw-data` and `ZEROCLAW_WORKSPACE=/zeroclaw-data/workspace`

**Instance layout** — three directories (`antonello/`, `benito/`, `rocco/`), each with a `fly.toml` and a `workspace/` placeholder for the Fly volume mount at `/zeroclaw-data`.

**Networking per instance:**
- `antonello` — no public `http_service`; access only via Cloudflare Tunnel at `antonello.sallemi.it`
- `benito` / `rocco` — public `http_service` on internal port `42617` with HTTPS forced, always-on (min 1 machine)

**Key env vars** (set in `fly.toml` or via `fly secrets`):

| Variable                    | Notes                                                       |
| --------------------------- | ----------------------------------------------------------- |
| `API_KEY`                   | LLM provider API key — always use `fly secrets`            |
| `PROVIDER`                  | `gemini` (current default) or `openrouter`                 |
| `CLOUDFLARE_TUNNEL_HOSTNAME`| Required for Cloudflare Tunnel; only set on `antonello`    |
| `ZEROCLAW_GATEWAY_PORT`     | Default `42617`                                             |

## Adding a new instance

1. Copy an existing instance directory (e.g. `cp -r benito newname`)
2. Update `app` and any env vars in `newname/fly.toml`
3. Run the first-time setup commands above
4. For Cloudflare Tunnel access: set `CLOUDFLARE_TUNNEL_HOSTNAME` in `fly.toml` and remove the `[http_service]` block
