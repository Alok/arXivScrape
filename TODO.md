- run `page count` plugin on each PDF  (find how plugin scripts work)
- create newsbeuter macro for people who get arXiv via RSS (use link as arg for script)


## vars
- [/] url
- [/] pdf_URL
- [/] title
- [/] authors
- [/] tags
- [] abstract

## dependencies
- Beautiful Soup
- Python 3
- calibre and its CLI (`calibredb`)
- Unix system


## assumptions
`/tmp` dir exists
python 3 is installed

- [] add `lxml` for consistent experience OR find the HTML parser used by default
- [] explicitly add HTML parser to silence warnings
- [] add to '/tmp/arxiv-scrape/' rather than in current directory
   - for some reason absolute file paths as attempted here did not work
- [] change shebang to /usr/bin/python3 for those who have it installed
   - figure out how to check if a file/dir exists (and create it if necessary)
- [] use `url.request.urlretrieve` rather than `urlopen`
- [] allow custom tags to be auto-added rather than just mine
- [] bundle into calibre plugin that can look up by arXiv ID or URl
   - [] port to python 2 [:(] as calibre does not support python 3.
- [] make truly-cross platform

