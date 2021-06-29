#!/usr/bin/env python3

import os
import subprocess


def run(path):
    if not os.path.isfile(path):
        print("{} is not a file".format(path))
        return

    base = os.path.splitext(path)[0]
    filename = os.path.basename(base)
    output_path = base + '.wav'

    if os.path.exists(output_path):
        print("Output path already exists: {}".format(output_path))

    print('output_path={}'.format(output_path))

    cmd = 'ffmpeg -i "{}" -vn "{}"'.format(path, output_path)
    print("Running...{}".format(cmd))
    subprocess.check_output(cmd, shell=True)
    print('------')


for path in os.environ['NAUTILUS_SCRIPT_SELECTED_FILE_PATHS'].split('\n'):
  if not path:
    continue

  run(path)
