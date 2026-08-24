# GigaChat Codex Recovery State

Date: 2026-08-24

## Context

A repeated recovery effort was required to restore a previously working Codex -> GigaChat state. This record exists to avoid reconstructing the same runtime state from conversation history.

## CONFIRMED

- Repository ecosystem contains dedicated components:
  - `loom`
  - `council-memory-first`
  - `lora`
  - `agents`
- Local Codex configuration observed:

```toml
model = "codex-giga"
model_provider = "giga"

[projects."/home/kln/neuro/nassal/possal"]
trust_level = "trusted"

[tui.model_availability_nux]
"gpt-5.6-sol" = 4
```

- Previous working topology involved:

```
Codex
 |
 provider = giga
 |
 local OpenAI-compatible bridge
 |
 localhost endpoint
 |
 GigaChat API
```

## KNOWN FAILURE

- GigaChat authentication failure observed as expired token / OAuth state problem.
- Failure was not proven to be caused by Codex configuration.

## UNKNOWN

- Exact source of persisted GigaChat credentials.
- Whether token cache survives reboot/session changes.
- Exact command sequence that produced the last known PASS state.

## NEXT VERIFY

1. Identify current bridge version and launch command.
2. Record credential loading path.
3. Run one minimal OAuth health check.
4. Record PASS output and timestamp.

Do not modify Codex configuration until the bridge/authentication layer is verified.
