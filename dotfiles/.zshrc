# ── Hyarax Starterpack .zshrc ─────────────────────────────────────────────────
# Managed by Hyarax — do not edit manually

# ── Paths ─────────────────────────────────────────────────────────────────────
typeset -U PATH path
path=(
  /opt/homebrew/bin
  /opt/homebrew/sbin
  "${HOME}/.bun/bin"
  "${HOME}/.local/bin"
  "${HOME}/.cargo/bin"
  "${HOME}/go/bin"
  /usr/local/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
)

# ── Zinit ─────────────────────────────────────────────────────────────────────
ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"
if [[ -f "${ZINIT_HOME}/zinit.zsh" ]]; then
  source "${ZINIT_HOME}/zinit.zsh"

  zinit ice depth=1
  zinit light romkatv/powerlevel10k

  zinit light zdharma-continuum/zsh-autosuggestions
  zinit light zdharma-continuum/fast-syntax-highlighting
  zinit light zdharma-continuum/zsh-completions

  zinit ice as"completion"
  zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
fi

# ── Starship ──────────────────────────────────────────────────────────────────
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# ── fzf ───────────────────────────────────────────────────────────────────────
if command -v fzf &>/dev/null; then
  source <(fzf --zsh) 2>/dev/null || source /opt/homebrew/opt/fzf/shell/completion.zsh 2>/dev/null || true
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

# ── Bun ───────────────────────────────────────────────────────────────────────
if [[ -d "${HOME}/.bun/bin" ]]; then
  export BUN_INSTALL="${HOME}/.bun"
fi

# ── Android ───────────────────────────────────────────────────────────────────
export ANDROID_HOME="${HOME}/Library/Android/sdk"
path+=("${ANDROID_HOME}/platform-tools" "${ANDROID_HOME}/cmdline-tools/latest/bin")

# ── Aliases ───────────────────────────────────────────────────────────────────
alias ls="eza --icons=auto"
alias ll="eza -la --icons=auto"
alias lt="eza -la --icons=auto --sort=time"
alias cat="bat"
alias grep="rg"
alias find="fd"
alias tree="tree -C"
alias git="lazygit"
alias docker="lazydocker"

# ── Editor ────────────────────────────────────────────────────────────────────
export EDITOR="code -w"
export VISUAL="code -w"

# ── GPG ───────────────────────────────────────────────────────────────────────
export GPG_TTY="$(tty)"

# ── Prompt ────────────────────────────────────────────────────────────────────
setopt PROMPT_SUBST
