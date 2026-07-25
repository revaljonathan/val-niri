#!/usr/bin/env bash

if pgrep -x wf-recorder >/dev/null; then
    killall wf-recorder
    dunstify "Recording stopped" "Saved to ~/pics/record/"
    exit 0
fi

icon_dir="$HOME/.icons/icon_scripts/rofi/record"
COLUMNS=3
THUMB_SIZE=100

declare -A DESC=(
    [fullscreen]="   Record screen"
    [area]="    Record area"
    [mic]="  Record with mic"
)

MODE=$(
    for key in fullscreen area mic; do
        printf '%s\x00icon\x1f%s\n' "${DESC[$key]}" "$icon_dir/$key.svg"
    done |
        rofi \
            -dmenu \
            -i \
            -show-icons \
            -format s \
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
                padding: 10 0 5 0px;
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

[[ -z "$MODE" ]] && exit 0

KEY=""
for key in "${!DESC[@]}"; do
    [[ "${DESC[$key]}" == "$MODE" ]] && KEY="$key"
done

FILENAME="$HOME/pics/record/$(date +'%d-%m-%Y_%H:%M').mp4"

case "$KEY" in
    fullscreen)
        wf-recorder -f "$FILENAME" &
        ;;
    area)
        GEOM=$(slurp) || exit 0
        [[ -z "$GEOM" ]] && exit 0
        wf-recorder -g "$GEOM" -f "$FILENAME" &
        ;;
    mic)
        wf-recorder --audio -f "$FILENAME" &
        ;;
    *)
        echo "Unknown option selected" >&2
        exit 1
        ;;
esac

REC_PID=$!
pkill -SIGRTMIN+9 waybar
wait "$REC_PID"
pkill -SIGRTMIN+9 waybar
