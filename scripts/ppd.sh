#!/usr/bin/env bash

PROFILES=(
    "󰌪  Power Saver"
    "  Balanced"
    # "  Custom"
    "󱓞  Performance"
)

CHOICE=$(
    printf '%s\n' "${PROFILES[@]}" | rofi \
        -dmenu \
        -i \
        -p "CPU Prof" \
        -theme-str '
        window { width: 15%; }
        '
)

case "$CHOICE" in
*"Performance"*)
    powerprofilesctl set performance
    dunstify -a "CPU profile" "changed to performance mode" -i ~/.icons/icon_scripts/dunst/cpu/perf.svg
    ;;
*"Balanced"*)
    powerprofilesctl set balanced
    dunstify -a "CPU profile" "changed to balance mode" -i ~/.icons/icon_scripts/dunst/cpu/balance.svg
    ;;
*"Power Saver"*)
    powerprofilesctl set power-saver
    dunstify -a "CPU profile" "changed to low-power mode" -i ~/.icons/icon_scripts/dunst/cpu/low.svg
    ;;
*"  Custom"*)
    echo "max-power" | sudo tee /sys/firmware/acpi/platform_profile
    ;;
esac
