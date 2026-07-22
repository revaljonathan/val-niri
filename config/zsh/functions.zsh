# gacp() {
#   if [ -z "$1" ]; then
#     echo "pls comment bro"
#     return 1
#   fi
#   git add .
#   git commit -m "$1"
#   git push
# }

fuck() { doas $(fc -ln -1) }

take() {
  mkdir -p "$1" && cd "$1"
}

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
      *) echo "me not know format" ;;
    esac
  else
    echo "where file"
  fi
}

gf () {
  info=(
    "\033[1;32mKernel  $(uname -r)\033[0m"
    "\033[1;32m Shell  $SHELL"
    "\033[1;32m  Disk  $(df -B1G --output=size,used / | awk 'NR==2 {print $2 " GiB | " $1 " GiB"}')"
    "\033[0;32m   Upt  $(uptime -p | sed 's/^up //')"
    "\033[0;32m  Host  $(hostname)"
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

# pokemon=(mudkip kyogre xerneas yveltal lunala marshadow rowlet zamazenta miraidon kingambit basculegion falinks pikachu empoleon corviknight gastrodon excadrill armarouge)
# index=$((RANDOM % ${#pokemon[@]} + 1))
# name=${pokemon[$index]}
# krabby name "$name" | sed '1d'

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

weather() {
  curl wttr.in/"$1"
}


