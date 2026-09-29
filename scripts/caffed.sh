#!/bin/bash

swayidle -w \
  timeout 450 'brightnessctl -s set 5%' \
  resume 'brightnessctl -r' \
  timeout 900 'niri msg action power-off-monitors' \
  resume 'niri msg action power-on-monitors' \
  timeout 910 'powerprofilesctl set power-saver' \
  resume 'powerprofilesctl set balanced' \
  timeout 1800 'quickshell ipc call lockscreen lock' \
  before-sleep "quickshell ipc call lockscreen lock"
