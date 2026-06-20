#!/bin/bash

swayidle -w \
    timeout 120 'brightnessctl -s set 5%' \
    resume 'brightnessctl -r' \
    timeout 300 'niri msg action power-off-monitors' \
    resume 'niri msg action power-on-monitors' \
    timeout 360 "$HOME/.local/bin/dynalock.sh" \
    timeout 600 'systemctl suspend' \
    before-sleep "$HOME/.local/bin/dynalock.sh"
