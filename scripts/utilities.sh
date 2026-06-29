#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "${HYARAX_DIR}/lib.sh"

# ── btop ─────────────────────────────────────────────────────────────────────
if cmd_exists btop; then
  log_ok "btop installed"
else
  log_warn "btop should be installed via Brewfile"
fi

# ── atuin ────────────────────────────────────────────────────────────────────
if cmd_exists atuin; then
  log_ok "atuin installed"
else
  log_warn "atuin should be installed via Brewfile"
fi

# ── mkcert ───────────────────────────────────────────────────────────────────
if cmd_exists mkcert; then
  log_ok "mkcert installed"

  # Install root CA if not already done
  if [[ ! -f "${HOME}/.local/share/mkcert/rootCA.pem" ]]; then
    log_info "Installing mkcert root CA..."
    mkcert -install 2>/dev/null || log_warn "Could not install mkcert root CA"
  fi
else
  log_warn "mkcert should be installed via Brewfile"
fi
