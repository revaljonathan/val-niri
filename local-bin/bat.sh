BAT="/sys/class/power_supply/BAT0"
status=$(cat "$BAT/status")
capacity=$(cat "$BAT/capacity")

case "$status" in
    "Charging")     icon="$HOME/.config/dunst/charging.svg" ;;
    "Discharging")  icon="$HOME/.config/dunst/discharging.svg" ;;
    "Not charging") icon="$HOME/.config/dunst/not_charging.svg" ;;
    "Full")         icon="$HOME/.config/dunst/charging.svg" ;; 
    *)              icon="$HOME/.config/dunst/not_charging.svg" ;; 
esac

dunstify -a battery -i "$icon" "$status" "${capacity}%"
