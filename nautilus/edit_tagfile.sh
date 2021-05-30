#!/bin/bash

FILE="$(echo "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS" | tr -d '\n')"
DIR="$(dirname "$FILE")"

PY=/home/louis/.pyenv/shims/python3.9

cd $HOME/dev/src/musicdb
export EDITOR=gvim

trap 'rm -f /tmp/mdb.*.$$' EXIT

OUT=/tmp/mdb.et.$$
$PY ./mdb.py --db .music et -f "$DIR" > "$OUT"
if [ $? -ne 0 ]; then
  notify-send "Edit Tagfile failed: $(cat $OUT)"
  exit 1
fi

DRYOUT=/tmp/mdb.at.$$
$PY ./mdb.py --db .music at --force --dryrun "$DIR" > $DRYOUT
if [ $? -ne 0 ]; then
  notify-send "Dryrun failed: $(cat $DRYOUT)"
  exit 1
fi

N=$(wc -l "$DRYOUT"|awk '{print $1}')
if [ $N -eq 0 ]; then
  notify-send "No changes made for $DIR"
  exit
fi

HEIGHT=$((N * 40))
yad --text-info \
    --width 800 \
    --height $HEIGHT \
    --image='gtk-apply' \
    --text "<b><big><big>Apply Edits</big></big></b>" \
    --text-align=center \
    --buttons-layout=center \
    --button="gtk-ok:1"  \
    --button="gtk-cancel:252"  \
    --filename=$DRYOUT

if [ $? -eq 1 ]; then
  echo "Applying tagfile for $DIR"
  $PY ./mdb.py --db .music at --force "$DIR"
  notify-send "Applied tagfile for $DIR"
else
  notify-send "NOT Applying tagfile for $DIR"
fi

