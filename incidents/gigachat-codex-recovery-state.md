# GigaChat + Codex Recovery State (Single Handoff)

Date: 2026-08-24

Purpose: preserve one complete handoff point for future chats. This file is the recovery snapshot, not a design document.

## CURRENT CONFIRMED STATE

### Working topology

```
Codex
 |
 model_provider = giga
 |
 gpt2giga local bridge
 |
 http://127.0.0.1:8090/v1
 |
 GigaChat API
```

### Local bridge evidence

Confirmed:

- `gpt2giga --env-path ~/.config/loom/secrets/gigachat.env --inspect-config --proxy.port 8090`
  returned valid configuration.
- Profile:
  - id: `native-gigachat`
  - provider: `gigachat`
  - base_url: `https://api.giga.chat/v1`
- `curl http://127.0.0.1:8090/v1/models` returned models:
  - GigaChat-2
  - GigaChat-2-Max
  - GigaChat-2-Pro
  - GigaChat-3-Ultra
  - Embeddings variants
- `POST /v1/chat/completions` succeeded through localhost bridge.

Test:

```
model: GigaChat-2
message: "Скажи одно слово: работает"
response: "работает"
```

## CODEX CONFIGURATION

Confirmed:

`~/.codex/config.toml`

```
[model_providers.giga]
name = "GigaChat via gpt2giga"
base_url = "http://127.0.0.1:8090/v1"
wire_api = "responses"
requires_openai_auth = false
```

Additional config found:

```
~/.codex/giga.config.toml

model = "codex-giga"
model_provider = "giga"
```

## SECRETS

Confirmed:

```
~/.config/loom/secrets/gigachat.env
GIGACHAT_CREDENTIALS=...
```

Do not copy credentials into GitHub.

## RELATED REPOSITORIES

Relevant repositories:

- `loom`
- `council-memory-first`
- `lora`
- `agents`
- `github_map`

These are context sources only. Runtime truth is the machine state and Git history.

## RECOVERY HISTORY

Problem: repeated reconstruction of the same working state from chat history.

Failure class:

- OAuth/token/session persistence was uncertain.
- Codex config was not proven to be the root cause.
- Bridge itself was proven functional.

## UNKNOWN

Still not proven:

- exact bridge launch command used for the last persistent setup;
- token persistence behavior after reboot;
- which repository contains the canonical setup instructions.

## NEXT TIME

Start here:

1. Check `gpt2giga` process and port 8090.
2. Run `/v1/models` health check.
3. Run one `/v1/chat/completions` test.
4. Only then inspect Codex config.

This file is intended as the single recovery handoff point.