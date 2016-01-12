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

## Dependencies
- \*nix System (Mac/Linux or GNU/Linux if you're Richard Stallman)
- Python 3
- Beautiful Soup 4 (get it with `pip install bs4`)
- `calibre`

## Contributing
Any help and criticism (especially criticism) is welcomed. Feel free to send
pull requests. They're *very* appreciated. Any ideas for adding features are
also welcome.
