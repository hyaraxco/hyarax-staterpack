#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "${HYARAX_DIR}/lib.sh"

# ── Brave Browser ────────────────────────────────────────────────────────────
if [[ -d "/Applications/Brave Browser.app" ]]; then
  log_ok "Brave Browser already installed"
else
  log_warn "Brave Browser should be installed via Brewfile (cask)"
  log_info "Run: brew install --cask brave-browser"
fi
