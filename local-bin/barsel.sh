#!/bin/bash

OPTIONS="verbose\nisland\nminimal\nnone"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -p "Waybar Mode" \
    -theme-str 'window {width: 250px;}')

[ -z "$CHOICE" ] && exit 0

pkill waybar

case "$CHOICE" in
verbose)
    waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css &
    ;;
island)
    waybar -c ~/.config/waybar/island.jsonc -s ~/.config/waybar/island.css &
    ;;
minimal)
    waybar -c ~/.config/waybar/min.jsonc -s ~/.config/waybar/min.css &
    ;;
none) ;;
esac

echo "$CHOICE" >/tmp/waybar_state
