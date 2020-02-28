#!/bin/bash


FILE="$(echo $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS | tr -d '\n')"
ls -l  "$FILE"

cp "$(readlink "$FILE")" ~/Dropbox/Tracks/
