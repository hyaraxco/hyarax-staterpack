#!/usr/bin/env bash
set -euo pipefail

export HYARAX_DIR
HYARAX_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export DOTFILES_DIR="${HYARAX_DIR}/dotfiles"
export BACKUPS_DIR="${HYARAX_DIR}/backups"
export BREWFILE="${HYARAX_DIR}/Brewfile"

# ── Colors ──────────────────────────────────────────────────────────────────
export R='\033[0;31m'    G='\033[0;32m'    Y='\033[0;33m'
export B='\033[0;34m'    M='\033[0;35m'    C='\033[0;36m'
export W='\033[1;37m'    N='\033[0m'

# ── Logging ─────────────────────────────────────────────────────────────────
log_info()  { printf "${B}[INFO]${N}  %s\n" "$*"; }
log_ok()    { printf "${G}[OK]${N}    %s\n" "$*"; }
log_warn()  { printf "${Y}[WARN]${N}  %s\n" "$*"; }
log_error() { printf "${R}[ERROR]${N} %s\n" "$*"; }
log_step()  { printf "\n${C}══════════════════════════════════════════════════${N}\n${W}  %s${N}\n${C}══════════════════════════════════════════════════${N}\n" "$*"; }
log_sub()   { printf "  ${M}→${N} %s\n" "$*"; }

# ── Helpers ──────────────────────────────────────────────────────────────────
require_sudo() {
  if ! sudo -v &>/dev/null; then
    log_error "Sudo password is required. Run: sudo -v"
    exit 1
  fi
  while true; do sudo -n true; sleep 60; kill -0 "$$" 2>/dev/null || exit; done &
}

is_installed() { command -v "$1" &>/dev/null; }

is_macos() { [[ "$(uname)" == "Darwin" ]]; }

is_apple_silicon() { [[ "$(uname -m)" == "arm64" ]]; }

cmd_exists() { command -v "$1" &>/dev/null; }

ensure_dir() {
  mkdir -p "$1"
}

backup_file() {
  local src="$1"
  local dest="${BACKUPS_DIR}/$(basename "$src")"
  if [[ -f "$src" ]]; then
    if [[ ! -f "$dest" ]]; then
      cp "$src" "$dest"
      log_sub "Backed up $(basename "$src")"
    fi
  fi
}

restore_file() {
  local dest="$1"
  local src="${BACKUPS_DIR}/$(basename "$dest")"
  if [[ -f "$src" ]]; then
    ensure_dir "$(dirname "$dest")"
    cp "$src" "$dest"
    log_sub "Restored $(basename "$dest")"
  else
    log_warn "No backup found for $(basename "$dest")"
  fi
}

append_if_missing() {
  local file="$1" line="$2"
  ensure_dir "$(dirname "$file")"
  touch "$file"
  grep -qxF "$line" "$file" || echo "$line" >> "$file"
}

symlink_dotfile() {
  local src="$1" dest="$2"
  ensure_dir "$(dirname "$dest")"
  if [[ -L "$dest" ]]; then
    local current
    current="$(readlink "$dest")"
    if [[ "$current" == "$src" ]]; then
      return
    fi
    log_warn "Removing existing symlink: $dest"
    rm "$dest"
  elif [[ -f "$dest" ]] && [[ ! -L "$dest" ]]; then
    backup_file "$dest"
    rm "$dest"
  fi
  ln -sf "$src" "$dest"
  log_sub "Symlinked $(basename "$dest")"
}
