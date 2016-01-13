#! /usr/bin/python
"""
This module scrapes the arXiv and adds the PDFs and metadata to calibre.
"""
# to download the page
import urllib.request
import tempfile
import sys
import re
import subprocess

# to parse the HTML for its lovely data
from bs4 import BeautifulSoup

def deleteChar(expression, char):
    """ Wrapper to delete a character. """
    return re.sub(char, '', expression)
def swapChar(expression, char, replacementChar):
    """ Wrapper to change a single character in a string. """
    return re.sub(char, replacementChar, expression)

# [/] ============= Download Page =============

for url in sys.argv[1:]:

    f    = urllib.request.urlopen(url)
    htmlData = f.read()
    # tempHTML = tempfile.NamedTemporaryFile(suffix='.html')
    # with open(tempHTML, "wb") as html:
    #     html.write(htmlData)
    # f.close()

    with tempfile.NamedTemporaryFile(suffix='.html') as temp:
        temp.write(htmlData)
        # temp.flush()
        soup = BeautifulSoup(open(temp.name),"html.parser")

# [/] ============= PDF URL =============

    pdf_URL = soup.findAll(attrs={"name": "citation_pdf_url"})
    pdf_URL = pdf_URL[0]
    pdf_URL = pdf_URL['content']
    pdf_URL += ".pdf"

    g    = urllib.request.urlopen(pdf_URL)
    pdfData = g.read()
    # tempPDF = tempfile.NamedTemporaryFile(suffix='.pdf')
#     with open(tempPDF, "wb") as pdf:
# # write the PDF downloaded into our temp PDF file
#         pdf.write(pdfData)

    with tempfile.NamedTemporaryFile(suffix='.pdf') as tempPDF:
        tempPDF.write(pdfData)
        # tempPDF.flush()
    # g.close()

# [/] ============= Get Title =============

    title = soup.findAll(attrs={"name": "citation_title"})[0]['content']
# Strip accents. Sorry guys, but I like my library to be searchable with ASCII.
    title = re.sub("\\'([a-zA-z])", '\1', title)

# [/] ============= Date Published =============

# Convert date to calibre format.
# e.g.: "2016/01/09" -> "2016-01-09"

    date = soup.findAll(attrs={"name": "citation_date"})
    date = date[0]
    date = date['content']
    date = swapChar('/', '-', date)

# [/] ============= arXiv ID =============

    arxivID = soup.findAll(attrs={"name": "citation_arxiv_id"})
    arxivID = arxivID[0]
    arxivID = arxivID['content']

# [/] ============= Get Author =============

    authorList = soup.findAll(attrs={"name": "citation_author"})

# Init list (which is turned into a str later) to fill with
# authors concatenated together.
    authors    = []

# Pre-process each author string and add to list of authors.
    for author in authorList:
        author = author['content']
# Separate parts of names.
        author = author.split(',')

# lastname, firstname -> first, last
        author.reverse()
# Turn list into string with a space in between so words are still separate.
        author = ' '.join(author)

        authors.append(author)

# Fold in '&' for calibre to recognize multiple authors and 'stringify' list.
    authors = ' & '.join(authors)
# Strip accents.
    authors = re.sub("\\'([a-zA-z])", '\1', authors)

# [/] ============= Get Tags =============

# type: BS object -> list -> string
    unformattedTagBSObj  = soup.find_all("div", "subheader")
    unformattedTagList   = unformattedTagBSObj[0]
    unformattedTagStr    = unformattedTagList.get_text()

# Strip newlines and change '>' and '<'  to commas to make calibre
# recognize them as multiple tags.
    tagStr               = deleteChar(unformattedTagStr, '\n')
    tags                 = swapChar(">", ' , ', tagStr)
    tags                 = swapChar("<", ' , ', tagStr)

# Personal tags.
# Remove this line unless you like my tags being added to yours.

    tags                += " , vlib2, arXiv, Research Paper"

# [] ============= Abstract =============

    abstract = soup.find_all("blockquote", "abstract mathjax")
    abstract = abstract[0]
    abstract = abstract.contents[2]

# [] ============= Add to Calibre =============

    subprocess.call(["calibredb", "add", "--authors=%s" %
                     (authors), "--tags=%s" % (tags), "--title=%s"
                     % (title), tempPDF.name])


# Clean up after ourselves.
    # subprocess.call(["rm", "%s" % (temp.name), "%s" % (tempPDF.name)])
