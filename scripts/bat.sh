BAT="/sys/class/power_supply/BAT0"
status=$(cat "$BAT/status")
capacity=$(cat "$BAT/capacity")

ICON_DIR="$HOME/.icons/icon_scripts/dunst/battery"

case "$status" in
    "Charging")     icon="$ICON_DIR/charging.svg" ;;
    "Discharging")  icon="$ICON_DIR/discharging.svg" ;;
    "Not charging") icon="$ICON_DIR/not_charging.svg" ;;
    "Full")         icon="$ICON_DIR/charging.svg" ;;
    *)              icon="$ICON_DIR/not_charging.svg" ;;
esac

dunstify -a battery -i "$icon" "$status" "${capacity}%"
