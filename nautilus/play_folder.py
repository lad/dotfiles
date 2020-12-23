#!/usr/bin/env python2

import os
import sys
import subprocess


def play_folder(random=False, folder=None):
    print "--play_folder(%s): START" % str(random)

    if not folder:
        try:
            names = os.environ['NAUTILUS_SCRIPT_SELECTED_FILE_PATHS'].split('\n')
        except KeyError:
            print('No folder argument and $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS '
                  'is not set.')
            sys.exit(1)

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
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument('--random', '-r', action='store_true')
    parser.add_argument(action='store', dest='path', nargs='?', help='path')
    ns = parser.parse_args()

    play_folder(random=ns.random, folder=ns.path)
