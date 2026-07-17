#!/bin/bash 

dunstify -u normal "System Status" "$(free -h | awk '/Mem:/ {print "RAM Usage: " $3 " / " $2}')" -a system -i ~/.config/dunst/ram.svg

dunstify -u normal "🔫 Top RAM Offenders" "$(ps aux --sort=-%mem | head -6 | awk '{print $11 " - " $4 "%"}')"
