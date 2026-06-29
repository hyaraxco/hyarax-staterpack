#!/usr/bin/env bash
set -euo pipefail

HYARAX_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "${HYARAX_DIR}/lib.sh"

# ── Android Studio ───────────────────────────────────────────────────────────
ANDROID_STUDIO="/Applications/Android Studio.app"
if [[ -d "${ANDROID_STUDIO}" ]]; then
  log_ok "Android Studio already installed"
else
  log_warn "Android Studio should be installed via Brewfile (cask)"
fi

# ── Android Platform Tools ───────────────────────────────────────────────────
if cmd_exists adb; then
  log_ok "Android Platform Tools installed (adb available)"
else
  log_warn "Android Platform Tools should be installed via Brewfile (cask)"
fi

# ── scrcpy ───────────────────────────────────────────────────────────────────
if cmd_exists scrcpy; then
  log_ok "scrcpy installed"
else
  log_warn "scrcpy should be installed via Brewfile"
fi

# ── Post-install: Android environment variables ──────────────────────────────
ZSHRC="${HOME}/.zshrc"
ANDROID_HOME_LINE='export ANDROID_HOME="${HOME}/Library/Android/sdk"'
ANDROID_PATH_LINE='export PATH="${PATH}:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/cmdline-tools/latest/bin"'

if ! grep -qxF "${ANDROID_HOME_LINE}" "${ZSHRC}" 2>/dev/null; then
  cat >> "${ZSHRC}" <<- 'EOF'

# Android
export ANDROID_HOME="${HOME}/Library/Android/sdk"
export PATH="${PATH}:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/cmdline-tools/latest/bin"
EOF
  log_ok "Android environment variables added to .zshrc"
fi
