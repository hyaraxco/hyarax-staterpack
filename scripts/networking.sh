#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "${HYARAX_DIR}/lib.sh"

# ── Cloudflare WARP ──────────────────────────────────────────────────────────
if cmd_exists warp-cli; then
  log_ok "warp-cli installed"
elif [[ -d "/Applications/Cloudflare WARP.app" ]]; then
  log_ok "Cloudflare WARP (GUI) installed — CLI not available on macOS"
else
  log_warn "Cloudflare WARP not installed"
  log_info "Download GUI app: https://developers.cloudflare.com/warp-client/get-started/macos/"
fi
