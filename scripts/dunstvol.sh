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

quickshell ipc call osd setVolume "$VOLUME" "$MUTED"
