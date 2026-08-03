#!/bin/bash
FILE=$(fd --type f --exclude Games | rofi -dmenu -i -p "Search Files:")
if [ -n "$FILE" ]; then
    xdg-open "$FILE"
fi
