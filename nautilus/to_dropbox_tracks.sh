#!/bin/bash

FILE="$(echo $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS | tr -d '\n')"
cp "$(readlink -f "$FILE")" ~/Dropbox/Tracks/
[ $? -ne 0 ] && echo "$0: failed" && exit 1
