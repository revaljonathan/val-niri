#!/bin/bash
ASSETS="$HOME/.config/quickshell/notification/assets"
TEMP_ICON="/tmp/media-art-$$.jpg"
trap "rm -f '$TEMP_ICON'" EXIT INT TERM

DEBOUNCE=0.6
LAST_TITLE=""
PENDING_PID=""

show_notification() {
    local TITLE="$1" ARTIST="$2" ART="$3"

    if [[ "$ART" == https://* ]]; then
        curl -sf --max-time 3 -o "$TEMP_ICON" "$ART" && ICON="$TEMP_ICON" || ICON="$ASSETS/media.svg"
    elif [[ "$ART" == file://* ]]; then
        ICON="${ART#file://}"
    else
        ICON="$ASSETS/media.svg"
    fi

    notify-send -a "media" -i "$ICON" -t 5000 "$TITLE" "by $ARTIST"
}

playerctl --follow metadata --format "{{title}}|{{artist}}|{{mpris:artUrl}}" |
while IFS='|' read -r TITLE ARTIST ART; do
    [[ -z "$TITLE" ]] && continue

    [[ -n "$PENDING_PID" ]] && kill "$PENDING_PID" 2>/dev/null

    (
        sleep "$DEBOUNCE"
        show_notification "$TITLE" "$ARTIST" "$ART"
    ) &
    PENDING_PID=$!
done
