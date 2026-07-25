#!/usr/bin/env bash
dir="$HOME/.icons/icon_scripts/rofi/power"
COLUMNS=3
THUMB_SIZE=100
TMPFILE=$(mktemp)

fd . "$dir" \
    --max-depth 1 \
    --type f \
    --extension svg > "$TMPFILE"

INDEX=$(
declare -A DESC=(
    ["shutdown.svg"]="   shutdown"
    ["reboot.svg"]="    reboot"
    ["lock.svg"]="  lockscreen"
    ["suspend.svg"]="    suspend"
    ["suspend_toggle.svg"]="toggle suspend"
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
                width: 27%;
                height: 25%;
            }
            inputbar {
                enabled: false;
            }
            listview {
                columns: $COLUMNS;
                lines: 2;
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

# Confirmation function using rofi
confirm_action() {
    local action="$1"
    local response=$(echo -e "No\nYes" | rofi -dmenu -i -p "Confirm?" \
        -theme-str 'window {width: 10%;}' -no-show-icon)
    
    if [[ "$response" == "Yes" ]]; then
        return 0
    else
        return 1
    fi
}

if [[ "$BASENAME" == "suspend_toggle.svg" ]]; then
    if pgrep -x "swayidle" > /dev/null; then
        pkill swayidle
        dunstify "Automatic suspend: DISABLED" 
    else
        pkill swayidle 2>/dev/null
        ~/.local/bin/sleep.sh
    fi
elif [[ "$BASENAME" == "shutdown.svg" ]]; then
    if confirm_action "Shutdown"; then
        systemctl poweroff
    else
        dunstify "Shutdown cancelled"
    fi
elif [[ "$BASENAME" == "reboot.svg" ]]; then
    if confirm_action "Reboot"; then
        systemctl reboot
    else
        dunstify "Reboot cancelled"
    fi
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
