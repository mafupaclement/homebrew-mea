# homebrew-mea

Homebrew tap for [MEA Local Agent](https://mearchiver.com) — document scanning and file staging service.

## Install

```bash
brew tap mafupaclement/mea
brew install mea-agent
brew services start mea-agent
```

## Requirements

- macOS 12+
- Scanner: `brew install sane-backends` (optional, only needed for document scanning)

## Verify

```bash
curl -s http://127.0.0.1:8100/health
```

## On-prem MEA server (HTTPS)

For a self-hosted (on-prem) MEA server, trust its certificate so the browser gets a secure
context (required for end-to-end encryption). Run once (sudo prompts internally):

```bash
mea-agent-trust 192.168.1.10    # with the server IP: adds a hosts entry, then trusts the cert
mea-agent-trust                 # DNS mode (name already resolves): only trusts the cert
```

Not needed on SaaS (`mearchiver.com`) — the certificate is publicly trusted.

## Uninstall

```bash
brew services stop mea-agent
brew uninstall mea-agent
brew untap mafupaclement/mea
```
