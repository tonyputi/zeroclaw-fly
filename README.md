# zeroclaw-fly

Fly.io deployment config for [ZeroClaw](https://github.com/zeroclaw-labs/zeroclaw).

Uses the official pre-built image from GHCR — no build step required.

## Setup

1. Install flyctl and login: `fly auth login`
2. Create the app: `fly apps create zeroclaw`
3. Create the volume: `fly volumes create zeroclaw_data --size 1`
4. Set your API key: `fly secrets set API_KEY="sk-..."`
5. Deploy: `fly deploy`

## Auto-deploy

Connect this repo to Fly.io via the dashboard to enable automatic redeployment on every push to `main`.

## Configuration

All runtime options are set via environment variables or `fly secrets`:

| Variable   | Required | Description                        |
| ---------- | -------- | ---------------------------------- |
| `API_KEY`  | yes      | LLM provider API key (use secrets) |
| `PROVIDER` | no       | Default: `openrouter`              |
