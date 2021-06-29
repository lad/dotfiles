#!/bin/bash

echo "x${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS}x"

FILES=()
for f in $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS; do
  echo "f=$f"
  FILES+=($f)
done

echo "FILES=${FILES[@]}"

if [ -n "$FILES" ]; then
  echo in1="${FILES[0]}"
  echo in2="${FILES[1]}"

  OUTPUT="${FILES%.*}-LR.${FILES##*.}"
  echo out="${OUTPUT}"
  #$HOME/dev/src/musicdb/mono2stereo.py "${FILES[0]}" "${FILES[1]}" "$OUTPUT"
fi
