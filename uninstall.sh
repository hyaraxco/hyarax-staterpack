#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${HYARAX_DIR}/lib.sh"

log_step "Uninstall — Removing Managed Configurations"
log_warn "This will NOT uninstall Homebrew packages."
log_warn "It only removes configurations managed by Hyarax."

files_to_remove=(
  "${HOME}/.zshrc"
  "${HOME}/.gitconfig"
  "${HOME}/.gitignore_global"
  "${HOME}/.config/starship.toml"
  "${HOME}/Library/Application Support/com.mitchellh.ghostty/config"
)

for f in "${files_to_remove[@]}"; do
  if [[ -L "$f" ]]; then
    rm "$f"
    log_sub "Removed symlink: $f"
  elif [[ -f "$f" ]] && [[ -f "${BACKUPS_DIR}/$(basename "$f")" ]]; then
    log_warn "Skipping $f — backup exists. Run restore to recover."
  fi
done

# Uninstall Zinit if installed
if [[ -d "${HOME}/.local/share/zinit" ]]; then
  rm -rf "${HOME}/.local/share/zinit"
  log_sub "Removed Zinit"
fi

log_ok "Uninstall complete"
log_info "To remove Homebrew packages, run: brew bundle cleanup --file=${BREWFILE}"
