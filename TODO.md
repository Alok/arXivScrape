## Features to add
- [] run `page count` plugin on each PDF  (find how plugin scripts work)
- [] create `newsbeuter` macro for people who get arXiv via RSS (use link as arg for script)
- [] create `mutt` macro
- [] pull abstract
- [/] explicitly add HTML parser to silence warnings
- [] add `lxml` for consistent experience OR find the HTML parser used by default
- [] add to '/tmp/arxivScrape/' rather than in current directory
   - for some reason absolute file paths as attempted here did not work
- [] change shebang to /usr/bin/python3 for those who have it installed
   - figure out how to check if a file/dir exists (and create it if necessary)
- [] use `url.request.urlretrieve` rather than `urlopen`
- [] allow custom tags to be auto-added rather than just mine
- [] bundle into calibre plugin that can look up by arXiv ID or URl
   - [] port to python 2 [:(] as calibre does not support python 3.
- [] make truly-cross platform
- [] add javascript snippet for [chromium vim](https://github.com/1995eaton/chromium-vim) to execute on arXiv pages
- [] package external dependencies (use virtualenv)
- [/] UN-HARD-CODE everything. Whoever reads this, bug me about it.
- [] add `setup.py` file to handle dependencies
- [] add `if __name__ == '__main__:'`
      urls = sys.argv[1:]
      some_function(urls)
- [] separate into several files to run each part? (downloading and parsing)

## Assumptions
- beautiful soup 4 is installed
- python 2 is installed

