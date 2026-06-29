#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${HYARAX_DIR}/lib.sh"

log_step "Restore — Applying Dotfiles"

# ── Backup personal config if it exists ─────────────────────────────────────
restore_file "${HOME}/.gitconfig"

# ── Deploy Hyarax dotfiles (always source of truth) ────────────────────────
deploy_dotfile() {
  local src="$1" dest="$2"
  if [[ -f "$src" ]]; then
    if [[ -f "$dest" ]] && [[ ! -L "$dest" ]]; then
      backup_file "$dest"
    fi
    symlink_dotfile "$src" "$dest"
  fi
}

deploy_dotfile "${DOTFILES_DIR}/.zshrc" "${HOME}/.zshrc"
deploy_dotfile "${DOTFILES_DIR}/.gitignore_global" "${HOME}/.gitignore_global"

# ensure_dir "${HOME}/.config"
# deploy_dotfile "${DOTFILES_DIR}/starship.toml" "${HOME}/.config/starship.toml"  # Boo handles prompt

GHOSTTY_DIR="${HOME}/Library/Application Support/com.mitchellh.ghostty"
ensure_dir "${GHOSTTY_DIR}"
deploy_dotfile "${DOTFILES_DIR}/ghostty.config" "${GHOSTTY_DIR}/config"

ensure_dir "${HOME}/.ssh"
chmod 700 "${HOME}/.ssh"
restore_file "${HOME}/.ssh/config"

log_ok "Dotfiles restored"
