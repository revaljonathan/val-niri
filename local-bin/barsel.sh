#!/bin/bash

OPTIONS="main\nminimalist\nvertical\nnone"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -p "Waybar Mode" \
    -theme-str 'window {width: 250px;}')

[ -z "$CHOICE" ] && exit 0

pkill waybar

case "$CHOICE" in
main)
    waybar -c ~/.config/waybar/main.jsonc -s ~/.config/waybar/main.css &
    ;;
minimalist)
    waybar -c ~/.config/waybar/minimal.jsonc -s ~/.config/waybar/minimal.css &
    ;;
vertical)
    waybar -c ~/.config/waybar/vertical.jsonc -s ~/.config/waybar/vertical.css &
    ;;
none) ;;
esac

echo "$CHOICE" >/tmp/waybar_state
