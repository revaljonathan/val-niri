#!/usr/bin/env bash

NOTE_DIR="$HOME/note"
mkdir -p "$NOTE_DIR"

pick() {
    local prompt="$1"
    rofi -dmenu -i -lines 10 -p "$prompt"
}

edit_note() {
    local note_file="$1"
    # foreground on purpose: script waits here until nvim exits,
    # then loops back to the menu instead of exiting entirely.
    kitty --class "note" -- nvim "$note_file"
}

while true; do
    FOLDERS=$(find "$NOTE_DIR" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort)

    FOLDER=$(
        {
            printf '[+] New Folder\n'
            [ -n "$FOLDERS" ] && printf '%s\n' "$FOLDERS"
        } | pick "Folder"
    )

    [ -z "$FOLDER" ] && exit 0

    if [ "$FOLDER" = '[+] New Folder' ]; then
        FOLDER=$(printf '' | pick "New folder name")
        [ -z "$FOLDER" ] && continue
        FOLDER="${FOLDER//\//-}"
        mkdir -p "$NOTE_DIR/$FOLDER"
    fi

    FOLDER_PATH="$NOTE_DIR/$FOLDER"

    # inner loop: stay inside this folder until user backs out (Esc)
    while true; do
        NOTES=$(find "$FOLDER_PATH" -maxdepth 1 -name '*.md' -printf '%f\n' \
                | sed 's/\.md$//' | sort)

        SELECTION=$(
            {
                printf '[+] Add Note\n'
                printf '[-] Delete Note\n'
                [ -n "$NOTES" ] && printf '%s\n' "$NOTES"
            } | pick "$FOLDER"
        )

        [ -z "$SELECTION" ] && break   # Esc here -> back to folder picker

        case "$SELECTION" in

            '[+] Add Note')
                NOTE_NAME=$(printf '' | pick "Note name")
                [ -z "$NOTE_NAME" ] && continue
                NOTE_NAME="${NOTE_NAME//\//-}"

                NOTE_FILE="$FOLDER_PATH/$NOTE_NAME.md"
                STAMP=$(date "+%A, %-d %B %Y at %H:%M")
                printf '# %s\n\n%s\n\n---\n\n' "$NOTE_NAME" "$STAMP" > "$NOTE_FILE"

                edit_note "$NOTE_FILE"
                ;;

            '[-] Delete Note')
                [ -z "$NOTES" ] && continue

                TO_DELETE=$(printf '%s\n' "$NOTES" | pick "Delete which note?")
                [ -z "$TO_DELETE" ] && continue

                CONFIRM=$(printf 'yes\nno\n' | pick "Delete '$TO_DELETE'?")
                [ "$CONFIRM" = 'yes' ] && rm -f "$FOLDER_PATH/$TO_DELETE.md"
                ;;

            *)
                NOTE_FILE="$FOLDER_PATH/$SELECTION.md"
                [ -f "$NOTE_FILE" ] && edit_note "$NOTE_FILE"
                ;;

        esac
    done
done
