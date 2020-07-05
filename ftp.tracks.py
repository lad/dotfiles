#!/usr/bin/env python2

import os
import sys
import subprocess
import tempfile
from datetime import datetime

class Main(object):
    TRACKS_DIR=os.path.expandvars('$HOME/Tracks/eurorack noodles/2020')

    PROJECT_DIR="WAV/Drive1/Project01 - Proj Name/"
    LISTING_DATE='Jan  1  2001'

    def __init__(self, args):
        self.song_dir = args[1] if args[1:] else None
        dt = datetime.now()
        # YYYYMMDD
        self.today = '%s%s%s' % (dt.year, dt.month, dt.day)

    def line_to_file(self, line):
        return line.rsplit(self.LISTING_DATE)[-1].strip()

    def listing_to_files(self, listing):
        return [line.rsplit(self.LISTING_DATE)[-1].strip() for line in listing]

    def runftp(self, cmd):
        FTP=["ftp", "192.168.1.11"]
        p2 = subprocess.Popen(FTP, stdin=subprocess.PIPE,
                                   stdout=subprocess.PIPE,
                                   stderr=subprocess.PIPE)
        stdout, stderr = p2.communicate(input=cmd)
        return stdout

    def get_last_song_dir(self):
        CMD = ["cd \"%s\"" % self.PROJECT_DIR,
               'dir']
        listing = self.runftp("\n".join(CMD)).split("\n")
        if '' in listing:
            listing.remove('')
        return self.line_to_file(listing[-1])

    def get_file_list(self, dir_name):
        CMD = ["cd \"%s\"" % self.PROJECT_DIR,
               'cd "%s"' % dir_name,
               'dir']
        listing = self.runftp("\n".join(CMD)).split("\n")
        if '' in listing:
            listing.remove('')
        return self.listing_to_files(listing)

    def choose_track_numbers(self, track_numbers):
        print 'Available Track Numbers:', ' '.join(track_numbers)
        chosen = raw_input('Enter track numbers (separated by space): ').split()
        chosen = ["0" + n if n[0] != '0' and int(n) < 10 else n for n in chosen]
        
        for num_str in chosen:
            if num_str not in track_numbers:
                print "Track number %s not present" % num_str
                sys.exit(1)
        return chosen

    def get_tracks(self, dir_name, chosen_tracks):
        for n in chosen_tracks:
            track = "Track%s.wav" % n
            if os.path.exists(track):
                print "File already exists for %s" % track
                sys.exit(1)

        CMD = ["cd \"%s\"" % self.PROJECT_DIR,
               'cd "%s"' % dir_name,
               'bin']
        for n in chosen_tracks:
            track = "Track%s.wav" % n
            GET_CMD = CMD + ["get %s" % track]
            print "Getting %s" % track
            self.runftp("\n".join(GET_CMD)).split("\n")

    def files_to_track_numbers(self, files):
        return [os.path.splitext(track)[0].rsplit('Track')[-1] for track in files]

    def make_new_dir(self):
        bdir = os.path.join(self.TRACKS_DIR, datetime.now().strftime('%Y%m%d'))
        n = 1
        while True:
            new_dir = '%s-%d' % (bdir, n)
            if not os.path.exists(new_dir):
                break
            n += 1
        os.mkdir(new_dir)
        return new_dir

    def main(self):
        new_dir = self.make_new_dir()
        os.chdir(new_dir)
        #new_dir = os.getcwd()

        if not self.song_dir:
            self.song_dir = self.get_last_song_dir()

        print "New Dir: %s" % new_dir
        print "Using song directory: %s" % self.song_dir

        with open('song_dir', 'w') as fd:
           fd.write(self.song_dir)

        files = self.get_file_list(self.song_dir)
        track_numbers = self.files_to_track_numbers(files)
        chosen_tracks = self.choose_track_numbers(track_numbers)

        print "Chosen tracks: %s" % ' '.join(chosen_tracks)
        self.get_tracks(self.song_dir, chosen_tracks)


if __name__ == '__main__':
    Main(sys.argv).main()
