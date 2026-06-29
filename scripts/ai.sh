#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "${HYARAX_DIR}/lib.sh"

# ── OpenCode CLI ─────────────────────────────────────────────────────────────
if ! cmd_exists opencode; then
  log_info "Installing OpenCode CLI..."
  if cmd_exists bun; then
    bun install -g opencode || log_warn "Could not install opencode via bun"
  elif cmd_exists npm; then
    npm install -g @opencode/cli || log_warn "Could not install opencode via npm"
  else
    log_warn "No package manager available to install opencode"
    log_info "Install manually: bun install -g opencode"
  fi
  log_ok "OpenCode CLI installed"
else
  log_ok "OpenCode CLI already installed ($(opencode --version 2>/dev/null || true))"
fi

# ── 9router ──────────────────────────────────────────────────────────────────
if ! cmd_exists 9router; then
  log_info "Installing 9router..."
  if cmd_exists go; then
    go install github.com/9gag/9router@latest 2>/dev/null || log_warn "Could not install 9router"
  else
    log_warn "Go is not installed. Install 9router manually:"
    log_info "  brew tap 9gag/9router && brew install 9router"
  fi
else
  log_ok "9router already installed"
fi
