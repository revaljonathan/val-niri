#!/bin/bash

OPTIONS="main\nsmol"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -p "Waybar Mode" \
    -theme-str 'window {width: 250px;}')

[ -z "$CHOICE" ] && exit 0

pkill waybar

case "$CHOICE" in
main)
    waybar -c ~/.config/waybar/main.jsonc -s ~/.config/waybar/main.css &
    ;;
smol)
    waybar -c ~/.config/waybar/smol.jsonc -s ~/.config/waybar/smol.css &
    ;;
none) ;;
esac

