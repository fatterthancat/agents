# agents

First approximation: an execution layer around the existing project memory ecosystem.

## Initial model

```
LLM
 |
 github_map
 |
 Git history
 |
 artifacts
 |
 memory
 |
 new decisions
```

The goal is not to build a new agent framework from scratch. The first objective is a minimal working layer that can navigate existing evidence, use tools, and preserve decisions.

Example capability:

> "I see that mario-gamma exists, the latest known status is X, MesenCE is here, but the connection between them is not proven."

Uncertainty is data. UNKNOWN is preferable to invented certainty.

## Approach

Reuse existing components where possible:

- agent loop
- tool calling
- MCP/adapters
- Git operations
- local models
- memory systems

Build a minimal Frankenstein first, then evolve only when real usage requires it.

## MVP concept

```python
while True:
    read_task()

    load_github_map()

    decide:
        need_repo()
        need_memory()
        need_experiment()

    call_tools()

    write_result()
```

## Roles

```
github_map = map
memory     = long-term memory
Loom       = experiment log
agents     = executor
repos      = physical source of truth
```

The first milestone is not intelligence. It is maintaining project state over time.