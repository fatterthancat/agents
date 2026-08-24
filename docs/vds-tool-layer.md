# VDS as remote tool layer

## Concept

The agent ecosystem should not be designed as one monolithic agent running everything. The VDS is an execution layer, while GitHub remains the source of truth for project state, history, and evidence.

Architecture:

```
VDS:
  CPU + network + execution

GitHub:
  history + state + evidence

Local PC:
  heavy computation + GPU workloads
```

## Role separation

GitHub repositories (`memory`, `github_map`, `agents`, `mcp` and project repositories) act as external memory and canonical state storage.

The VDS provides runtime capabilities:

- MCP servers;
- agent tools;
- temporary workspaces;
- deployment/runtime services.

The server should remain as stateless as practical. If the VDS is replaced:

```
new server
    -> clone repositories
    -> restore environment
    -> start services
```

## Tool layer model

Prefer multiple focused tool packages instead of one large autonomous agent:

```
agents/
├── github-agent-tools
├── repo-analysis-tools
├── research-tools
└── deployment-tools
```

The orchestrating model decides which tools to use. The VDS provides capabilities; it is not the owner of project knowledge.

## Deployment pattern

```
ChatGPT/Codex/client
          |
          v
        MCP endpoint
          |
          v
        VDS runtime
          |
          +-- GitHub tools
          +-- project analysis tools
          +-- deployment tools
```

The goal is a remote instrument layer following MCP principles: tools perform controlled operations and return evidence, while persistent state remains in versioned repositories.

## Small VDS runtime profile

Example always-on node:

```
Ubuntu 24.04
CPU: 2 cores
RAM: 2 GB
Storage: 40 GB
Traffic: 32 TB
```

Intended use:

- MCP gateway;
- GitHub evidence tools;
- lightweight agent tools;
- reverse proxy;
- service coordination.

Not intended use:

- local LLM inference;
- large model hosting;
- large permanent repository mirrors;
- heavy build workloads.

Resource strategy:

```
VDS:
  always-on services + network + execution

GitHub:
  canonical state + history + evidence

Local workstation:
  GPU workloads + heavy computation
```

The VDS should remain small and replaceable rather than becoming another source of truth.
