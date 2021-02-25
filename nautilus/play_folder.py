#!/usr/bin/env python2

import os
import sys
import subprocess


def play_folder(random=False, path=None):
    """path may point to a folder or file. If it's a file, play all files in
       the same directory as that file."""
    print "--play_folder(random=%s, path=%s): START" % (str(random), str(path))

    if not path:
        try:
            names = os.environ['NAUTILUS_SCRIPT_SELECTED_FILE_PATHS'].split('\n')
        except KeyError:
            print('No path argument and $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS '
                  'is not set.')
            sys.exit(1)

        print "--play_folder: NAMES: %s" % str(names)
        for name in names:
            if name:
                path = name
                break

        if not path:
            print('No paths found in $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS')
            sys.exit(1)

        # $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS is terminated with a \n even with a
        # single entry selected.
        #
        # When a single folder is selected, names[] will have two entries, and the
        # second entry will be empty
        isfolder = lambda n: len(n) == 2 and os.path.isdir(n[0]) and not n[1]

        print "Name: %s" % name
        if isfolder(names):
            print "Name: %s (IS folder)" % name
            # play the selected folder
            folder = name
        else:
            # play the files in the same directory as the selected file
            print "Name: %s (IS NOT folder)" % name
            folder = os.path.dirname(name)
    elif not os.path.isdir(path):
        folder = os.path.dirname(path)
    else:
        folder = path

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

    play_folder(random=ns.random, path=ns.path)
