#!/usr/bin/env bash
set -u

SOCKS_PORT="11880"
GPT2GIGA_PORT="8090"
ENV_PATH="${GPT2GIGA_ENV_PATH:-$HOME/.config/loom/secrets/gigachat.env}"
CA_BUNDLE="${GIGACHAT_CA_BUNDLE_FILE:-/etc/ssl/certs/ca-certificates.crt}"
EXPECTED_CLAUDE="2.1.187"
failed=0

ok() { printf 'PASS  %s\n' "$1"; }
fail() { printf 'FAIL  %s\n' "$1"; failed=1; }
info() { printf 'INFO  %s\n' "$1"; }

if ss -ltn 2>/dev/null | grep -q "127.0.0.1:${SOCKS_PORT}"; then
  ok "SOCKS listener 127.0.0.1:${SOCKS_PORT}"
  pgrep -af "ssh.*${SOCKS_PORT}|ssh.*-D" 2>/dev/null | sed 's/^/      /' || true
else
  fail "SOCKS listener 127.0.0.1:${SOCKS_PORT} missing"
fi

if [[ -r "$ENV_PATH" ]]; then
  ok "GigaChat env file exists: $ENV_PATH"
else
  fail "GigaChat env file missing/unreadable: $ENV_PATH"
fi

if [[ -r "$CA_BUNDLE" ]]; then
  ok "CA bundle exists: $CA_BUNDLE"
  if openssl crl2pkcs7 -nocrl -certfile "$CA_BUNDLE" 2>/dev/null \
    | openssl pkcs7 -print_certs -noout 2>/dev/null \
    | grep -q 'Russian Trusted Root CA'; then
    ok "Russian Trusted Root CA present in bundle"
  else
    fail "Russian Trusted Root CA not found in bundle"
  fi
else
  fail "CA bundle missing/unreadable: $CA_BUNDLE"
fi

if command -v gpt2giga >/dev/null 2>&1; then
  info "gpt2giga: $(command -v gpt2giga)"
  if command -v uv >/dev/null 2>&1; then
    uv tool list 2>/dev/null | grep -E '^gpt2giga ' | sed 's/^/      /' || true
  fi
else
  fail "gpt2giga not found in PATH"
fi

if ss -ltn 2>/dev/null | grep -q "127.0.0.1:${GPT2GIGA_PORT}"; then
  ok "gpt2giga listener 127.0.0.1:${GPT2GIGA_PORT}"
  ss -ltnp 2>/dev/null | grep ":${GPT2GIGA_PORT}" | sed 's/^/      /' || true
  if models="$(curl -fsS --max-time 20 "http://127.0.0.1:${GPT2GIGA_PORT}/v1/models" 2>/dev/null)"; then
    ok "GET /v1/models"
    if printf '%s' "$models" | grep -q 'GigaChat-3-Ultra'; then
      ok "GigaChat-3-Ultra advertised"
    else
      fail "GigaChat-3-Ultra missing from /v1/models"
    fi
  else
    fail "GET /v1/models failed"
  fi
else
  fail "gpt2giga listener 127.0.0.1:${GPT2GIGA_PORT} missing"
fi

if command -v claude >/dev/null 2>&1; then
  version="$(claude --version 2>/dev/null | awk '{print $1}')"
  if [[ "$version" == "$EXPECTED_CLAUDE" ]]; then
    ok "Claude Code ${EXPECTED_CLAUDE}"
  else
    fail "Claude Code version ${version:-unknown}; expected ${EXPECTED_CLAUDE}"
  fi
else
  fail "Claude Code not found in PATH"
fi

exit "$failed"
