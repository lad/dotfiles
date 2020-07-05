#!/usr/bin/env python2

import os
import sys
import subprocess


def play_folder(random=False):
    print "--play_folder(%s): START" % str(random)

    names = os.environ['NAUTILUS_SCRIPT_SELECTED_FILE_PATHS'].split('\n')
    for name in names:
        if name:
            break

    # $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS is terminated with a \n even with a
    # single entry selected.
    #
    # When a single folder is selected, names[] will have two entries, and the
    # second entry will be empty
    isfolder = lambda n: len(n) == 2 and os.path.isdir(n[0]) and not n[1]

    print "Name: %s" % name
    if isfolder(names):
        # play the selected folder
        folder = name
    else:
        # play the files in the same directory as the selected file
        folder = os.path.dirname(name)
    print "Folder: %s" % folder

    opts = '-Z' if random else ''
    cmd = 'vlc --one-instance %s "%s"' % (opts, folder)
    print "Running: ", cmd
    subprocess.check_output(cmd, shell=True)

    print 'play_folder: --END'


if __name__ == '__main__':
    play_folder()

