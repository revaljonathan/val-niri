#!/usr/bin/env bash
set -euo pipefail

if pgrep -x sleep.sh > /dev/null; then
    pkill -x swayidle
    ~/.local/bin/caffed.sh & disown
    dunstify -a caffeine "swayidle" "Disabled, screen won't auto-lock/sleep" -i ~/.config/quickshell/notification/assets/caffed.svg
else
    pkill -x swayidle
    ~/.local/bin/sleep.sh & disown
    dunstify -a caffeine "swayidle" "Enabled, normal idle behavior restored" -i ~/.config/quickshell/notification/assets/sleep.svg
fi

quickshell ipc call bar updateCaffeine || true
