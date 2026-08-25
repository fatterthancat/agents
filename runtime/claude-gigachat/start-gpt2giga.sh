#!/usr/bin/env bash
set -euo pipefail

SOCKS_HOST="127.0.0.1"
SOCKS_PORT="11880"
GPT2GIGA_PORT="8090"
ENV_PATH="${GPT2GIGA_ENV_PATH:-$HOME/.config/loom/secrets/gigachat.env}"
CA_BUNDLE="${GIGACHAT_CA_BUNDLE_FILE:-/etc/ssl/certs/ca-certificates.crt}"
MODEL="${GIGACHAT_MODEL:-GigaChat-3-Ultra}"

if ! command -v gpt2giga >/dev/null 2>&1; then
  echo "gpt2giga not found in PATH" >&2
  exit 1
fi

if [[ ! -r "$ENV_PATH" ]]; then
  echo "GigaChat env file is missing or unreadable: $ENV_PATH" >&2
  exit 1
fi

if [[ ! -r "$CA_BUNDLE" ]]; then
  echo "CA bundle is missing or unreadable: $CA_BUNDLE" >&2
  exit 1
fi

if ! ss -ltn 2>/dev/null | grep -q "${SOCKS_HOST}:${SOCKS_PORT}"; then
  echo "SOCKS tunnel is not listening on ${SOCKS_HOST}:${SOCKS_PORT}" >&2
  echo "Start it separately: ssh -N -D ${SOCKS_HOST}:${SOCKS_PORT} vds" >&2
  exit 2
fi

if ss -ltn 2>/dev/null | grep -q "127.0.0.1:${GPT2GIGA_PORT}"; then
  echo "Port ${GPT2GIGA_PORT} is already in use:" >&2
  ss -ltnp 2>/dev/null | grep ":${GPT2GIGA_PORT}" >&2 || true
  exit 3
fi

export ALL_PROXY="socks5h://${SOCKS_HOST}:${SOCKS_PORT}"
export NO_PROXY="127.0.0.1,localhost"

exec gpt2giga \
  --env-path "$ENV_PATH" \
  --proxy.port "$GPT2GIGA_PORT" \
  --proxy.pass-model false \
  --gigachat.ca-bundle-file "$CA_BUNDLE" \
  --gigachat.model "$MODEL"
