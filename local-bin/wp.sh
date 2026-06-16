#!/usr/bin/env bash
WALLPAPER_DIR="$HOME/pics/walls/"
COLUMNS=4
THUMB_SIZE=175
TMPFILE=$(mktemp)

find "$WALLPAPER_DIR" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) |
    sort >"$TMPFILE"

INDEX=$(
    cat "$TMPFILE" |
        while read -r filepath; do
            printf ' \x00icon\x1f%s\n' "$filepath"
        done |
        rofi \
            -dmenu \
            -i \
            -show-icons \
            -format i \
            -theme-str "
            window {
                width: 900px;
                location: west;
                x-offset: 4;
            }
            inputbar {
                enabled: false;
            }
            listview {
                columns: $COLUMNS;
                lines: 5;
                fixed-height: false;
                flow: horizontal;
                spacing: 8px;
            }
            element {
                orientation: vertical;
                padding: 4px;
                border-radius: 10px;
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

if [ -n "$SELECTED" ]; then
    pkill swaybg
    sleep 0.8
    echo "$SELECTED" >"$HOME/.config/wallpaper"
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
fi
