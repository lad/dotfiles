#!/bin/bash


SRCDIR=$(cd $(dirname "$0"); pwd)

SRC=( add-to-vlc-playlist.sh \
      convert_mp3_128.py \
      convert_mp3_and_link_parent.py \
      convert_mp3_128_full.py \
      flac-decode \
      play_folder.py \
      play_folder_random.py \
      to_dropbox_tracks.sh )

DST=( "Add to VLC playlist" \
      "Convert MP3 (128)" \
      "Convert MP3 128 and Link Parent" \
      "Convert MP3 (128 Full)" \
      "FLAC Decode" \
      "Play Folder" \
      "Play Folder (Random)" \
      "To Dropbox Tracks" )


cd $HOME/.local/share/nautilus/scripts
ls -l
for ((i=0; i<${#SRC[@]}; i++)); do
  rm "${DST[$i]}"
  ln -s "$SRCDIR/${SRC[$i]}" "${DST[$i]}"
done

