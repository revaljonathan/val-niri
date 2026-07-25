#!/usr/bin/env bash
WALLPAPER_DIR="$HOME/pics/walls/"
COLUMNS=6
THUMB_SIZE=175
TMPFILE=$(mktemp)

# Get all image files
fd --max-depth 1 --type f -e jpg -e jpeg -e png -e webp -e gif . "$WALLPAPER_DIR" |
sort > "$TMPFILE"

INDEX=$(
    cat "$TMPFILE" |
        while read -r filepath; do
            printf ' \x00icon\x1f%s\n' "$filepath"
        done |
        rofi             -dmenu             -i             -show-icons             -format i             -theme-str "
            window {
                width: 65%;
                height: 94%;
                location: west;
                x-offset: 10;
            }
            inputbar {
                enabled: false;
            }
            listview {
                columns: $COLUMNS;
                lines: 6;
                fixed-height: false;
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
                font: \"Sans 0\";
                padding: 0;
                margin: 0;
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
scheme-expressive
scheme-fidelity
scheme-fruit-salad
scheme-monochrome
scheme-neutral
scheme-rainbow
scheme-content
scheme-vibrant"

        SCHEME=$(printf '%s\n' "$SCHEMES" | rofi -dmenu -i -p "scheme" -theme-str '
            window {
                width: 25%;
                location: center;
            }
            listview {
                columns: 2;
                lines: 5;
            }
        ')

        [ -z "$SCHEME" ] && exit 0
    fi

    echo "$SELECTED" >"$HOME/.config/wallpaper"
    awww img "$SELECTED" --transition-type center --transition-fps 165 &

    if [ "$HAS_MATUGEN" -eq 1 ]; then
        matugen image "$SELECTED" --source-color-index 0 -t "$SCHEME"
        sleep 1.5

        # pkill dunst 2>/dev/null
        # dunst &

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
