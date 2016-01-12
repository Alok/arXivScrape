#! /usr/bin/python

# to download the page
import urllib
import sys
import requests

import re

# to parse the HTML for its lovely data
from bs4 import BeautifulSoup
import bs4
import lxml

# to actually enter data into calibre
import subprocess
import os

# alias functions
soup = bs4.BeautifulSoup(html, 'lxml')
shell = subprocess.call

# [/] ============= Download Page =============
# Python 3 code
import urllib

# # TODO TODO extend to mult args
# for arg in argv[1:]:

arg = sys.argv[1]
# URL name, type: str
url = "%s" % (arg)
pdfUrl=re.sub('/abs/pdf','/pdf/',a)
pdfUrl += '.pdf' # turn into a pdf extension to download

print("downloading with urllib")
# TODO figure out how to make a temp file to store this in /tmp
urllib.request.urlretrieve(url, "/tmp/temp.html")
urllib.request.urlretrieve(url, "/tmp/temp.pdf")

htmlFile = "/tmp/temp.html"
pdfFile = "/tmp/temp.pdf"

str = "temp.html"

# TODO fix 'no tree builder' error
file = BeautifulSoup(open(str), html, 'lxml') # read file into bs4

# [] ============= Download PDF =============
<meta name="citation_pdf_url" content="http://arxiv.org/pdf/1601.02167" />

# [/] ============= get title =============

# type: str
title = file.findAll(attrs={"name":"citation_title"})[0]['content']

# [] ============= Date Published =============

<meta name="citation_date" content="2016/01/09" />

date = file.findAll(attrs={"name": "citation_date"})
date = date[0]
date = date['content']

# [/] ============= arxiv ID =============
id = file.findAll(attrs={"name": "citation_arxiv_id"})
id = id[0]
id = id['content']
# [] ============= URL =============
http://arxiv.org/abs/1601.02167
# to get pdf, change /abs/ to /pdf/ and append '.pdf' at end
http://arxiv.org/pdf/1601.02167.pdf
# TODO learn how to search the damned tree more efficiently
pdfF = file.meta.next_sibling.next_sibling.next_sibling.next_sibling.next_sibling.next_sibling.next_sibling.next_sibling.next_sibling.next_sibling.next_sibling.next_sibling.next_sibling.next_sibling['content']
# [/] ============= get author =============
# TODO filter by meta attr "citation_author" and put into list and iterate over
# it and fold in '&'
# type: list
authorList = file.findAll(attrs={"name": "citation_author"})
# init list (which is turned into a str later) to fill with
# authors concatenated together
authors = []
for author in authorList:
    author = author['content']
    author = author.split(',')
# reverse lastname, firstname
    author.reverse()
# turn list into string with a space in between
    author = ' '.join(sa)
    authors += author
# fold in '&' for calibre to recognize multiple authors
authors = ' & '.join(authors)

# [] ============= get tags =============
unformattedTagBSObj = f.find_all("div", "subheader")
unformattedTagList = unformattedTagBSObj[0]
unformattedTagStr = unformattedTagList.get_text()

# wrapper to 'tr -d' a char
def deleteChar(expression, char):
    return re.sub(char, '', expression)

# strip newlines
tagStr = re.sub("\n", '', unformattedTagStr)
# change > to comma to make calibre recognize multiple tags
tags = re.sub(">|<", ' , ', tagStr)



# [] ============= abstract =============

"""<blockquote class="abstract mathjax"> <span
class="descriptor">Abstract:</span> The conormal Lagrangian $L_K$
of a knot $K$ in $\mathbb{R}^3$ is the submanifold of the
cotangent bundle $T^* \mathbb{R}^3$ consisting of covectors along
$K$ that annihilate tangent vectors to $K$. By intersecting with
the unit cotangent bundle $S^* \mathbb{R}^3$, one obtains the unit
conormal $\Lambda_K$, and the Legendrian contact homology of
$\Lambda_K$ is a knot invariant of $K$, known as knot contact
homology. We define a version of string topology for strings in
$\mathbb{R}^3 \cup L_K$ and prove that this is isomorphic in
degree 0 to knot contact homology. The string topology perspective
gives a topological derivation of the cord algebra (also
isomorphic to degree 0 knot contact homology) and relates it to
the knot group. Together with the isomorphism this gives a new
proof that knot contact homology detects the unknot. Our
techniques involve a detailed analysis of certain moduli spaces of
holomorphic disks in $T^* \mathbb{R}^3$ with boundary on
$\mathbb{R}^3 \cup L_K$. </blockquote>"""

# [] ============= Add to Calibre =============


shell(["calibredb", "--authors", "--tags", "--title"])
# TODO un hardcode htmlFile pdfFile and deal with spaces and tabs in filenames
shell(["rm htmlFile pdfFile ", "", "--tags", "--title"])
# TODO figure out how to extract ID from calibre
# TODO extend this to multiple urls in one command invocation by looping over them

# f.find_all('meta')

[<meta content="Knot contact homology, string topology, and the cord
 algebra" name="citation_title"/>,
 <meta content="Cieliebak, Kai" name="citation_author"/>,
 <meta content="Ekholm, Tobias" name="citation_author"/>,
 <meta content="Latschev, Janko" name="citation_author"/>,
 <meta content="Ng, Lenhard" name="citation_author"/>,
 <meta content="2016/01/09" name="citation_date"/>,
 <meta content="2016/01/09" name="citation_online_date"/>,
 <meta content="http://arxiv.org/pdf/1601.02167" name="citation_pdf_
 url"/>,
 <meta content="1601.02167" name="citation_arxiv_id"/>]
