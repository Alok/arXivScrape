# arXiv Scrape

## Description

This Python 3 script currently takes a set of arXiv URLs from the abstract page
and adds the PDFs to [calibre](http://calibre-ebook.com/) while setting the
metadata automatically for these attributes (for now):

- title
- authors
- tags (categories in the arXiv, e.g. Mathematics & Geometric Topology)

Support for adding the abstract as a note along with the arXiv ID as a custom
column is also planned.

In addition, support for [mutt](mutt.org) and [newsbeuter](newsbeuter.org) is
also planned, for those of us who get emailed a lot of preprints or use RSS
(basically just the author).

The goal is to make this a true `calibre` plugin, with support for all
platforms and no external dependencies.

## How to Use
Move the script to somewhere on your `$PATH` (run `echo $PATH` if you don't know where that is) and run

`chmod +x exec-scrape.sh`  
`exec-scrape.sh file1 file2`

OR keep track of what folde  r you downloaded this script into and run this *in the folder containing it*:

`chmod +x ./exec-scrape.sh`  
`./exec-scrape.sh file1 file2`

NOTE: `chmod +x ..` only has to be run once. It gives the file executable permission. Also note that if you run the script on the same URL, it will not add duplicates to your calibre library.


## Dependencies
- \*nix System (Mac/Linux or GNU/Linux if you're Richard Stallman)
- Python 3
- Beautiful Soup 4 (get it with `pip install bs4`)
- `calibre`

## Contributing
Any help and criticism (especially criticism) is welcomed. Feel free to send
pull requests. They're *very* appreciated. Any ideas for adding features are
also welcome.
