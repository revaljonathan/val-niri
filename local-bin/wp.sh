#!/usr/bin/env bash
WALLPAPER_DIR="$HOME/pics/walls/"
COLUMNS=6
THUMB_SIZE=175
TMPFILE=$(mktemp)

{
    echo "__GAMBLING__"
    find "$WALLPAPER_DIR" -maxdepth 1 -type f \
        \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" -o -iname "*.mp4" \) |
        sort
} >"$TMPFILE"

INDEX=$(
    cat "$TMPFILE" |
        while read -r filepath; do
            if [ "$filepath" = "__GAMBLING__" ]; then
                printf '\x00icon\x1f%s\n' "$WALLPAPER_DIR/gambling.svg"
            else
                printf ' \x00icon\x1f%s\n' "$filepath"
            fi
        done |
        rofi             -dmenu             -i             -show-icons             -format i             -theme-str "
            window {
                width: 1250px;
                height: 1100px;
                location: west;
                x-offset: 5;
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
                border-radius: 8px;
                spacing: 0px;
            }
            element-icon {
                size: ${THUMB_SIZE}px;
                border-radius: 8px;
            }
            element-text {
                font: \"Sans 0\";
                padding: 0;
                margin: 0;
            }
            element selected {
                border-radius: 10px;
            }
        "
)

[ -z "$INDEX" ] && {
    rm "$TMPFILE"
    exit 0
}

SELECTED=$(sed -n "$((INDEX + 1))p" "$TMPFILE")
rm "$TMPFILE"

if [ "$SELECTED" = "__GAMBLING__" ]; then
    SELECTED=$(
        find "$WALLPAPER_DIR" -maxdepth 1 -type f \
            \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" -o -iname "*.mp4" \) |
            shuf -n 1
    )
fi

if [ -n "$SELECTED" ]; then
    pkill swaybg
    sleep 0.8
    echo "$SELECTED" >"$HOME/.config/wallpaper"
    ln -sf "$SELECTED" "$HOME/.config/wallpaper.lock"
    awww img "$SELECTED" --transition-type center &

    MATUGEN_PID=""

    if command -v matugen &>/dev/null; then
        pkill waybar 2>/dev/null

        matugen image "$SELECTED" --source-color-index 0 -t scheme-tonal-spot

        sleep 0.5

        if grep -q 'dunst = true' "$HOME/.config/matugen/config.toml" 2>/dev/null; then
            pkill dunst 2>/dev/null
            sleep 0.3
            dunst &
        fi

        pkill -SIGUSR1 kitty 2>/dev/null
        systemctl --user restart xdg-desktop-portal-gtk

        sleep 0.3
        if pgrep waybar >/dev/null; then
            pkill waybar
        fi
        sleep 0.3
        ~/.local/bin/defbar.sh &
    fi

    dunstify -i ~/.config/dunst/walls.svg -a walls "wallpaper changed" "congrats"
fi
