# FIXME change to /usr/bin for those who don't have homebrew python3
#! /usr/local/bin/python3
"""
This module scrapes the arXiv and adds the PDFS and metadata to calibre.
"""
# to download the page
import urllib.request
import sys
import re

# to parse the HTML for its lovely data
from bs4 import BeautifulSoup
# import lxml

# to actually enter data into calibre
import subprocess

# alias functions
# soup = bs4.BeautifulSoup(html, 'lxml')

def deleteChar(expression, char):
    """ wrapper to 'tr -d' a char """
    return re.sub(char, '', expression)

# [/] ============= Download Page =============

# # TODO TODO extend to mult args
# for arg in argv[1:]:
for url in sys.argv[1:]:
# TODO figure out how to make a temp file to store this in /tmp

# htmlFile = 'temp.html'
# urllib.request.urlretrieve(url)
f    = urllib.request.urlopen(url)
data = f.read()
with open('code.html', "wb") as code:
    code.write(data)

# TODO fix 'no tree builder' error
# soup = BeautifulSoup(open(filename), html, 'lxml')

# read file into bs4
soup = BeautifulSoup(open('code.html'))

# [/] ============= PDF URL =============
pdf_URL = soup.findAll(attrs={"name": "citation_pdf_url"})
pdf_URL = pdf_URL[0]
pdf_URL = pdf_URL['content']
pdf_URL += ".pdf"

# pdfFile = "/tmp/temp.pdf"
# urllib.request.urlretrieve(pdf_URL, pdfFile)
# urllib.request.urlretrieve(pdf_URL, "/tmp/temp.pdf")

g    = urllib.request.urlopen(pdf_URL)
data = g.read()
with open('code.pdf', "wb") as code:
    code.write(data)

# [/] ============= Get Title =============

# type: str
title = soup.findAll(attrs={"name": "citation_title"})[0]['content']

# [/] ============= Date Published =============

# TODO convert date to calibre format
# format = "2016/01/09"

date = soup.findAll(attrs={"name": "citation_date"})
date = date[0]
date = date['content']

# [/] ============= arXiv ID =============

arxivID = soup.findAll(attrs={"name": "citation_arxiv_id"})
arxivID = arxivID[0]
arxivID = arxivID['content']

# [/] ============= Get Author =============

# type: list
authorList = soup.findAll(attrs={"name": "citation_author"})

# init list (which is turned into a str later) to fill with
# authors concatenated together
authors = []

# pre-process each author string and add to list of authors
for author in authorList:
    author = author['content']
# separate parts of names
    author = author.split(',')

# lastname, firstname -> first, last
    author.reverse()
    # print (author)
# turn list into string with a space in between so words are still separate
    author = ' '.join(author)

# add to rest of authors
    authors.append(author)

# fold in '&' for calibre to recognize multiple authors and 'stringify' list
authors = ' & '.join(authors)

# [/] ============= Get Tags =============

# type: BS object
unformattedTagBSObj = soup.find_all("div", "subheader")
# type: list
unformattedTagList = unformattedTagBSObj[0]
# type: string
unformattedTagStr = unformattedTagList.get_text()

# strip newlines
# tagStr = re.sub("\n", '', unformattedTagStr)
tagStr = deleteChar(tagStr, '\n')

# change > to comma to make calibre recognize multiple tags
tags = re.sub(">|<", ' , ', tagStr)

# personal tags
# XXX remove this line unless you like my tags being added to yours.

tags += " , vlib2, arXiv, Research Paper"

# [] ============= Abstract =============
abstract = soup.find_all("blockquote", "abstract mathjax")
abstract = abstract[0]
# type: str (with lots of newlines
# TODO do the newlines break passing them in the command line?
abstract = abstract.contents[2]

# [] ============= Add to Calibre =============
# do the dollar signs in the latex names break things?

# print (authors)
# print (tags)
# print (title)
# print (title)

# TODO unhardcode this
subprocess.call(["calibredb", "add", "--authors=%s" % (authors), "--tags=%s" % (tags), "--title=%s" % (title), 'code.pdf'])
# subprocess.call("calibredb add --authors=%s  --tags=%s --title=%s %s" % (authors, tags, title, 'code.pdf'), shell=True)

# TODO un hardcode htmlFile pdfFile and deal with spaces and tabs in filenames

# clean up after ourselves
# subprocess.call(["rm %s %s" %(htmlFile, pdfFile)])
subprocess.call(["rm", "code.html", "code.pdf"])
# subprocess.call(["rm %s %s" %('code.pdf', 'code.html')], shell=True)

# TODO extend this to multiple urls in one command invocation by
# looping over them
