#!/usr/bin/env bash
dir="$HOME/.icons/icon_scripts/rofi/screenshot"
COLUMNS=3
THUMB_SIZE=100
TMPFILE=$(mktemp)

fd . "$dir" \
    --max-depth 1 \
    --type f \
    --extension svg > "$TMPFILE"
INDEX=$(
declare -A DESC=(
    ["window.svg"]="  Screenshot Window"
    ["screen.svg"]="  Screenshot whole"
    ["selection.svg"]=" Screenshot Selection"
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
                width: 35%;
                height: 13%;
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

if [[ "$BASENAME" == "window.svg" ]]; then
    niri msg action screenshot-window
elif [[ "$BASENAME" == "screen.svg" ]]; then
    niri msg action screenshot-screen
elif [[ "$BASENAME" == "selection.svg" ]]; then
    niri msg action screenshot
else
    echo "Unknown option selected"
fi

rm -f "$TMPFILE"
