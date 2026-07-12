#!/bin/bash

swayidle -w \
    timeout 90 'brightnessctl -s set 5%' \
    resume 'brightnessctl -r' \
    timeout 300 'niri msg action power-off-monitors' \
    resume 'niri msg action power-on-monitors' \
    timeout 305 'powerprofilesctl set power-saver' \
    resume 'powerprofilesctl set balanced' \
    timeout 900 'systemctl suspend' \
    before-sleep "$HOME/.local/bin/dynalock.sh"
