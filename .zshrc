eval "$(zoxide init zsh)"
f() { eval $(thefuck $(fc -ln -1)); }

ZSH_CONFIG="$HOME/.config/zsh"

source "$ZSH_CONFIG/completion.zsh"
source "$ZSH_CONFIG/binds.zsh"
source "$ZSH_CONFIG/theme.zsh"
source "$ZSH_CONFIG/options.zsh"
source "$ZSH_CONFIG/functions.zsh"
source "$ZSH_CONFIG/export.zsh"
source "$ZSH_CONFIG/plugins.zsh"
source "$ZSH/oh-my-zsh.sh"
source "$ZSH_CONFIG/alias.zsh"
