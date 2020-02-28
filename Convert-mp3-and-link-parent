#!/usr/bin/env python2

import os
import subprocess
import time


for path in os.environ['NAUTILUS_SCRIPT_SELECTED_FILE_PATHS'].split('\n'):

  if not path:
    continue

  (dirname, filename) = os.path.split(path)
  title = os.path.splitext(os.path.split(filename)[1])[0]
  output_filename = title + '.mp3'
  output_path = os.path.join(dirname, output_filename)

  # overwrites output if it exists

  cmd = 'lame --quiet --preset standard --tt "%s" ' \
        '--ta "beat cleaver" "%s" "%s"' % (title, path, output_path)
  print "Running...", cmd
  subprocess.check_output(cmd, shell=True)
  print '------'

  link_path = os.path.join(os.path.dirname(dirname), output_filename)
  if os.path.exists(link_path):
    if os.path.islink(link_path):
        os.unlink(link_path)
    else:
      cmd = "zenity --error --text 'Parent exists and is not a link: %s'" % link_path
      subprocess.check_output(cmd, shell=True)
      exit(1)

  cmd = 'ln -s "%s" "%s"' % (output_path, link_path)
  subprocess.check_output(cmd, shell=True)
