#!/bin/bash

FILE="$(echo $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS | tr -d '\n')"
DIR="$(dirname "$FILE")"

FURL=$(python3 -c "import sys; import urllib; import urllib.parse; print('file://{}'.format(urllib.parse.quote(sys.argv[1])))" "$FILE")

cd "$DIR"
shopt -s nullglob
shopt -s nocaseglob

for i in *.{mp3,flac,opus,m4a,wav}; do
    gvfs-set-attribute "$i"  metadata::custom-icon $FURL
    echo "Icon set for $i"
done

