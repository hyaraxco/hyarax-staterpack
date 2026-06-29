#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "${HYARAX_DIR}/lib.sh"

# ── Install Homebrew ─────────────────────────────────────────────────────────
if ! cmd_exists brew; then
  log_info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  log_ok "Homebrew installed"
else
  log_ok "Homebrew already installed"
fi

# ── Install Brew bundle ──────────────────────────────────────────────────────
if [[ -f "${BREWFILE}" ]]; then
  log_info "Installing Brew bundle..."
  brew bundle --file="${BREWFILE}"
  log_ok "Brew bundle installed"
fi

# ── Post-install: OpenJDK symlink ────────────────────────────────────────────
if cmd_exists java; then
  log_ok "Java already available"
elif [[ -d "/opt/homebrew/opt/openjdk/bin" ]]; then
  export PATH="/opt/homebrew/opt/openjdk/bin:${PATH}"
  export JAVA_HOME="/opt/homebrew/opt/openjdk"
  log_ok "OpenJDK configured via PATH"
fi

# Ensure java is accessible for the rest of the install
JAVA_LINE='export PATH="/opt/homebrew/opt/openjdk/bin:${PATH}"'
append_if_missing "${HOME}/.zshrc" "${JAVA_LINE}"
JAVA_HOME_LINE='export JAVA_HOME="/opt/homebrew/opt/openjdk"'
append_if_missing "${HOME}/.zshrc" "${JAVA_HOME_LINE}"

# ── fzf post-install ─────────────────────────────────────────────────────────
if cmd_exists fzf; then
  FZF_DIR="$(brew --prefix)/opt/fzf"
  if [[ -f "${FZF_DIR}/install" ]] && [[ ! -f "${HOME}/.fzf.zsh" ]]; then
    "${FZF_DIR}/install" --no-bash --no-fish --key-bindings --completion --update-rc 2>/dev/null || true
    log_ok "fzf shell integration configured"
  fi
fi
