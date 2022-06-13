#!/bin/bash

# shopt -s nullglob
# shopt -s nocaseglob

shopt -s nocasematch

APIC=$HOME/dev/src/musicdb/apic.py

while read f; do
  if [ "${f##*.}" == jpg ] || \
     [ "${f##*.}" == jpeg ] || \
     [ "${f##*.}" == "png" ] || \
     [ "${f##*.}" == "gif" ]; then
    export IMG="$f"
    break
  fi
done <<< "$(echo -e "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS")"

if [ -z "$IMG" ]; then
  TMP=/tmp/apic.$$
  while read f; do
    if [ "${f##*.}" == "mp3" ] || \
       [ "${f##*.}" == "flac" ] || \
       [ "${f##*.}" == "opus" ] || \
       [ "${f##*.}" == "m4a" ]; then

      $APIC get "$f" $TMP || true
      [ -f $TMP ] && break
    fi
  done <<< "$(echo -e "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS")"
fi

if [ -f "$TMP" ]; then
  IMG=$TMP
else
  IMG="$(yad --file --geometry=800x900+10+10)"
  if [ -z "$IMG" ]; then
    notify-send "set_apic: cancelled"
    exit 1
  fi
fi

while read f; do
  if [ "${f##*.}" == "mp3" ] || \
    [ "${f##*.}" == "flac" ] || \
    [ "${f##*.}" == "opus" ] || \
    [ "${f##*.}" == "m4a" ]; then

    $APIC set "$f" "$IMG" || true
  fi
done <<< "$(echo -e "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS")"


\rm -rf ~/.cache/thumbnails/*/*
notify-send "set_apic: done"
