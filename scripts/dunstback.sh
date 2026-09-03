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

quickshell ipc call osd setBrightness "$PERCENT"
