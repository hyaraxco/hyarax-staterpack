#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${HYARAX_DIR}/lib.sh"

log_step "Hyarax Starterpack — Installation"
log_info "Platform: macOS $(sw_vers -productVersion) on Apple Silicon"

# ── 1. Brew ──────────────────────────────────────────────────────────────────
log_step "Package Manager"
"${HYARAX_DIR}/scripts/brew.sh"

# ── 2. Shell ─────────────────────────────────────────────────────────────────
log_step "Shell & Terminal"
"${HYARAX_DIR}/scripts/shell.sh"

# ── 3. Runtimes ──────────────────────────────────────────────────────────────
log_step "Runtimes"
"${HYARAX_DIR}/scripts/runtime.sh"

# ── 4. Browser ───────────────────────────────────────────────────────────────
log_step "Browser"
"${HYARAX_DIR}/scripts/browser.sh"

# ── 5. Container ─────────────────────────────────────────────────────────────
log_step "Container"
"${HYARAX_DIR}/scripts/container.sh"

# ── 6. AI ────────────────────────────────────────────────────────────────────
log_step "AI Tools"
"${HYARAX_DIR}/scripts/ai.sh"

# ── 7. Networking ────────────────────────────────────────────────────────────
log_step "Networking"
"${HYARAX_DIR}/scripts/networking.sh"

# ── 8. Utilities ─────────────────────────────────────────────────────────────
log_step "Utilities"
"${HYARAX_DIR}/scripts/utilities.sh"

# ── 9. Android ───────────────────────────────────────────────────────────────
log_step "Android Development"
"${HYARAX_DIR}/scripts/android.sh"

# ── 10. Dotfiles ─────────────────────────────────────────────────────────────
log_step "Dotfiles"
"${HYARAX_DIR}/restore.sh"

# ── 11. Hyarax CLI ────────────────────────────────────────────────────────────
log_step "Hyarax CLI"
ensure_dir "${HOME}/.local/bin"
if [[ ! -L "${HOME}/.local/bin/hyarax" ]]; then
  ln -sf "${HYARAX_DIR}/hyarax" "${HOME}/.local/bin/hyarax"
  log_sub "Symlinked hyarax to ~/.local/bin/hyarax"
fi
if ! echo "$PATH" | tr ':' '\n' | grep -qx "${HOME}/.local/bin"; then
  append_if_missing "${HOME}/.zshrc" 'export PATH="${HOME}/.local/bin:${PATH}"'
  log_sub "Added ~/.local/bin to PATH in .zshrc"
fi
log_ok "Hyarax CLI ready — use: hyarax install"

# ── 12. Verify ───────────────────────────────────────────────────────────────
log_step "Verification"
"${HYARAX_DIR}/scripts/verify.sh"

log_step "Installation Complete"
log_ok "Your system is ready for development."
log_info "Restart your terminal or run: exec \$SHELL -l"
