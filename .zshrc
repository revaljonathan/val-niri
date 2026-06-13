gf () {
  info=(
    "\033[1;35mKernel  $(uname -r)\033[0m"
    "\033[1;36m Shell  $SHELL"
    "\033[1;34m  Disk  $(df -B1G --output=size,used / | awk 'NR==2 {print $2 " GiB | " $1 " GiB"}')"
    "\033[0;32m   Upt  $(uptime -p | sed 's/^up //')"
    "\033[0;33m  Host  $(hostname)"
    "\033[0;33m  󰮯 \033[0;31m 󰊠 \033[0;32m 󰊠 \033[0;33m 󰊠 \033[0;34m 󰊠 \033[0;35m 󰊠 \033[0;36m 󰊠 \033[0;37m 󰊠  "
    ""
  )
  sprite=(
    " \033[33m   /\_/\  \033[0m  "
    " \033[33m  ( •⩊• ) \033[0m  "
    " \033[33m   > \033[31m^ \033[33m<  \033[0m  "
    " \033[33m  /|   |\ \033[0m  "
    " \033[33m (_|   |_)\033[0m  "
    "             "
    "                    "
  )
  local max=${#info[@]}
  for (( i=0; i<max; i++ )); do
    printf "${sprite[$i]}  ${info[$i]}\n"
  done
}

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


export GTK_THEME=adw-gtk3-dark
export LS_COLORS=""
export BAT_THEME="Catppuccin Mocha"
export "MICRO_TRUECOLOR=1"
export EZA_CONFIG_DIR="$HOME/.config/eza/"
export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=kitty
export CLIPHIST_MAX_ITEMS=100


export PATH="$HOME/.cargo/bin:$PATH"
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:/home/reval/.spicetify

bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history


setopt auto_cd
setopt interactive_comments
setopt multios
setopt histexpand

arch_news_check() {
    echo "🔔 Latest Arch Linux news:"
    curl -s https://archlinux.org/news/ \
      | grep -Eo 'href="/news/[^"]+"' \
      | cut -d'"' -f2 \
      | head -n 5 \
      | sed 's|^|https://archlinux.org|'
}

color_check() {
for i in {0..255}; do
        printf "\e[48;5;%sm%3d " "$i" "$i"
    if (( (i + 1) % 16 == 0 )); then
        printf "\e[0m\n"
    fi
done
}


export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    zsh-autosuggestions
    sudo
    zsh-syntax-highlighting
)

skip_global_compinit=1                          
autoload -Uz compinit 
if [[ -n /tmp/zcompdump-$USER(#qN.mh+24) ]]; then
  compinit -d /tmp/zcompdump-$USER
else
  compinit -C -d /tmp/zcompdump-$USER
fi

source $ZSH/oh-my-zsh.sh

zstyle ':completion:*' menu select
setopt AUTO_MENU
unsetopt MENU_COMPLETE

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

alias up='paru -Syu'
alias clean='sudo paccache -rk2 && paru -c'
alias pacnews='arch_news_check'
alias upgrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias zshnew='source ~/.zshrc'
alias gmn='npx @google/gemini-cli'
alias yay='paru'
alias pacget='paru -Sl | awk "{print \$2}" | fzf --multi --preview "paru -Si {1}" | xargs -ro paru -S'
alias pw='pass.py'

alias sn='shutdown now'
alias sp='systemctl suspend'
alias rb='reboot'

alias turbon='echo 0 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo && sleep 1 && checktur'
alias turboff='echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo && sleep 1 && checktur'
alias checktur='echo "Turbo boost: $(if [ $(cat /sys/devices/system/cpu/intel_pstate/no_turbo) -eq 0 ]; then echo "ON"; else echo "OFF"; fi)"'
alias fan="watch -n 1 'sensors | grep fan'"

alias gs='la && git status'
gacp() {
  if [ -z "$1" ]; then
    echo "isi commit message dulu njinggs"
    return 1
  fi
  git add .
  git commit -m "$1"
  git push
}

alias nano='micro'
alias vim='nvim'
alias nv='nvim'
alias mic='micro'
alias code='visual-studio-code-electron'

alias see='bat'
alias clipwipe='rm ~/.cache/cliphist/db'
alias view='gwenview'
alias zat='zathura'
take() {
  mkdir -p "$1" && cd "$1"
}


alias docs='cd Documents'
alias rice='cd Rice'
alias uni='cd uniStuff'
alias dl='cd Downloads'
alias sz='du -sh * | sort -h'
alias y='yazi'
unalias ls
alias ls='eza -h --sort=modified --reverse --color=always --icons --git --group-directories-first'
alias lss='eza -h --sort=modified --reverse --color=always --icons --git --group-directories-first -G'
alias la='ls -A'
alias lsa='la -G'
alias lt='ls -T'
alias rm='rm -I'
alias x='exit'
alias c='clear'
alias lc='ls -s Extension'
alias cd='z'

alias color='color_check'
alias grep='rg --color=auto --line-number --smart-case'

fuck() { sudo $(fc -ln -1) }
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.rar)     unrar x "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.tbz2)    tar xjf "$1" ;;
      *.tgz)     tar xzf "$1" ;;
      *.zip)     unzip "$1" ;;
      *) echo "Format tolol." ;;
    esac
  else
    echo "mana filenya su."
  fi
}

alias morefetch='fastfetch -c ~/.config/fastfetch/morefetch.jsonc'
alias clock='tty-clock -s -c -C 5'
alias ff='fastfetch'
alias ffm='fastfetch -c examples/13.jsonc'
alias dw='dysk'

alias aq='asciiquarium'
alias poke='krabby random | sed '1d''
alias pipes='pipes.sh'
alias q='fortune | cowsay -r'
alias plis='sudo'
weather() {
  curl wttr.in/"$1"
}
alias udanraksu='weather semarang'

eval "$(zoxide init zsh)"
f() { eval $(thefuck $(fc -ln -1)); }

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
