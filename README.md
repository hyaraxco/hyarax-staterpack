# 🚀 Hyarax Starterpack

> One command. One click. Ready to code.

A production-quality macOS developer bootstrap that transforms a fresh Apple Silicon Mac into a complete development workstation with a single command.

## Features

- **One-command setup** — `./hyarax install` installs everything
- **Idempotent** — Safe to run multiple times
- **Homebrew-first** — All packages managed through Brewfile
- **Beautiful terminal** — Ghostty + Boo theme + Starship + Powerlevel10k
- **Modular** — Each tool category has its own script
- **Backup & restore** — Dotfiles are safe with `bootstrap backup`
- **Doctor** — Verify every dependency with `bootstrap doctor`

## Quick Start

```bash
git clone <your-repo-url> developer-bootstrap
cd developer-bootstrap
./hyarax install
```

Restart your terminal and you're ready to code.

## Commands

| Command | Description |
|---|---|
| `./hyarax install` | Full system installation |
| `./hyarax doctor` | Check all dependencies |
| `./hyarax backup` | Backup existing configs |
| `./hyarax restore` | Restore configs from backup |
| `./hyarax update` | Update all managed software |
| `./hyarax uninstall` | Remove managed configs (not packages) |

## What's Installed

### Terminal
Ghostty · Boo Theme · Starship · Zinit · Powerlevel10k · JetBrains Mono Nerd Font

### Browser
Brave Browser

### CLI Tools
Git · GitHub CLI · eza · bat · fd · ripgrep · tree · jq · zoxide · fzf · lazygit · lazydocker · thefuck · xh

### Runtimes
Bun (with node/npm/npx symlinks) · PHP · Composer · OpenJDK

### Android
Android Studio · Platform Tools · scrcpy

### Container
OrbStack

### AI
OpenCode CLI · 9router

### Networking
warp-cli

### Utilities
btop · atuin · mkcert

## Project Structure

```
developer-bootstrap/
├── bootstrap           # CLI entry point
├── install.sh          # Orchestrates full install
├── doctor.sh           # Dependency checker
├── backup.sh           # Config backup
├── restore.sh          # Config restore
├── update.sh           # Software updater
├── uninstall.sh        # Config uninstaller
├── Brewfile            # Homebrew package manifest
├── lib.sh              # Shared logging & helpers
├── scripts/
│   ├── brew.sh         # Homebrew & Brewfile
│   ├── shell.sh        # Zinit, Starship, Ghostty, Boo
│   ├── runtime.sh      # Bun, PHP, Composer, Java
│   ├── browser.sh      # Brave Browser
│   ├── android.sh      # Android Studio, scrcpy
│   ├── container.sh    # OrbStack
│   ├── ai.sh           # OpenCode, 9router
│   ├── networking.sh   # warp-cli
│   ├── utilities.sh    # btop, atuin, mkcert
│   └── verify.sh       # Post-install verification
├── dotfiles/           # Managed configuration files
│   ├── .zshrc
│   ├── .gitconfig
│   ├── .gitignore_global
│   ├── starship.toml
│   └── ghostty.config
├── backups/            # Backup storage directory
└── README.md
```

## Screenshots

> *Screenshots coming soon.*

## Requirements

- macOS (Apple Silicon)
- Internet connection
- sudo access

## Philosophy

- **Opinionated** — Makes decisions so you don't have to
- **Minimal** — Only what you need, nothing more
- **Fast** — Parallel where possible, optimized for speed
- **Modular** — One responsibility per script
- **Idempotent** — Run it 100 times, same result
- **Maintainable** — Clean bash, small functions, consistent style

## License

MIT
