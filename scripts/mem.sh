#!/bin/bash

dunstify -u normal "System Status" "$(free -h | awk '/Mem:/ {print "RAM Usage: " $3 " / " $2}')" -a system -i ~/.icons/icon_scripts/dunst/misc/ram.svg

dunstify -u normal -a "Top RAM Offenders" "$(
    ps -eo comm,rss,%mem --no-headers | awk '
        {
            # Guard: skip malformed lines (need exactly proc + 2 numeric fields)
            if (NF < 3 || $2 !~ /^[0-9]+$/ || $3 !~ /^[0-9.]+$/) next
            rss[$1] += $2
            mem[$1] += $3
        }
        END {
            for (proc in rss) {
                gb = rss[proc] / 1024 / 1024
                printf "%-25s %5.1f%%  %6.2f GB\n", proc, mem[proc], gb
            }
        }
    ' | sort -rn -k2 | head -5
)"

# Debug tip: if "Command" or garbage %'s reappear, run this once to capture raw output:
# ps -eo comm,rss,%mem --no-headers > /tmp/ps_debug_$(date +%s).txt
