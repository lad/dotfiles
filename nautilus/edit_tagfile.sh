#!/bin/bash

FILE="$(echo "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS" | tr -d '\n')"
if [ -f "$FILE" ]; then
  DIR="$(dirname "$FILE")"
else
  DIR="$FILE"
fi

PY=/home/louis/.pyenv/shims/python3.9
DB=$HOME/.musicdb

cd $HOME/dev/src/musicdb/cmd
export PYTHONPATH=$HOME/dev/src
export EDITOR=gvim

trap 'rm -f /tmp/mdb.*.$$' EXIT

OUT=/tmp/mdb.et.$$
$PY ./mdb.py --db $DB et -f "$DIR" > "$OUT"
if [ $? -ne 0 ]; then
  echo "Edit Tagfile failed: $(cat $OUT)"
  notify-send "Edit Tagfile failed: $(cat $OUT)"
  exit 1
fi

#DRYOUT=/tmp/mdb.at.$$
DRYOUT=/tmp/aa
$PY ./mdb.py --db $DB at --force --dryrun "$DIR" > $DRYOUT
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
  $PY ./mdb.py --db $DB at --force "$DIR"
  notify-send "Applied tagfile for $DIR"
else
  notify-send "NOT Applying tagfile for $DIR"
fi

