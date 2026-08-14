#!/bin/bash
ACTION=$1 # up | down

case $ACTION in
up)
    brightnessctl set 5%+
    ;;
down)
    brightnessctl set 5%-
    ;;
esac

BRIGHTNESS=$(brightnessctl get)
MAX=$(brightnessctl max)
PERCENT=$((BRIGHTNESS * 100 / MAX))

pkill -sigrtmin+19 waybar

dunstify -i ~/.icons/icon_scripts/dunst/bright_osd/brightness.svg -a "brightness" \
    -h string:x-dunst-stack-tag:brightness \
    -h int:value:"$PERCENT" \
    -t 1500 \
    -r 9992 \
    "$PERCENT%"
