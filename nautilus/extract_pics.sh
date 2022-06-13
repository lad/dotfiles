#!/bin/bash

$HOME/bin/probe.py --extract "$(echo $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS | tr -d '\n')"
