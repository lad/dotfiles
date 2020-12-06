#!/usr/bin/env python3

import os
import subprocess


def album_artist(path):
  full_parent, rhs = os.path.split(path)
  parent_name = os.path.split(full_parent)[1]

  parts=[]
  while parent_name and parent_name != 'Music':
    full_parent, part = os.path.split(full_parent)
    parts.append(part)
    parent_name = os.path.split(full_parent)[1]

  # If we found the "Music" directory, the last two parts should be the album
  # and artist name
  return parts[-2:]


def run(path):
  base = os.path.splitext(path)[0]
  filename = os.path.basename(base)
  output_path = base + '.mp3'

  print('output_path={}'.format(filename))

  album, artist = album_artist(path)

  cmd = 'yad --form --title=MetaData ' \
        '--width=500 ' \
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

  cmd = 'lame --quiet --preset standard --tt "%s" --ta "%s" --tl "%s" --tn "%s/%s" '\
        '"%s" "%s"' % (title, artist, album, track, of, path, output_path)
  print("Running...{}".format(cmd))
  subprocess.check_output(cmd, shell=True)
  print('------')


for path in os.environ['NAUTILUS_SCRIPT_SELECTED_FILE_PATHS'].split('\n'):
  if not path:
    continue

  run(path)
