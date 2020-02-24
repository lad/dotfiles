#!/usr/bin/env python2

import os
import subprocess


for path in os.environ['NAUTILUS_SCRIPT_SELECTED_FILE_PATHS'].split('\n'):
  if not path:
    continue

  
  base = os.path.splitext(path)[0]
  filename = os.path.basename(base)
  output_path = base + '.mp3'

  cmd = 'zenity --forms --title=MetaData ' \
        '--add-entry=Title --text="%s" ' \
        '--add-entry=Artist --text="beat cleaver" ' \
        '--add-entry=Album ' \
        '--add-entry=Track ' \
        '--add-entry=Of' % filename
  md = subprocess.check_output(cmd, shell=True)
  md = md.split("\n")[0]
  title, artist, album, track, of = md.split("|")

  cmd = 'lame --quiet --preset standard --tt "%s" --ta "%s" --tl "%s" --tn "%s/%s" "%s" "%s"' % (title, artist, album, track, of, path, output_path)
  print "Running...", cmd
  subprocess.check_output(cmd, shell=True)
  print '------'
