#!/bin/bash

# Get volume and mute state
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
muted=$(echo "$volume" | grep -q "MUTED" && echo "yes" || echo "no")
vol_percent=$(echo "$volume" | awk '{print $2}')

# If muted, set volume to 0 for display purposes
if [ "$muted" = "yes" ]; then
    percent=0
else
    percent=$(awk "BEGIN {printf \"%.0f\", $vol_percent * 100}")
fi

blocks=10
filled=$(( (percent * blocks + 50) / 100 ))
empty=$(( blocks - filled ))

bar=$(printf '█%.0s' $(seq 1 $filled))
bar+=$(printf '░%.0s' $(seq 1 $empty))

if [ "$muted" = "yes" ]; then
    echo " [$bar] MUTED"
else
    echo " [$bar] $percent%"
fi
