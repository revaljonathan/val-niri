eval "$(zoxide init zsh)"
f() { eval $(thefuck $(fc -ln -1)); }

source ~/.zsh/config/completion.zsh
source ~/.zsh/config/binds.zsh
source ~/.zsh/config/theme.zsh
source ~/.zsh/config/options.zsh
source ~/.zsh/config/functions.zsh
source ~/.zsh/config/export.zsh
source ~/.zsh/config/plugins.zsh
source $ZSH/oh-my-zsh.sh
source ~/.zsh/config/alias.zsh
