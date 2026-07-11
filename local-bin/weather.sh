#!/usr/bin/env bash
desc=$(curl -s -m 5 "wttr.in/semarang?format=%C")
temp=$(curl -s -m 5 "wttr.in/semarang?format=%t" | sed 's/+//')

ICON_DIR="$HOME/.config/dunst"  # Change this to your actual icon directory

case "${desc,,}" in
    *sun*|*clear*)
        icon_text="󰖙"
        svg_icon="$ICON_DIR/sun.svg"
        ;;
    *cloud*)
        icon_text="󰖐"
        svg_icon="$ICON_DIR/cloudy.svg"
        ;;
    *rain*|*drizzle*)
        icon_text="󰖗"
        svg_icon="$ICON_DIR/rainy.svg"
        ;;
    *thunder*)
        icon_text="󰖓"
        svg_icon="$ICON_DIR/thunder.svg"
        ;;
    *fog*|*mist*)
        icon_text="󰖑"
        svg_icon="$ICON_DIR/fog.svg"
        ;;
    *)
        icon_text="󰖕"
        svg_icon="$ICON_DIR/edgecase.svg"
        ;;
esac

dunstify -a weather -i "$svg_icon" "$icon_text $temp" "$desc"
