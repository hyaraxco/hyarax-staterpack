
export PATH="$HOME/.local/bin:$PATH"

# >>> Boo >>>
if [[ -f "$HOME/.config/boo/boo.zsh" ]]; then
  source "$HOME/.config/boo/boo.zsh"
fi
# <<< Boo <<<

# opencode
export PATH=/Users/urfavsincostan/.opencode/bin:$PATH

# bun completions
[ -s "/Users/urfavsincostan/.bun/_bun" ] && source "/Users/urfavsincostan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
