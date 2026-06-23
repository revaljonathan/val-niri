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

dunstify -i ~/.config/dunst/brightness.svg -a "brightness" \
    -h string:x-dunst-stack-tag:brightness \
    -h int:value:"$PERCENT" \
    -t 1500 \
    -r 9992 \
    "$PERCENT%"
