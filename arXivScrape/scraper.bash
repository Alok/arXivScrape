#!usr/bin/bash
# url is $1
# TODO how to keep background terminal clean? pipe to /dev/null?

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


# don't add to calibre watched directory
tmpDir="/tmp/calibre_books_to_add"
# test if tmp dir exists and make it if not
test -d "$tmpDir" || mkdir -p "$tmpDir"

# filename for where to save text data
text="/$tmpDir/$URL.txt"

# get the page in a nice format by letting lynx/w3m/elinks do the work
"$browse" -dump -hiddenlinks=ignore "$URL" > $text

# get the title
title=$(\grep 'Title' "$text" | sed -e 's/Title: (.*)/\1/')
authors=$(\grep 'Authors:' "$text") 
title=$() # TODO put sed commands in parens
sed -e 's/Authors: (.*)/\1/' # remove 'authors:'
-e 's/,/&/' # change comma to '&' for calibre
-e 's/^ //' # strip beginning whitespace
's/ $//' # strip ending whitespace
)

tags



$scraper -o "$tmpDir"/"$title".pdf "$pdfURL"

# cleanup file
rm "$text"

calibredb add --authors "$authors" --tags "$tags" --title "$title"
