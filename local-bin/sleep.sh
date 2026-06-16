#!/bin/bash

swayidle -w \
    timeout 180 'brightnessctl -s set 5%' \
    resume 'brightnessctl -r' \
    timeout 420 'niri msg action power-off-monitors' \
    resume 'niri msg action power-on-monitors' \
    timeout 540 "$HOME/.local/bin/dynalock.sh" \
    timeout 720 'systemctl suspend' \
    before-sleep "$HOME/.local/bin/dynalock.sh"
