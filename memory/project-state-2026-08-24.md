# Project state snapshot — 2026-08-24

This is a recovery snapshot from assistant context. It is not a replacement for Git evidence.

## Source hierarchy

```
real repositories
    |
    v
git commits / trees / artifacts
    |
    v
github_map (navigation index)
    |
    v
memory / notes / agent context
```

## Core principle

Facts must be separated from inference.

- CONFIRMED: backed by repository, commit, file, artifact, or test.
- INFERRED: plausible connection, requires verification.
- UNKNOWN: not proven.

## Main ecosystem

```
                 github_map
                     |
        +------------+-------------+
        |                          |
      memory                    agents
        |                          |
        v                          v
  project records            execution layer
        |
        v
 repositories
```

## Confirmed project areas

### Agent / memory ecosystem

- agents: execution layer around project memory ecosystem.
- loom: experiment log / operational layer.
- memory: long-term project state and records.
- github_map: lightweight repository and relation index.

### Mario Gamma chain

```
mario-gamma
     |
     +-- MesenCE
     |
     +-- posral
     |
     +-- possal
     |
     +-- SuperForge
```

Purpose: emulator-assisted research, privileged state extraction, experiments around game mechanisms.

### LLM / training

```
lora
 |
 +-- LoRA / PEFT experiments
 +-- evaluation artifacts
```

### Council

```
council-memory-first
        |
        +-- historical council experiments

council-project-memory
        |
        +-- canonical project memory direction
```

## Infrastructure principles

Evidence chain:

```
application
 |
local bridge
 |
localhost port
 |
proxy/tunnel
 |
external service
```

Always verify the real chain.

## Agent rules

Agents should:

- inspect existing state before changing it;
- use Git as source of truth;
- verify writes after changes;
- preserve failures and negative results;
- avoid converting assumptions into facts.

## UNKNOWN

Still requiring direct verification:

- complete project graph;
- all code homes;
- historical chat claims without artifacts;
- future architecture decisions.
