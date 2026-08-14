#!/usr/bin/env bash

CHOICE=$(echo -e "󰒮\n󰏤\n󰒭" | rofi -dmenu -i -no-show-icon -theme-str "
window {
    location: north;
    width: 30%;
    height: 13%;
    y-offset: 10;
}
inputbar { enabled: false; }
listview {
    columns: 3;
    lines: 1;
    flow: horizontal;
    spacing: 0px;
}
element {
    orientation: vertical;
    padding: 0 0 7 0px;
    spacing: 0px;
}
message {
    padding: 0;
}
element-text {
    vertical-align: 0.5;
    horizontal-align: 0.5;
    font: \"JetBrainsMono Nerd Font 72\";
}
")

case "$CHOICE" in
    "󰒮")
        playerctl previous
        ;;
    "󰏤")
        playerctl play-pause
        ;;
    "󰒭")
        playerctl next
        ;;
    *)
        exit 0
        ;;
esac
