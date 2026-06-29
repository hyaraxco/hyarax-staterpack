#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "${HYARAX_DIR}/lib.sh"

# ── warp-cli ─────────────────────────────────────────────────────────────────
if cmd_exists warp-cli; then
  log_ok "warp-cli installed"
else
  log_warn "warp-cli should be installed via Brewfile"
  log_info "Note: warp-cli requires Cloudflare WARP desktop app to be installed manually first."
  log_info "Download from: https://1.1.1.1/"
fi
