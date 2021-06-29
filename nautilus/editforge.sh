#! /bin/bash  
FILE="$(echo "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS" | tr -d '\n')"
WINEFILE="$(winepath -w "$FILE")"
#notify-send "x${WINEFILE}x"

wine ~/.wine/drive_c/audio/soundforge/FORGE32.EXE "$WINEFILE"

