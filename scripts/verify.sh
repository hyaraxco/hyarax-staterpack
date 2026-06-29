#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "${HYARAX_DIR}/lib.sh"

log_step "Verification"

FAILED=0

# Ensure common paths for commands installed during bootstrap
export PATH="${HOME}/.bun/bin:/opt/homebrew/opt/openjdk/bin:${PATH}"

verify() {
  local name="$1" cmd="$2"
  if command -v "$cmd" &>/dev/null; then
    printf "  ${G}✔${N} %s\n" "$name"
  else
    printf "  ${R}✘${N} %s\n" "$name"
    FAILED=$((FAILED + 1))
  fi
}

verify "Git"           git
verify "GitHub CLI"    gh
verify "eza"           eza
verify "bat"           bat
verify "fd"            fd
verify "ripgrep"       rg
verify "tree"          tree
verify "jq"            jq
verify "zoxide"        zoxide
verify "fzf"           fzf
verify "lazygit"       lazygit
verify "lazydocker"    lazydocker
verify "thefuck"       thefuck
verify "xh"            xh
# verify "Starship"      starship  # Replaced by Boo theme prompt
verify "Bun"           bun
verify "PHP"           php
verify "Composer"      composer
verify "Java"          java
verify "btop"          btop
verify "atuin"         atuin
verify "mkcert"        mkcert
verify "scrcpy"        scrcpy

echo ""
if [[ $FAILED -eq 0 ]]; then
  log_ok "All verified — system ready."
else
  log_warn "${FAILED} check(s) failed. Some packages may need manual review."
fi
