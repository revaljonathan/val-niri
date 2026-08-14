#!/bin/bash

OPTIONS="main\nsmol\nnuke"

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
nuke)
    waybar -c ~/.config/waybar/nuke.jsonc -s ~/.config/waybar/nuke.css &
    ;;
none) ;;
esac

