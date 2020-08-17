#!/usr/bin/env python2

import os
import subprocess


for path in os.environ['NAUTILUS_SCRIPT_SELECTED_FILE_PATHS'].split('\n'):
  if not path:
    continue

  output = os.path.splitext(path)[0] + '.mp3'

  cmd = "zenity --entry --entry-text='beat cleaver' --title=Artist"
  artist = subprocess.check_output(cmd, shell=True)
  artist = artist.split("\n")[0]

  cmd = 'lame --quiet --preset standard --ta "%s" "%s" "%s"' % (artist, path, output)
  print "Running...", cmd
  subprocess.check_output(cmd, shell=True)
  print '------'
