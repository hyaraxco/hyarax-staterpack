#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${HYARAX_DIR}/lib.sh"

log_step "Restore — Applying Dotfiles"

# ── Shell ────────────────────────────────────────────────────────────────────
restore_file "${HOME}/.zshrc"
restore_file "${HOME}/.gitconfig"
restore_file "${HOME}/.gitignore_global"

# ── Starship ─────────────────────────────────────────────────────────────────
ensure_dir "${HOME}/.config"
restore_file "${HOME}/.config/starship.toml"

# ── Ghostty ──────────────────────────────────────────────────────────────────
GHOSTTY_DIR="${HOME}/Library/Application Support/com.mitchellh.ghostty"
ensure_dir "${GHOSTTY_DIR}"
restore_file "${GHOSTTY_DIR}/config"

# ── SSH ──────────────────────────────────────────────────────────────────────
ensure_dir "${HOME}/.ssh"
chmod 700 "${HOME}/.ssh"
restore_file "${HOME}/.ssh/config"

# ── Dotfiles from repo (if no backup, deploy fresh) ─────────────────────────
deploy_dotfile() {
  local src="$1" dest="$2"
  if [[ -f "$src" ]] && [[ ! -f "$dest" ]]; then
    symlink_dotfile "$src" "$dest"
  fi
}

deploy_dotfile "${DOTFILES_DIR}/.zshrc" "${HOME}/.zshrc"
deploy_dotfile "${DOTFILES_DIR}/.gitconfig" "${HOME}/.gitconfig"
deploy_dotfile "${DOTFILES_DIR}/.gitignore_global" "${HOME}/.gitignore_global"
deploy_dotfile "${DOTFILES_DIR}/starship.toml" "${HOME}/.config/starship.toml"

# Ghostty config from dotfiles
GHOSTTY_CONFIG="${HOME}/Library/Application Support/com.mitchellh.ghostty/config"
deploy_dotfile "${DOTFILES_DIR}/ghostty.config" "${GHOSTTY_CONFIG}"

log_ok "Dotfiles restored"
