#!/bin/bash

# shopt -s nullglob
# shopt -s nocaseglob

while read f; do
  echo "Trying $f"
  if [ "${f##*.}" == "jpg" ] || \
     [ "${f##*.}" == "png" ] || \
     [ "${f##*.}" == "gif" ]; then
    export IMGFILE="$f"
    break
  fi
done <<< "$(echo -e "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS")"

if [ -z "$IMGFILE" ]; then
  echo "set_icon_files: No imgfile found in selected files"
  exit 1
else
  echo "set_icon_files: Image File: $IMGFILE"
fi

IMGURL=$(python3 -c "import sys; import urllib; import urllib.parse; print('file://{}'.format(urllib.parse.quote(sys.argv[1])))" "$IMGFILE")

while read f; do
  if [ "$f" != "$IMGFILE" ]; then
    if [ "${f##*.}" == "mp3" ] || \
       [ "${f##*.}" == "flac" ] || \
       [ "${f##*.}" == "opus" ] || \
       [ "${f##*.}" == "m4a" ]; then

      gvfs-set-attribute "$f"  metadata::custom-icon $IMGURL
      echo "Icon set for $f"
    fi
  fi
done <<< "$(echo -e "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS")"
