#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "${HYARAX_DIR}/lib.sh"

# ── Zinit ────────────────────────────────────────────────────────────────────
if [[ ! -d "${HOME}/.local/share/zinit" ]]; then
  log_info "Installing Zinit..."
  bash -c "$(curl --fail --show-error --silent --location \
    https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
  log_ok "Zinit installed"
else
  log_ok "Zinit already installed"
fi

# ── Starship ─────────────────────────────────────────────────────────────────
# Starship is installed via Brewfile, just verify
if cmd_exists starship; then
  log_ok "Starship installed"
else
  log_warn "Starship not found — should be installed via Brewfile"
fi

# ── Ghostty config ───────────────────────────────────────────────────────────
GHOSTTY_DIR="${HOME}/Library/Application Support/com.mitchellh.ghostty"
ensure_dir "${GHOSTTY_DIR}"

GHOSTTY_CONFIG="${GHOSTTY_DIR}/config"
DOTFILE_CONFIG="${DOTFILES_DIR}/ghostty.config"

if [[ ! -f "${GHOSTTY_CONFIG}" ]]; then
  if [[ -f "${DOTFILE_CONFIG}" ]]; then
    symlink_dotfile "${DOTFILE_CONFIG}" "${GHOSTTY_CONFIG}"
    log_ok "Ghostty config deployed from dotfiles"
  else
    cat > "${GHOSTTY_CONFIG}" <<- 'EOF'
theme = "boo"
font-family = "JetBrains Mono"
font-size = 14
window-padding-x = 8
window-padding-y = 4
macos-titlebar-style = "tabs"
background-opacity = 0.95
EOF
    log_ok "Ghostty config created with Boo theme"
  fi
else
  log_ok "Ghostty config already exists"
fi

# ── Boo Theme (Ghostty) ─────────────────────────────────────────────────────
GHOSTTY_THEMES_DIR="${GHOSTTY_DIR}/themes"
BOO_THEME_FILE="${GHOSTTY_THEMES_DIR}/boo"

if [[ ! -f "${BOO_THEME_FILE}" ]]; then
  log_info "Installing Boo theme for Ghostty..."
  ensure_dir "${GHOSTTY_THEMES_DIR}"
  curl -fsSL "https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/ghostty/boo" \
    -o "${BOO_THEME_FILE}" 2>/dev/null || {
    log_warn "Could not download Boo theme; using inline fallback"
    cat > "${BOO_THEME_FILE}" <<- 'EOF'
background = 1a1b26
foreground = a9b1d6
cursor-color = a9b1d6
selection-background = 33467c
selection-foreground = a9b1d6
black = 414868
blue = 7aa2f7
cyan = b4f9f8
green = 9ece6a
magenta = bb9af7
red = f7768e
white = a9b1d6
yellow = e0af68
bright-black = 414868
bright-blue = 7dcfff
bright-cyan = b4f9f8
bright-green = 9ece6a
bright-magenta = bb9af7
bright-red = f7768e
bright-white = c0caf5
bright-yellow = e0af68
EOF
  }
  log_ok "Boo theme installed"
else
  log_ok "Boo theme already installed"
fi

# ── JetBrains Mono (recommended font) ────────────────────────────────────────
if [[ ! -f "${HOME}/Library/Fonts/JetBrainsMono-Regular.ttf" ]]; then
  log_info "Installing JetBrains Mono font..."
  FONT_DIR=$(mktemp -d)
  curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip" \
    -o "${FONT_DIR}/JetBrainsMono.zip"
  unzip -q "${FONT_DIR}/JetBrainsMono.zip" -d "${FONT_DIR}/font" 2>/dev/null
  mkdir -p "${HOME}/Library/Fonts"
  find "${FONT_DIR}/font" -name "*.ttf" -exec cp {} "${HOME}/Library/Fonts/" \;
  rm -rf "${FONT_DIR}"
  log_ok "JetBrains Mono Nerd Font installed"
else
  log_ok "JetBrains Mono font already installed"
fi
