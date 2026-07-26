#! /bin/bash

send_notification() {
	HEAD=$(cal "$1" | head -n1)
	if [ "$DIFF" -eq 0 ]; then
		TODAY=$(date '+%-d')
		BODY=$(cal "$1" | tail -n7 | sed -z "s|$TODAY|<span background='{{colors.secondary.default.hex}}' foreground='{{colors.surface.default.hex}}'><b>$TODAY</b></span>|1")
	else
		BODY=$(cal "$1" | tail -n7)
	fi
	dunstify -h string:x-canonical-private-synchronous:calendar \
		"$HEAD" "$BODY" -u NORMAL -a calendar
}

handle_action() {
	echo "$DIFF" > "$TMP"
	if [ "$DIFF" -ge 0 ]; then
		send_notification "+$DIFF months"
	else
		send_notification "$((-DIFF)) months ago"
	fi
}

TMP=${XDG_RUNTIME_DIR:-/tmp}/"$UID"_calendar_notification_month
touch "$TMP"

DIFF=$(<"$TMP")

case $1 in
	"curr") DIFF=0;;
	"next") DIFF=$((DIFF+1));;
	"prev") DIFF=$((DIFF-1));;
esac

handle_action
