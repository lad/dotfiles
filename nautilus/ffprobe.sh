#!/bin/bash
ffprobe -show_entries format -show_entries stream -loglevel quiet -hide_banner "$(echo $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS | tr -d '\n')" 2>&1 | yad --text-info --listen  --geometry=1000x500+200+200
