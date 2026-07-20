#!/usr/bin/env bash
if ! pgrep wf-recorder >/dev/null; then
dir="$HOME/.config/rofi/record"
COLUMNS=3
THUMB_SIZE=100
TMPFILE=$(mktemp)

fd . "$dir" \
    --max-depth 1 \
    --type f \
    --extension jpg \
    --extension svg > "$TMPFILE"
INDEX=$(
declare -A DESC=(
    ["fullscreen.svg"]="Record screen"
    ["area.svg"]="Record area"
    ["mic.svg"]="Record with mic"
)

cat "$TMPFILE" |
    while read -r filepath; do
        base="$(basename "$filepath")"
        label="${DESC[$base]:-$base}"
        printf '%s\x00icon\x1f%s\n' "$label" "$filepath"
    done |
        rofi \
            -dmenu \
            -i \
            -show-icons \
            -format i \
            -theme-str "
            window {
                width: 700px;
                height: 150px;
                location: north;
                y-offset: 10;
            }
            inputbar {
                enabled: false;
            }
            listview {
                columns: $COLUMNS;
                lines: 1;
                fixed-height: true;
                flow: horizontal;
                spacing: 8px;
            }
            element {
                orientation: vertical;
                padding: 4px;
                border-radius: 0px;
                spacing: 0px;
            }
            element-icon {
                size: ${THUMB_SIZE}px;
                border-radius: 0px;
            }
            element-text {
                padding: 0;
                margin: 0;
            }
            element selected {
                border-radius: 0px;
            }
        "
)

if [[ -z "$INDEX" ]]; then
    rm -f "$TMPFILE"
    exit 0
fi

SELECTED_FILE=$(sed -n "$((INDEX+1))p" "$TMPFILE" 2>/dev/null)
BASENAME=$(basename "$SELECTED_FILE" 2>/dev/null)

FILENAME="$HOME/pics/record/$(date +'%d-%m-%Y_%H:%M').mp4"

if [[ "$BASENAME" == "fullscreen.svg" ]]; then
    wf-recorder -f "$FILENAME" &
    REC_PID=$!
elif [[ "$BASENAME" == "area.svg" ]]; then
    # Get geometry first
    GEOM=$(slurp)
    # If user cancelled slurp, abort gracefully
    if [[ -z "$GEOM" ]]; then
        rm -f "$TMPFILE"
        exit 0
    fi
    wf-recorder -g "$GEOM" -f "$FILENAME" &
    REC_PID=$!
elif [[ "$BASENAME" == "mic.svg" ]]; then
    # Add audio recording flag (--audio) if intended
    wf-recorder --audio -f "$FILENAME" &
    REC_PID=$!
else
    echo "Unknown option selected"
    rm -f "$TMPFILE"
    exit 1
fi

# Signal Waybar that recording started
pkill -SIGRTMIN+9 waybar

# Wait specifically for wf-recorder, not all background jobs
wait "$REC_PID"

# Signal Waybar that recording stopped
pkill -SIGRTMIN+9 waybar

rm -f "$TMPFILE"

else 
    killall wf-recorder
fi
