#!usr/bin/bash
# url is $1
# TODO how to keep background terminal clean? pipe to /dev/null?

# ============= get URL ============
# scraper to use
scraper="curl"
# browser to use
browse="lynx"

# get first part of PDF URL
URL="$1"
# get PDF extension
URLappend='v1.pdf'

# concatenate url with extension to get PDF extension
pdfURL="${URL}${URLappend}"


# ============= Download File ============
# XXX don't add to calibre watched directory
tmpDir="/tmp/calibre_books_to_add"
# test if tmp dir exists and make it if not
test -d "$tmpDir" || mkdir -p "$tmpDir"

# filename for where to save text data
# text="/$tmpDir/$URL.txt"
html="/$tmpDir/$URL.html"
pdf="/$tmpDir/$pdfURL"

# $scraper -o "$text" "$URL"
$scraper -o "$html" "$URL"
$scraper -o "$pdf" "$pdfURL"


# get the page in a nice format by letting lynx/w3m/elinks do the work
# "$browse" -dump -hiddenlinks=ignore "$URL" > $text

# ============= Title ============
# get the title
# title=$(\grep 'Title' "$text" | sed -e 's/Title: (.*)/\1/')

# ============= Authors ============
# authors=$(\grep 'Authors:' "$text") 
# authors=$() # TODO put sed commands in parens
# sed -e 's/Authors: (.*)/\1/' # remove 'authors:'
# -e 's/,/&/' # change comma to '&' for calibre
# -e 's/^ //' # strip beginning whitespace
# 's/ $//' # strip ending whitespace
# )

# ============= Tags ============
# tags are 2 lines above title, so get line of title and print out
# line 2 above
# cut on > and replace with commas for tag format
# line=$(grep -n 'Title: ' "$text" | cut -d':' -f 1)
# coerce 'line' to an integer and subtract 2.
# TODO This is a pretty crappy fix and a better one would be
# appreciated.
# declare -i line
# line=$line-2

# TODO figure out how the sed command actually works with pattern
# and holding spaces
# tags=$(sed "$line q;d" "$text" |  gcut --output-delimiter=',' -d'>' -f 1-)



# ============= Cleanup File ============
rm "$text"

# calibredb add --authors "$authors" --tags "$tags" --title "$title"
