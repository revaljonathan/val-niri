#!/usr/bin/env bash

PREDEFINED=(
    "github"
    "Wikipedia"
    "Youtube"
    "Arch Wiki"
    "Deepseek"
    "GPT"
    "Claude"
    "Gemini"
)

CHOICE=$(printf '%s\n' "${PREDEFINED[@]}" | rofi \
    -dmenu \
    -p "Search" \
    -i \
    -theme-str '
    window {width: 350px;}
    listview {
        columns: 2;
        lines: 6;
    }
    ' \
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
"GPT"*) brave "https://chatgpt.com/" ;;
"Claude"*) brave "https://claude.ai/new" ;;
"Gemini"*) brave "https://gemini.google.com/app" ;;
*) brave "https://www.google.com/search?q=$(urlencode "$CHOICE")" ;;
esac
