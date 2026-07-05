alias up='yay --diffmenu --answerdiff All --save -Syu'
alias clean='yay -Yc'
alias pacnews='arch_news_check'
alias upgrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias zshnew='source ~/.zshrc'
alias locai='ollama serve && ollama'
alias pw='pass.py'
alias mount_ssd='sudo mount -t ntfs3 UUID=662C415F2C412B7F ~/media/ssd'
alias unmount_ssd='sudo umount ~/media/ssd'

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
alias lc='eza -l -h --sort=modified --reverse --color=always --icons --git --group-directories-first'
alias la='ls -A'
alias lsa='la -G'
alias lt='ls -T'
alias rm='rm -I'
alias x='exit'
alias c='clear'
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

alias clock='tty-clock -s -c -C 5'
alias ff='fastfetch'
alias dw='dysk'

alias aq='asciiquarium'
alias pokrand='krabby random | sed '1d''
alias pipes='pipes.sh'
alias q='fortune | cowsay -r'
alias plis='sudo'
alias drizzle='python3 ~/.local/bin/drizzle.py'

