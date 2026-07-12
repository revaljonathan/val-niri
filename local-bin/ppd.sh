#!/usr/bin/env bash

PROFILES=(
    "󰒲a Power Saver"
    "  Balanced"
    # "  Custom"
    "  Performance"
)

CHOICE=$(
    printf '%s\n' "${PROFILES[@]}" | rofi \
        -dmenu \
        -i \
        -p "CPU Prof" \
        -theme-str '
        window { width: 300px; }
        '
)

case "$CHOICE" in
*"Performance"*)
    powerprofilesctl set performance
    ;;
*"  Balanced"*)
    powerprofilesctl set balanced
    ;;
*"Power Saver"*)
    powerprofilesctl set power-saver
    ;;
*"  Custom"*)
    echo "max-power" | sudo tee /sys/firmware/acpi/platform_profile
    ;;
esac
