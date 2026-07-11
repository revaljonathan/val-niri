#!/usr/bin/env bash
dir="$HOME/.config/rofi/power"
COLUMNS=4
THUMB_SIZE=100
TMPFILE=$(mktemp)

find "$dir" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.svg"  \) >"$TMPFILE"

INDEX=$(
declare -A DESC=(
    ["shutdown.svg"]="   shutdown"
    ["reboot.svg"]="    reboot"
    ["lock.svg"]="  Lockscreen"
    ["suspend.svg"]="    suspend"
    ["allow_suspend.svg"]=" allow suspend"
    ["dont_suspend.svg"]=" dont suspend"
    ["logout.svg"]="    logout"

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
                width: 650px;
                height: 285px;
            }
            inputbar {
                enabled: false;
            }
            listview {
                columns: $COLUMNS;
                lines: 2;
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
    rm -f "$TMPFILE"
    exit 0
fi

SELECTED_FILE=$(sed -n "$((INDEX+1))p" "$TMPFILE" 2>/dev/null)
BASENAME=$(basename "$SELECTED_FILE" 2>/dev/null)

if [[ "$BASENAME" == "shutdown.svg" ]]; then
    systemctl poweroff
elif [[ "$BASENAME" == "reboot.svg" ]]; then
    systemctl reboot
elif [[ "$BASENAME" == "dont_suspend.svg" ]]; then
    pkill swayidle
    dunstify "you just disable automatic suspend" || true
elif [[ "$BASENAME" == "allow_suspend.svg" ]]; then
    pkill swayidle 2>/dev/null
    ~/.local/bin/sleep.sh
elif [[ "$BASENAME" == "logout.svg" ]]; then
    niri msg action quit --skip-confirmation
elif [[ "$BASENAME" == "suspend.svg" ]]; then
    systemctl suspend
elif [[ "$BASENAME" == "lock.svg" ]]; then
    ~/.local/bin/dynalock.sh
else
    echo "Unknown option selected"
fi

rm -f "$TMPFILE"
