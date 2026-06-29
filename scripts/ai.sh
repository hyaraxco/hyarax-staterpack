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
if cmd_exists 9router; then
  log_ok "9router already installed"
else
  log_info "Installing 9router..."
  # Bun might have been installed earlier in the same session
  export PATH="${HOME}/.bun/bin:${PATH}"
  if cmd_exists bun; then
    bun install -g 9router 2>&1 || log_warn "Could not install 9router via bun"
  elif cmd_exists npm; then
    npm install -g 9router 2>&1 || log_warn "Could not install 9router via npm"
  else
    log_warn "No package manager available. Install manually: bun install -g 9router"
  fi
  cmd_exists 9router && log_ok "9router installed" || log_warn "9router installation failed"
fi
