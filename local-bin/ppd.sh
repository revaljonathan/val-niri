#!/usr/bin/env bash

PROFILES=(
    "󰒲a Power Saver"
    "  Balanced"
    "  Custom"
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
    echo "performance" | sudo tee /sys/firmware/acpi/platform_profile
    ;;
*"  Balanced"*)
    echo "balanced" | sudo tee /sys/firmware/acpi/platform_profile
    ;;
*"󰒲  Power Saver"*)
    echo "low-power" |sudo tee /sys/firmware/acpi/platform_profile
    ;;
*"  Custom"*)
    echo "max-power" | sudo tee /sys/firmware/acpi/platform_profile
    ;;
esac
