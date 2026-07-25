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
    "Dodgers"
)

CHOICE=$(printf '%s\n' "${PREDEFINED[@]}" | rofi \
    -dmenu \
    -p "Browse" \
    -i \
    -no-show-icon \
    -theme-str '
    window {width: 17%;}
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
*github*) helium-browser "https://github.com" ;;
"Wikipedia"*) helium-browser "https://en.wikipedia.org/wiki/Main_Page" ;;
"Youtube"*) helium-browser "https://www.youtube.com/" ;;
"Arch Wiki"*) helium-browser "https://wiki.archlinux.org/title/Main_page" ;;
"Deepseek"*) helium-browser "https://chat.deepseek.com/" ;;
"GPT"*) helium-browser "https://chatgpt.com/" ;;
"Claude"*) helium-browser "https://claude.ai/new" ;;
"Gemini"*) helium-browser "https://gemini.google.com/app" ;;
"Dodgers"*) helium-browser "https://www.google.com/search?q=dodgers" ;;
*) helium-browser "https://www.google.com/search?q=$(urlencode "$CHOICE")" ;;
esac
