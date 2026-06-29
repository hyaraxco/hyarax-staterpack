#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${HYARAX_DIR}/lib.sh"

log_step "Update — Upgrading All Managed Software"

if cmd_exists brew; then
  log_sub "Updating Homebrew..."
  brew update
  log_sub "Upgrading packages..."
  brew upgrade
  log_sub "Cleaning up..."
  brew cleanup
fi

if cmd_exists bun; then
  log_sub "Updating Bun..."
  bun upgrade
fi

if cmd_exists opencode; then
  log_sub "Updating OpenCode..."
  opencode update 2>/dev/null || log_warn "Could not update OpenCode"
fi

log_ok "Update complete"
