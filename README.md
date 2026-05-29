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

## Uninstall

```bash
brew services stop mea-agent
brew uninstall mea-agent
brew untap mafupaclement/mea
```
