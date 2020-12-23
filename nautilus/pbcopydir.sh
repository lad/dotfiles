#!/bin/bash

FILE="$(echo $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS | tr -d '\n')"
echo \"$(dirname "$FILE")\" | tr -d '\n' | xclip -in
