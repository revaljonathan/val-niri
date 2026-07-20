#!/usr/bin/env bash

set -euo pipefail

history_json="$(dunstctl history)"

count="$(jq '.data[0] | length' <<<"$history_json" 2>/dev/null || echo 0)"
if [[ "$count" -eq 0 ]]; then
    rofi -e "No notifications in history."
    exit 0
fi

mapfile -t entries < <(
    jq -r '
        def flatten: gsub("\r\n|\r|\n"; "  | ");
        (.data[0] | map(.appname.data // "Unknown" | flatten | length) | max // 0) as $width
        | .data[0]
        | to_entries[]
        | "\(.key)\t\(.value.appname.data // "Unknown" | flatten | . + (" " * ($width - length))) | \(.value.summary.data // "" | flatten) - \(.value.body.data // "" | flatten)"
    ' <<<"$history_json"
)

display_list=()
for entry in "${entries[@]}"; do
    display_list+=("${entry#*$'\t'}")
done

chosen="$(printf '%s\n' "${display_list[@]}" | rofi -dmenu -i -p "History" -no-custom -no-show-icons -theme-str "
    window {
        width: 40%;
        height: 30%;
        location: north east;
        x-offset: -10;
        y-offset: 10;
    }
")"

[[ -z "$chosen" ]] && exit 0

for entry in "${entries[@]}"; do
    idx="${entry%%$'\t'*}"
    label="${entry#*$'\t'}"
    if [[ "$label" == "$chosen" ]]; then
        appname="$(jq -r ".data[0][$idx].appname.data // \"Notification\"" <<<"$history_json")"
        summary="$(jq -r ".data[0][$idx].summary.data // \"\"" <<<"$history_json")"
        body="$(jq -r ".data[0][$idx].body.data // \"\"" <<<"$history_json")"
        notify-send -a "$appname" "$summary" "$body"
        break
    fi
done
