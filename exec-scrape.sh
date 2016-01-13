#!/bin/bash

# test that our required commands and directories in fact exist
if [[ -e /dev/null ]]; then true; else echo "/dev/null does not exist! Are you using Microsoft Windows? This script does not support Windows (yet)."; exit 1; fi
if [[ -e /tmp ]]; then true; else echo "/tmp does not exist! Are you using Microsoft Windows? This script does not support Windows (yet)."; exit 1; fi
command -v python3 >/dev/null 2>&1 || { echo >&2 "I require Python 3 but it's not installed. Install it at https://www.python.org/downloads/"; exit 1; }
command -v python -c 'import pkgutil; print(0 if pkgutil.find_loader("bs4") else "")' > /dev/null 2>&1 || { echo >&2 "I require Beautiful Soup 4 but it's not installed. Install it with the terminal command 'pip install bs4' (don't type the quotes)"; exit 1;}
command -v calibredb >/dev/null 2>&1 || { echo >&2 "I require calibredb but it's not installed. Install it at http://calibre-ebook.com/"; exit 1; }

# This ugly monster that I copied from StackOverflow gets the current working
# directory and watches out for a lot of hazards like symlinks.
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# $@ is all arguments passed to script and is quoted to prevent incorrect word
# splitting. We then redirect STDOUT to /dev/null but not STDERR in case there
# *is* an error.
python3 "$DIR"/arxivScrape.py "$@" 1> /dev/null
