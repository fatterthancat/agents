#!/usr/bin/env bash
set -euo pipefail

EXPECTED_VERSION="2.1.187"
BASE_URL="${ANTHROPIC_BASE_URL:-http://127.0.0.1:8090}"
MODEL="${CLAUDE_GIGACHAT_MODEL:-GigaChat-3-Ultra}"

if ! command -v claude >/dev/null 2>&1; then
  echo "Claude Code not found in PATH" >&2
  echo "Install the qualified pin:" >&2
  echo "  npm install -g --prefix ~/.local @anthropic-ai/claude-code@${EXPECTED_VERSION}" >&2
  exit 1
fi

actual_version="$(claude --version 2>/dev/null | awk '{print $1}')"
if [[ "$actual_version" != "$EXPECTED_VERSION" ]]; then
  echo "Claude Code version mismatch: expected ${EXPECTED_VERSION}, got ${actual_version:-unknown}" >&2
  echo "Refusing to silently change the qualified runtime." >&2
  exit 2
fi

if ! curl -fsS --max-time 10 "${BASE_URL}/v1/models" >/dev/null; then
  echo "gpt2giga health check failed at ${BASE_URL}/v1/models" >&2
  exit 3
fi

export ANTHROPIC_BASE_URL="$BASE_URL"
export ANTHROPIC_API_KEY="${ANTHROPIC_API_KEY:-0}"
export DISABLE_AUTOUPDATER=1
export NO_PROXY="127.0.0.1,localhost${NO_PROXY:+,$NO_PROXY}"

exec claude --model "$MODEL" "$@"
