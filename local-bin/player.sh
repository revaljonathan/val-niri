#!/usr/bin/env bash
dir="$HOME/.config/rofi/player"
COLUMNS=1
THUMB_SIZE=100
TMPFILE=$(mktemp)

find "$dir" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.svg" \) >"$TMPFILE"

ORDERED_FILES=$(mktemp)
for file in "back.svg" "pause.svg" "next.svg"; do
    if [ -f "$dir/$file" ]; then
        echo "$dir/$file" >> "$ORDERED_FILES"
    fi
done

while read -r file; do
    basename=$(basename "$file")
    if [[ "$basename" != "back.svg" && "$basename" != "pause.svg" && "$basename" != "next.svg" ]]; then
        echo "$file" >> "$ORDERED_FILES"
    fi
done < "$TMPFILE"

INDEX=$(
cat "$ORDERED_FILES" |
    while read -r filepath; do
        base="$(basename "$filepath")"
        printf '%s\x00icon\x1f%s\n' "$label" "$filepath"
    done |
        rofi \
            -dmenu \
            -i \
            -show-icons \
            -format i \
            -theme-str "
            window {
                location: east;
                width: 170px;
                height: 425px;
                x-offset: -10;
            }
            inputbar {
                enabled: false;
            }
            listview {
                columns: $COLUMNS;
                lines: 3;
                fixed-height: true;
                flow: vertical;
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
                font: \"Sans 0\";
                padding: 0;
                margin: 0;
            }
            element selected {
                border-radius: 0px;
            }
        "
)

if [[ -z "$INDEX" ]]; then
    rm -f "$TMPFILE" "$ORDERED_FILES"
    exit 0
fi

SELECTED_FILE=$(sed -n "$((INDEX+1))p" "$ORDERED_FILES" 2>/dev/null)
BASENAME=$(basename "$SELECTED_FILE" 2>/dev/null)

if [[ "$BASENAME" == "pause.svg" ]]; then
    playerctl play-pause
    STATUS=$(playerctl status 2>/dev/null)
    if [[ "$STATUS" == "Playing" ]]; then
        dunstify -i "$HOME/.config/rofi/player/pause.svg" -t 5000 "Player" "Paused" -a player
    elif [[ "$STATUS" == "Paused" ]]; then
        dunstify -i "$HOME/.config/rofi/player/pause.svg" -t 5000 "Player" "Playing" -a player 
    else
        dunstify -i "$HOME/.config/rofi/player/pause.svg" -t 5000 "Player" "Toggled play/pause" -a player
    fi
elif [[ "$BASENAME" == "next.svg" ]]; then
    OLD_TITLE=$(playerctl metadata title 2>/dev/null)
    playerctl next

    ARTIST=""
    TITLE=""
    for i in 1 2 3 4 5 6 7 8 9 10; do
        sleep 0.1
        TITLE=$(playerctl metadata title 2>/dev/null)
        ARTIST=$(playerctl metadata artist 2>/dev/null)
        if [[ -n "$TITLE" && "$TITLE" != "$OLD_TITLE" ]]; then
            break
        fi
    done

    if [[ -n "$ARTIST" && -n "$TITLE" ]]; then
        dunstify -i "$HOME/.config/dunst/next.svg" -t 5000 "Next Track" "$ARTIST - $TITLE" -a player
    elif [[ -n "$TITLE" ]]; then
        dunstify -i "$HOME/.config/dunst/next.svg" -t 5000 "Next Track" "$TITLE" -a player
    else
        dunstify -i "$HOME/.config/dunst/next.svg" -t 5000 "Player" "Skipped to next track" -a player
    fi
elif [[ "$BASENAME" == "back.svg" ]]; then
    OLD_TITLE=$(playerctl metadata title 2>/dev/null)
    playerctl previous

    ARTIST=""
    TITLE=""
    for i in 1 2 3 4 5 6 7 8 9 10; do
        sleep 0.1
        TITLE=$(playerctl metadata title 2>/dev/null)
        ARTIST=$(playerctl metadata artist 2>/dev/null)
        if [[ -n "$TITLE" && "$TITLE" != "$OLD_TITLE" ]]; then
            break
        fi
    done

    if [[ -n "$ARTIST" && -n "$TITLE" ]]; then
        dunstify -i "$HOME/.config/dunst/back.svg" -t 5000 "Previous Track" "$ARTIST - $TITLE" -a player
    elif [[ -n "$TITLE" ]]; then
        dunstify -i "$HOME/.config/dunst/back.svg" -t 5000 "Previous Track" "$TITLE" -a player
    else
        dunstify -i "$HOME/.config/dunst/back.svg" -t 5000 "Player" "Went to previous track" -a player
    fi
else
    echo "Unknown option selected"
fi

rm -f "$TMPFILE" "$ORDERED_FILES"
