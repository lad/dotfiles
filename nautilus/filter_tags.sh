#!/bin/bash

FILE="$(echo "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS" | tr -d '\n')"
if [ -f "$FILE" ]; then
  DIR="$(dirname "$FILE")"
else
  DIR="$FILE"
fi

PY=/home/louis/.pyenv/shims/python3.9

trap 'rm -f /tmp/mdb.*.$$' EXIT

OUT=/tmp/mdb.filter.$$
N=0
for file in "$DIR/"*; do
  # must have messed up condition above...
  if [ -f "$file" ]; then
    $PY $HOME/dev/src/musicdb/file.py --filter "$file" > "$OUT"
    if [ $? -ne 0 ]; then
      echo "Filter tags failed: $(cat $OUT)"
      notify-send "Filter tags failed: $(cat $OUT)"
      exit 1
    fi
    N=$((N+1))
  fi
done

if [ $N -eq 0 ]; then
  echo "Filter tags complete: No files filtered"
  notify-send "Filter tags complete: No files filtered"
else
  if [ $N -eq 1 ]; then
    suf="file"
  else
    suf="files"
  fi
  echo "Filter tags complete for $N $suf"
  notify-send "Filter tags complete for $N $suf"
fi
