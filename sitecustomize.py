import readline
import atexit
import os

#
# This is in place for PDB. It seems to work and doesn't interfere with the
# python3 interactive prompt.
#

# Load readline settings from ~/.inputrc
readline.read_init_file(os.path.expanduser("~/.inputrc"))

# Save the history to a file
history_file = os.path.expanduser("~/.pdb_history")
try:
    readline.read_history_file(history_file)
except FileNotFoundError:
    pass

atexit.register(readline.write_history_file, history_file)

# This not needed?
#readline.set_startup_hook(lambda: readline.set_completer(rlcompleter.Completer().complete))

# Enable tab completion
readline.parse_and_bind("tab: complete")
