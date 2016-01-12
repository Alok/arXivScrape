Download pages via wget or curl (probably wget because it can do it recursively)
Scrape HTML for:
    Title
    Authors (separate with &)
    Topic (for tags)
    Parent topic (for tags)
    Abstract (for notes, put citation number at top)
    Import into calibre (calibre CLI)
        add vlib2 tag
    rm HTML page

EXTRA:
- make it work with w3m or elinks by reading a var for browser
- pull abstract (will need more parsing or possibly ripping html since the lines aren't one line. you could use sed and find a way to use ranges)
- run page count on it (find how plugins script works)


PLAN:
wget page
parse html
set vars
run through calibre CLI
rm HTML at end of script

add to newsbeuter macro
(use link as arg for script)

langs to use:
    bash

# EXAMPLE TO PARSE


Mathematics > Geometric Topology # parse tags by separating with '>', calibre ignores spaces or you can trim them anyway with sed ^/$

Title: The Role Of Link Concordance In Knot Concordance # trim 'Title: '

   Authors: Diego Vela # change ',' to '&' and calibre should handle it
   (Submitted on 11 Jan 2016) # set date to this value by trimming '(', ')' and 'Submitted On'

     Abstract: Satellite constructions on a knot can be thought of as taking some strands of a knot and then tying in another
     knot. Using satellite constructions one can construct many distinct isotopy classes of knots. Pushing this further one can
     construct distinct concordance classes of knots which preserve some algebraic invariants. Infection is a generalization of
     satellite operations, which has been previously studies. An infection by a string link can be thought of as grabbing a knot
     at multiple locations and then tying in a link. Cochran, Friedl and Techner showed that any algebraically slice knot is the
     result of infecting a slice knot by a string link [5]. In this paper we use the infection construction to show that there
     exist knots which arise from infections by $n$-component string links that cannot be obtained by infecting along $(n-1)$-
     component string links.

   Comments: 25 pates, 8 figures
   Subjects: Geometric Topology (math.GT)
   Cite as:  arXiv:1601.02555 [math.GT]
             (or arXiv:1601.02555v1 [math.GT] for this version)

## EXAMPLE URL
http://arxiv.org/abs/1601.02555 ->  http://arxiv.org/pdf/1601.02555v1.pdf #append v1.pdf

## vars
- [/] URL (string)
- [/] PDF_URL (string)
- [/] TITLE (string)
- [] authors (list?)
- [] tags (list?)
- [] abstract (string)

## dependencies
lynx
