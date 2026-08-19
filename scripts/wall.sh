#!/usr/bin/env bash
WALLPAPER_DIR="$HOME/pics/walls/"
COLUMNS=6
THUMB_SIZE=190
TMPFILE=$(mktemp)

fd --max-depth 1 --type f -e jpg -e jpeg -e png -e webp -e gif . "$WALLPAPER_DIR" |
sort > "$TMPFILE"

INDEX=$(
    cat "$TMPFILE" |
        while read -r filepath; do
            filename=$(basename "$filepath")
            printf '%s\x00icon\x1f%s\n' "$filename" "$filepath"
        done |
        rofi -dmenu -p wallpaper -i -show-icons -format i -theme-str "
            window {
                width: 70%;
                location: south;
                y-offset: -10;
                x-offset: 10;
            }

            listview {
                columns: $COLUMNS;
                flow: horizontal;
                spacing: 8px;
                lines: 3;
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
                padding: 0px 0 0 0;
                font-size: 14px;
                width: ${THUMB_SIZE}px;
                text-align: center;
                horizontal-align: 0.5;
                vertical-align: 0.5;
            }
            element selected {
                border-radius: 0px;
            }
        "
)
[ -z "$INDEX" ] && {
    rm "$TMPFILE"
    exit 0
}

SELECTED=$(sed -n "$((INDEX + 1))p" "$TMPFILE")
rm "$TMPFILE"

if [ -n "$SELECTED" ]; then
    HAS_MATUGEN=0
    if command -v matugen &>/dev/null; then
        HAS_MATUGEN=1

        SCHEMES="scheme-tonal-spot
scheme-content
scheme-neutral
scheme-rainbow
"
        SCHEME=$(printf '%s\n' "$SCHEMES" | rofi -dmenu -i -p "scheme" -theme-str '
            window {
                width: 15%;
                location: center;
            }
            listview {
                columns: 1;
                lines: 4;
            }
        ')

        [ -z "$SCHEME" ] && exit 0
    fi

    echo "$SELECTED" >"$HOME/.config/wallpaper"
    awww img "$SELECTED" --transition-type center --transition-fps 120 &

    if [ "$HAS_MATUGEN" -eq 1 ]; then
        matugen image "$SELECTED" --source-color-index 0 -t "$SCHEME"
        sleep 1.5

        dunstctl reload

        pkill -SIGUSR1 kitty 2>/dev/null
        systemctl --user restart xdg-desktop-portal-gtk

        pkill -SIGUSR2 waybar
        pkill -USR2 btop
        pkill -USR1 cava
        spicetify watch -s 2>&1 | sed "/Reloaded Spotify/q"
    fi
    dunstify -i ~/.icons/icon_scripts/dunst/misc/walls.svg -a walls "wallpaper changed" "congrats"
fi
