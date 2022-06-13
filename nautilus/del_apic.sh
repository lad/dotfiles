#!/bin/bash

# shopt -s nullglob
# shopt -s nocaseglob

shopt -s nocasematch

APIC=$HOME/dev/src/musicdb/apic.py

while read f; do
  if [ "${f##*.}" == "mp3" ] || \
    [ "${f##*.}" == "flac" ] || \
    [ "${f##*.}" == "opus" ] || \
    [ "${f##*.}" == "m4a" ]; then

    $APIC del "$f" && notify-send "APIC deleted for $(basename $f)"
  fi
done <<< "$(echo -e "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS")"


\rm -rf ~/.cache/thumbnails/*/*
