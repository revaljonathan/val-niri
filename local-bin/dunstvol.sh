#!/bin/bash
ACTION=$1
case $ACTION in
up)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    ;;
down)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    ;;
mute)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    ;;
esac

VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -c MUTED)

if [ "$MUTED" -gt 0 ]; then
    MSG="Muted"
    ICON=~/.config/dunst/mute.svg
else
    MSG="$VOLUME%"
    ICON=~/.config/dunst/sound.svg
fi

dunstify -i "$ICON" -a "volume" \
    -h string:x-dunst-stack-tag:volume \
    -h int:value:"$VOLUME" \
    -t 1500 \
    -r 9991 \
    "$MSG"
