# Claude Code + GigaChat local runtime

Canonical home for the currently proven local Claude Code -> gpt2giga -> GigaChat execution path.

This is runtime/launcher material, not project memory and not a Council Lab topology decision.

## Proven source lock

Qualification evidence is stored in `fatterthancat/memory`:

- `projects/local-assistant/evidence/computer-claude-gigachat-fit-v01.md`
- first physical tool-loop evidence commit: `ce74bdfb8d5d491c7c9d35c69a5a980bbf89f7f6`
- edit/test evidence commit: `c858042dde69bce51b6a012437e58ea33feaee31`

Physically proven on 2026-08-25:

```text
Claude Code 2.1.187
  -> http://127.0.0.1:8090/v1/messages
  -> gpt2giga 0.3.0
  -> SOCKS5h 127.0.0.1:11880
  -> SSH dynamic tunnel to host alias `vds`
  -> GigaChat-3-Ultra
  -> Claude local Read/Edit/Bash tools
```

The qualification produced real filesystem writes, real shell execution, a source edit, Git diff inspection and `2 passed` from a targeted pytest run.

## Required local state

Do not commit credentials here.

Expected local secret file:

```text
~/.config/loom/secrets/gigachat.env
```

Expected local CA bundle:

```text
/etc/ssl/certs/ca-certificates.crt
```

The system bundle must contain the Russian Trusted Root CA chain required by the GigaChat endpoints. TLS verification remains enabled.

Expected SOCKS listener:

```text
127.0.0.1:11880
```

The physically observed tunnel command was:

```bash
ssh -N -D 127.0.0.1:11880 vds
```

## Claude Code pin

The qualified version is exactly `2.1.187`.

Install/update the pinned npm package without requiring a system-wide npm prefix:

```bash
npm install -g --prefix ~/.local @anthropic-ai/claude-code@2.1.187
hash -r
claude --version
```

Do not upgrade Claude Code during qualification/reproduction work unless a new version is intentionally being tested.

## Start the runtime

From this directory:

```bash
./doctor.sh
```

If the SOCKS tunnel is missing, start it first in another persistent terminal/tmux session:

```bash
ssh -N -D 127.0.0.1:11880 vds
```

Start gpt2giga in the foreground:

```bash
./start-gpt2giga.sh
```

Or detach it explicitly:

```bash
nohup ./start-gpt2giga.sh >/tmp/gpt2giga-claude.log 2>&1 &
```

Then verify again:

```bash
./doctor.sh
```

Launch Claude Code through the proven endpoint:

```bash
./claude-gigachat.sh
```

Pass normal Claude CLI arguments through the wrapper, for example:

```bash
./claude-gigachat.sh -p --max-turns 1 --no-session-persistence \
  'Reply with exactly: GIGA_CLAUDE_READY'
```

## Direct equivalent commands

The proven gpt2giga invocation is:

```bash
ALL_PROXY=socks5h://127.0.0.1:11880 \
NO_PROXY=127.0.0.1,localhost \
gpt2giga \
  --env-path ~/.config/loom/secrets/gigachat.env \
  --proxy.port 8090 \
  --proxy.pass-model false \
  --gigachat.ca-bundle-file /etc/ssl/certs/ca-certificates.crt \
  --gigachat.model GigaChat-3-Ultra
```

The proven Claude environment is:

```bash
ANTHROPIC_BASE_URL=http://127.0.0.1:8090 \
ANTHROPIC_API_KEY=0 \
DISABLE_AUTOUPDATER=1 \
NO_PROXY=127.0.0.1,localhost \
claude --model GigaChat-3-Ultra
```

## Health check

A healthy gpt2giga path must return HTTP 200 and include `GigaChat-3-Ultra`:

```bash
curl -fsS --max-time 20 http://127.0.0.1:8090/v1/models
```

Startup settings should show:

```text
pass_model: False
model: GigaChat-3-Ultra
verify_ssl_certs: True
ca_bundle_file: /etc/ssl/certs/ca-certificates.crt
```

## Python test command discovered during qualification

On the qualified host there is no `python` executable and pytest is not installed globally. The working ephemeral uv form was:

```bash
uv run --with pytest python -m pytest tests/test_calc.py -q
```

Calling the `pytest` console script directly through `uv run --with pytest pytest ...` caused an import-path collection failure in the disposable qualification repository. Prefer `python -m pytest` through uv for that shape of project.

## Known behavior

GigaChat-3-Ultra returned transient HTTP 429 `Too Many Requests` responses during several qualification runs. Claude Code retried and the tested runs recovered successfully. Treat this as a reliability signal to measure, not as proof of a broken tool loop.

The local gpt2giga endpoint is intentionally bound to localhost. Do not expose it publicly without private-network or strong authentication controls.
