#!/bin/bash

shopt -s nocasematch

while read f; do
  echo $f
  cd $(dirname "$f")
  echo $PWD

  ext="${f##*.}"

  if [ "$ext" == "zip" ]; then
    unzip "$f"
  elif [ "$ext" == "tar" ]; then
    tar xvf "$f"
  elif [ "$ext" == "tgz" ]; then
    tar xvzf "$f"
  fi
done <<< "$(echo -e "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS")"
