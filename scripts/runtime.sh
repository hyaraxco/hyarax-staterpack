#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "${HYARAX_DIR}/lib.sh"

# ── Bun ──────────────────────────────────────────────────────────────────────
if ! cmd_exists bun; then
  log_info "Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
  log_ok "Bun installed"

  # Add to PATH for current session
  export PATH="${HOME}/.bun/bin:${PATH}"

  # Symlink node/npm/npx for compatibility
  if [[ -d "${HOME}/.bun/bin" ]]; then
    ln -sf "${HOME}/.bun/bin/bun" "${HOME}/.bun/bin/node" 2>/dev/null || true
    ln -sf "${HOME}/.bun/bin/bun" "${HOME}/.bun/bin/npm"  2>/dev/null || true
    ln -sf "${HOME}/.bun/bin/bun" "${HOME}/.bun/bin/npx"  2>/dev/null || true
    log_sub "Created node/npm/npx symlinks via Bun"
  fi
else
  log_ok "Bun already installed ($(bun --version))"
fi

# ── PHP ──────────────────────────────────────────────────────────────────────
if cmd_exists php; then
  log_ok "PHP installed ($(php -v | head -1))"
else
  log_warn "PHP should be installed via Brewfile. Check: brew install php"
fi

# ── Composer ─────────────────────────────────────────────────────────────────
if cmd_exists composer; then
  log_ok "Composer installed"
else
  log_warn "Composer should be installed via Brewfile"
fi

# ── OpenJDK ──────────────────────────────────────────────────────────────────
if cmd_exists java; then
  log_ok "Java installed ($(java -version 2>&1 | head -1))"
else
  log_warn "OpenJDK should be installed via Brewfile. Check: brew install openjdk"
fi
