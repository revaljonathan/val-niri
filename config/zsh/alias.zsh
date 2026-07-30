alias sudo='doas'
# alias up='yay --diffmenu --answerdiff All --save -Syu'
alias up='yay -Syu'
alias clean='paccache -rk 1 && yay -Yc'
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
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'


alias nano='micro'
alias vim='nvim'
alias nv='nvim'
alias mic='micro'

alias see='bat'
alias clipwipe='rm ~/.cache/cliphist/db'
alias view='gwenview'
alias zat='zathura'
alias find='fd'


alias docs='cd Documents'
alias rice='cd Rice'
alias uni='cd uniStuff'
alias dl='cd Downloads'
alias sz='du -sh * | sort -h'
alias y='yazi'
unalias ls
alias ls='eza --sort=modified --reverse --color=always --icons --git --group-directories-first'
alias lc='ls -l'
alias la='lc -A'
alias lsa='lc -G'
alias lt='ls -T'
alias rm='rm -I'
alias tp='trashy put'
alias tl='trashy list'
alias te='trashy empty'
alias tr='trashy restore'
alias x='exit'
alias c='clear'
alias cd='z'

alias color='color_check'
alias grep='rg --color=auto --line-number --smart-case'

alias clock='tty-clock -s -c -C 4'
alias ff='fastfetch'
alias dw='dysk'

alias aq='asciiquarium'
alias pokrand='krabby random | sed '1d''
alias plis='sudo'
alias drizzle='python3 ~/.local/bin/drizzle.py'

