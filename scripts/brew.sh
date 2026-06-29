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
  brew bundle --file="${BREWFILE}" --no-lock
  log_ok "Brew bundle installed"
fi

# ── Post-install: OpenJDK symlink ────────────────────────────────────────────
if cmd_exists java; then
  log_ok "Java already available"
else
  # Homebrew's openjdk is keg-only; symlink it
  if [[ -d "/opt/homebrew/opt/openjdk/bin" ]]; then
    sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk \
      /Library/Java/JavaVirtualMachines/openjdk.jdk
    for cmd in java javac jar; do
      if [[ -f "/opt/homebrew/opt/openjdk/bin/${cmd}" ]] && ! cmd_exists "${cmd}"; then
        sudo ln -sf "/opt/homebrew/opt/openjdk/bin/${cmd}" "/usr/local/bin/${cmd}"
      fi
    done
    log_ok "OpenJDK symlinked"
  fi
fi

# ── fzf post-install ─────────────────────────────────────────────────────────
if cmd_exists fzf; then
  FZF_DIR="$(brew --prefix)/opt/fzf"
  if [[ -f "${FZF_DIR}/install" ]] && [[ ! -f "${HOME}/.fzf.zsh" ]]; then
    "${FZF_DIR}/install" --no-bash --no-fish --key-bindings --completion --update-rc 2>/dev/null || true
    log_ok "fzf shell integration configured"
  fi
fi
