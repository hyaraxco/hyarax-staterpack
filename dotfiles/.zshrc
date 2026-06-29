export PATH="$HOME/.local/bin:$PATH"

# >>> Boo >>>
if [[ -f "$HOME/.config/boo/boo.zsh" ]]; then
  source "$HOME/.config/boo/boo.zsh"
fi
# <<< Boo <<<

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ── Hyarax Starterpack ─────────────────────────────────────────────────────

# ── Zinit ─────────────────────────────────────────────────────────────────────
ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"
if [[ -f "${ZINIT_HOME}/zinit.zsh" ]]; then
  source "${ZINIT_HOME}/zinit.zsh"

  zinit light zsh-users/zsh-autosuggestions
  zinit light zdharma-continuum/fast-syntax-highlighting
  zinit light zsh-users/zsh-completions

  zinit ice as"completion"
  zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
fi

# ── fzf ───────────────────────────────────────────────────────────────────────
if [[ -f "/opt/homebrew/opt/fzf/shell/completion.zsh" ]]; then
  source /opt/homebrew/opt/fzf/shell/completion.zsh 2>/dev/null || true
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh 2>/dev/null || true
fi

# ── zoxide ────────────────────────────────────────────────────────────────────
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# ── atuin ─────────────────────────────────────────────────────────────────────
if command -v atuin &>/dev/null; then
  eval "$(atuin init zsh)"
fi

# ── thefuck ───────────────────────────────────────────────────────────────────
if command -v thefuck &>/dev/null; then
  eval "$(thefuck --alias)"
fi

# ── Java ──────────────────────────────────────────────────────────────────────
if [[ -d "/opt/homebrew/opt/openjdk/bin" ]]; then
  export PATH="/opt/homebrew/opt/openjdk/bin:${PATH}"
  export JAVA_HOME="/opt/homebrew/opt/openjdk"
fi

# ── Android ───────────────────────────────────────────────────────────────────
export ANDROID_HOME="${HOME}/Library/Android/sdk"
export PATH="${PATH}:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/cmdline-tools/latest/bin"

# ── Aliases ───────────────────────────────────────────────────────────────────
alias ls="eza --icons=auto"
alias ll="eza -la --icons=auto"
alias lt="eza -la --icons=auto --sort=time"
alias cat="bat"
alias grep="rg"
alias find="fd"
alias tree="tree -C"

# ── Editor ────────────────────────────────────────────────────────────────────
export EDITOR="code -w"
export VISUAL="code -w"

# ── GPG ───────────────────────────────────────────────────────────────────────
export GPG_TTY="$(tty)"

# ── Prompt ────────────────────────────────────────────────────────────────────
setopt PROMPT_SUBST

# bun completions (load after prompt)
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
