#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${HYARAX_DIR}/lib.sh"

log_step "Doctor — Dependency Check"

FAILED=0

export PATH="${HOME}/.bun/bin:/opt/homebrew/opt/openjdk/bin:${PATH}"

check() {
  local name="$1" cmd="$2"
  if command -v "$cmd" &>/dev/null; then
    printf "  ${G}✔${N} %s\n" "$name"
  else
    printf "  ${R}✘${N} %s\n" "$name"
    FAILED=$((FAILED + 1))
  fi
}

check_app() {
  local name="$1" app="$2"
  if [[ -d "/Applications/${app}.app" ]] || [[ -d "${HOME}/Applications/${app}.app" ]]; then
    printf "  ${G}✔${N} %s\n" "$name"
  else
    printf "  ${R}✘${N} %s\n" "$name"
    FAILED=$((FAILED + 1))
  fi
}

# ── Terminal ─────────────────────────────────────────────────────────────────
log_info "Terminal"
check "Ghostty"    "ghostty"
check "Starship"   "starship"
check_zinit() {
  if [[ -d "${HOME}/.local/share/zinit/zinit.git" ]]; then
    printf "  ${G}✔${N} %s\n" "Zinit"
  else
    printf "  ${R}✘${N} %s\n" "Zinit"
    FAILED=$((FAILED + 1))
  fi
}
check_zinit

# ── Browser ──────────────────────────────────────────────────────────────────
log_info "Browser"
check_app "Brave Browser" "Brave Browser"

# ── CLI ──────────────────────────────────────────────────────────────────────
log_info "CLI Tools"
check "Git"        "git"
check "GitHub CLI" "gh"
check "eza"        "eza"
check "bat"        "bat"
check "fd"         "fd"
check "ripgrep"    "rg"
check "tree"       "tree"
check "jq"         "jq"
check "zoxide"     "zoxide"
check "fzf"        "fzf"
check "lazygit"    "lazygit"
check "lazydocker" "lazydocker"
check "thefuck"    "thefuck"
check "xh"         "xh"

# ── Runtimes ─────────────────────────────────────────────────────────────────
log_info "Runtimes"
check "Bun"        "bun"
check "PHP"        "php"
check "Composer"   "composer"
check "Java"       "java"

# ── Android ──────────────────────────────────────────────────────────────────
log_info "Android"
check_app "Android Studio" "Android Studio"
check "scrcpy"     "scrcpy"

# ── Container ────────────────────────────────────────────────────────────────
log_info "Container"
check "OrbStack"   "orb"

# ── AI ───────────────────────────────────────────────────────────────────────
log_info "AI"
check "OpenCode"   "opencode"
check "9router"    "9router"

# ── Networking ───────────────────────────────────────────────────────────────
log_info "Networking"
# warp-cli is Linux-only; macOS uses GUI app
if cmd_exists warp-cli; then
  printf "  ${G}✔${N} %s\n" "warp-cli"
else
  printf "  ${Y}～${N} %s\n" "Cloudflare WARP (GUI only on macOS)"
fi

# ── Utilities ────────────────────────────────────────────────────────────────
log_info "Utilities"
check "btop"       "btop"
check "atuin"      "atuin"
check "mkcert"     "mkcert"

# ── Summary ──────────────────────────────────────────────────────────────────
echo ""
if [[ $FAILED -eq 0 ]]; then
  log_ok "All dependencies are satisfied."
else
  log_error "${FAILED} dependency(ies) missing. Re-run ./bootstrap install"
  exit 1
fi
