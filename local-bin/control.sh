#!/usr/bin/env bash

TASK=(
    "  niri"
    "  zsh"
    "  nvim"
    "󱔓  waybar"
    "  matugen"
    "󰀻  rofi"
    "  dunst"
    "󰯂  scripts"
)

CHOICE=$(
    printf '%s\n' "${TASK[@]}" | rofi \
        -dmenu \
        -i \
        -p "Control Panel" \
        -theme-str '
        window { width: 350px; }
        listview {
            columns: 2;
            lines: 5;
        }
        '
)

case "$CHOICE" in
*"niri"*)
    kitty -e nvim ~/.config/niri
    ;;
*"zsh"*)
    kitty -e nvim ~/.zsh/config
    ;;
*"nvim"*)
    kitty -e nvim ~/.config/nvim
    ;;
*"waybar"*)
    kitty -e nvim ~/.config/waybar
    ;;
*"matugen"*)
    kitty -e nvim ~/.config/matugen
    ;;
*"dunst"*)
    kitty -e nvim ~/.config/matugen/templates/dunst.conf
    ;;
*"scripts"*)
    kitty -e nvim ~/.local/bin
    ;;
*"rofi"*)
    kitty -e nvim ~/.config/rofi/config.rasi
    ;;
esac
