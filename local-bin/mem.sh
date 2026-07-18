#!/bin/bash 

dunstify -u normal "System Status" "$(free -h | awk '/Mem:/ {print "RAM Usage: " $3 " / " $2}')" -a system -i ~/.config/dunst/ram.svg

dunstify -u normal -a "Top RAM Offenders" "$(
    ps -eo comm,rss,%mem | awk '
        NR==1 {next} 
        {
            # Sum up RSS and %MEM for processes with the same name
            rss[$1] += $2
            mem[$1] += $3
        } 
        END {
            # Loop through aggregated data and format it
            for (proc in rss) {
                gb = rss[proc] / 1024 / 1024
                printf "%-25s %5.1f%%  %6.2f GB\n", proc, mem[proc], gb
            }
        }
    ' | sort -rn -k2 | head -5
)"
