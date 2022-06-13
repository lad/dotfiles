#!/bin/bash

# shopt -s nullglob
# shopt -s nocaseglob

shopt -s nocasematch

while read f; do
  if [ "${f##*.}" == jpg ] || \
     [ "${f##*.}" == jpeg ] || \
     [ "${f##*.}" == "png" ] || \
     [ "${f##*.}" == "gif" ]; then
    export IMGFILE="$f"
    break
  fi
done <<< "$(echo -e "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS")"

if [ -z "$IMGFILE" ]; then
  IMGFILE="$(yad --file --geometry=800x900+10+10)"
  if [ -z "$IMGFILE" ]; then
    notify-send "set_icon_files: cancelled"
    exit 1
  fi
fi

IMGURL=$(python3 -c "import sys; import urllib; import urllib.parse; print('file://{}'.format(urllib.parse.quote(sys.argv[1])))" "$IMGFILE")

N=0

while read f; do
  if [ "$f" != "$IMGFILE" ]; then
    if [ "${f##*.}" == "mp3" ] || \
       [ "${f##*.}" == "flac" ] || \
       [ "${f##*.}" == "opus" ] || \
       [ "${f##*.}" == "m4a" ]; then

      gvfs-set-attribute "$f"  metadata::custom-icon $IMGURL
      N=$((N+1))
    fi
  fi
done <<< "$(echo -e "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS")"

notify-send "set_icon_files: icon set for $N file(s)"
