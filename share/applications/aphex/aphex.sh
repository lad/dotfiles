#!/bin/bash

# SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"

# hack to start a gui app so that the launcher gets an app started/terminated
# notification. Otherwise the icon keeps flashing for 10+ seconds
yad --timeout 1 --no-buttons --fixed --geometry +2000+2000 &


gtk-launch vlc
sleep 0.2

WID=$(xdotool search --name "VLC Media Player")
xdotool windowsize $WID 960 977
xdotool windowmove $WID 950 52

$HOME/dotfiles/nautilus/play_folder.py -r "/home/louis/Music/Aphex Twin/Mix"
