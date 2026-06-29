#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${HYARAX_DIR}/lib.sh"

log_step "Backup — Saving Existing Configurations"

ensure_dir "${BACKUPS_DIR}"

backup_file "${HOME}/.zshrc"
backup_file "${HOME}/.gitconfig"
backup_file "${HOME}/.gitignore_global"

if [[ -f "${HOME}/.config/starship.toml" ]]; then
  backup_file "${HOME}/.config/starship.toml"
fi

GHOSTTY_CONFIG="${HOME}/Library/Application Support/com.mitchellh.ghostty/config"
if [[ -f "$GHOSTTY_CONFIG" ]]; then
  backup_file "$GHOSTTY_CONFIG"
fi

if [[ -f "${HOME}/.ssh/config" ]]; then
  backup_file "${HOME}/.ssh/config"
fi

if [[ -f "${BREWFILE}" ]]; then
  cp "${BREWFILE}" "${BACKUPS_DIR}/Brewfile.system"
  log_sub "Backed up current Brewfile"
fi

log_ok "Backup complete — stored in ${BACKUPS_DIR}"
ls -la "${BACKUPS_DIR}"
