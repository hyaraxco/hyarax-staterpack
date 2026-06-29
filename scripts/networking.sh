#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "${HYARAX_DIR}/lib.sh"

# ── warp-cli ─────────────────────────────────────────────────────────────────
if cmd_exists warp-cli; then
  log_ok "warp-cli installed"
else
  log_warn "warp-cli is not available via Homebrew"
  log_info "Install manually: https://developers.cloudflare.com/warp-client/get-started/macos/"
fi
