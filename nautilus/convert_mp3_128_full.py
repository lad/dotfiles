#!/usr/bin/env python3

import os
import subprocess


for path in os.environ['NAUTILUS_SCRIPT_SELECTED_FILE_PATHS'].split('\n'):
  if not path:
    continue

  base = os.path.splitext(path)[0]
  filename = os.path.basename(base)
  print('filename={}'.format(filename))
  output_path = base + '.mp3'

  # get the name of the parent directory and use as the default for the album
  # name then the name of that parent and use as the default for the artist
  # name
  parent = os.path.join(os.path.dirname(path), '..')
  parent = os.path.realpath(parent)
  print('parent={}'.format(parent))
  album = os.path.split(parent)[-1]
  print('album={}'.format(album))

  parent = os.path.join(parent, '..')
  parent = os.path.realpath(parent)
  print('parent={}'.format(parent))
  artist = os.path.split(parent)[-1]
  print('artist={}'.format(artist))

  cmd = 'yad --form --title=MetaData ' \
        '--field=Title ' \
        '--field=Artist ' \
        '--field=Album ' \
        '--field=Track ' \
        '--field=Of ' \
        '"{}" "{}" "{}"'.format(filename, artist, album)
  print(cmd)
  md = subprocess.check_output(cmd, shell=True)
  md = md.decode('utf-8').split("\n")[0]
  title, artist, album, track, of, _ = md.split("|")

  cmd = 'lame --quiet --preset standard --tt "%s" --ta "%s" --tl "%s" --tn "%s/%s" "%s" "%s"' % (title, artist, album, track, of, path, output_path)
  print("Running...{}".format(cmd))
  subprocess.check_output(cmd, shell=True)
  print('------')



  """
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
  """
