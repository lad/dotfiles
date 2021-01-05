#!/usr/bin/env python2

import os
import sys
import subprocess


def append_folder():
    print("--append_folder: START")
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

    print("--append_folder: Name: %s" % name)
    if isfolder(names):
        # play the selected folder
        folder = name
    else:
        # play the files in the same directory as the selected file
        folder = os.path.dirname(name)
    print("Folder: %s" % folder)

    entries = os.listdir(folder)
    if entries:
        files = [os.path.join(folder, entry) for entry in entries 
                 if vlc_type(entry)]

    if files:
        cmd = 'vlc --one-instance --playlist-enqueue %s' % ' '.join(
                ['"%s"' % f for f in sorted(files, key=leading_numeric_key)])
    else:
        # append the empty dir
        #cmd = 'vlc --one-instance --playlist-enqueue "%s"' % folder
        cmd = 'notify-send "nothing to append"'

    print("Running: %s" % cmd)
    subprocess.check_output(cmd, shell=True)

    print('--append_folder: END')


VLC_TYPES = ['.mp3', '.wav', '.flac', '.avi', '.flv', '.m4a', '.mkv', '.mp4']
def vlc_type(path):
    return os.path.splitext(path)[1] in VLC_TYPES


# This is a bit dodgy. There is no MAXINT in python3, so these are not
# guaranteed to be greater/less than all possible ints we could encounter.
POS_LARGE_FLOAT = float(sys.maxsize)
NEG_LARGE_FLOAT = float(sys.maxsize) * -1


def leading_numeric_key(key):
    """Use this as the key parameter to sorting functions to sort strings with
       leading numeric values."""

    keyval = None
    try:
        # first treat `key` as a string and attempt to create a float using as
        # much of the string as possible. Keep track of the rest of the key
        # that wasn't used
        for i in range(len(key), -1, -1):
            try:
                keyval = float(key[:i])
                keyrest = key[i:]
                break
            except (ValueError, TypeError):
                pass
    except (ValueError, TypeError):
        pass

    try:
        if keyval is None:
            # failed to treat `key` as a string and convert it to float.
            # Attempt to convert the whole key to a float (may already be a
            # numeric type or convertable to a float)
            keyval = float(key)
            keyrest = ''
    except (ValueError, TypeError):
        pass

    if keyval is not None:
        # Return a tuple of the float type representing the leading numeric
        # value and the rest of the string after the leading numeric value.
        return (keyval, keyrest)

    # we failed to convert `key` to a float, so the first character of its string
    # representation determines whether it falls before or after other keys that
    # may start with numeric values
    skey = str(key)
    if skey and skey[0] > '9':
        # This is a bit dodgy. There is no MAXFLOAT in python3, so this is not
        # guaranteed to be bigger than all possible floats we could encounter.
        # For example: ['b', '{}a'.format(sys.maxsize+1)] will sort 'b' first
        keyval = POS_LARGE_FLOAT
    else:
        keyval = NEG_LARGE_FLOAT

    return (keyval, skey)


if __name__ == '__main__':
    append_folder()
