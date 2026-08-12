#!/usr/bin/env bash
printf "Enter file name: "
read -r filename
if [ -z "$filename" ]; then
    exit 0
fi

if [ ! -f "$filename.md" ]; then
    printf "# %s\n---\n\n" "$(date '+%A, %-d %B %Y at %H:%M')" >> "$filename.md"
fi

"${EDITOR:-nvim}" +"normal Go" +"startinsert" "$filename.md"
