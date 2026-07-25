#!/bin/bash

WALLPAPER_DIR="${HOME}/pics/walls"

if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: Directory $WALLPAPER_DIR does not exist"
    exit 1
fi

WALLPAPER=$(fd -e jpg -e jpeg -e png -e gif -e webp -e bmp -e gif . "$WALLPAPER_DIR" | shuf -n 1)


if [ -z "$WALLPAPER" ]; then
    echo "Error: No image files found in $WALLPAPER_DIR"
    exit 1
fi

echo "$WALLPAPER" >"$HOME/.config/wallpaper"
awww img "$WALLPAPER" --transition-type center --transition-fps 165 &
matugen image "$WALLPAPER" --source-color-index 0 -t scheme-tonal-spot 
sleep 1.5

dunstctl reload

pkill -SIGUSR1 kitty 2>/dev/null
systemctl --user restart xdg-desktop-portal-gtk

killall -SIGUSR2 waybar
pkill -USR2 btop
pkill -USR1 cava
spicetify watch -s 2>&1 | sed "/Reloaded Spotify/q"

dunstify -i ~/.icons/icon_scripts/dunst/misc/walls.svg -a walls "wallpaper changed" "congrats"

