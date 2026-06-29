#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "${HYARAX_DIR}/lib.sh"

# ── OrbStack ─────────────────────────────────────────────────────────────────
if cmd_exists orb; then
  log_ok "OrbStack installed"
elif [[ -d "/Applications/OrbStack.app" ]]; then
  log_ok "OrbStack.app present (orb CLI may need PATH)"
else
  log_warn "OrbStack should be installed via Brewfile (cask)"
  log_info "Run: brew install --cask orbstack"
fi
