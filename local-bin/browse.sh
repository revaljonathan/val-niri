#!/usr/bin/env bash

PREDEFINED=(
    "github.com"
    "Wikipedia"
    "Youtube"
    "Arch Wiki "
    "Deepseek"
)

CHOICE=$(printf '%s\n' "${PREDEFINED[@]}" | rofi \
    -dmenu \
    -columns 2 \
    -lines 4 \
    -p "Search" \
    -theme-str 'window {width: 350px;}' \
    -i \
    -kb-accept-entry "Return")

[ -z "$CHOICE" ] && exit 0

urlencode() {
    python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$1"
}

case "$CHOICE" in
*github*) brave "https://github.com" ;;
"Wikipedia"*) brave "https://en.wikipedia.org/wiki/Main_Page" ;;
"Youtube"*) brave "https://www.youtube.com/" ;;
"Arch Wiki"*) brave "https://wiki.archlinux.org/title/Main_page" ;;
"Deepseek"*) brave "https://chat.deepseek.com/" ;;
*) brave "https://www.google.com/search?q=$(urlencode "$CHOICE")" ;;
esac
