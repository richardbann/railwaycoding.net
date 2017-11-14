Quickstart
==========

:date: 2017-11-11
:summary: ReStructuredText showcase based on
  http://docutils.sourceforge.net/docs/user/rst/quickstart.html

  Some extra markup can go to summary, here we provide a minimal ``python`` code:

  .. code-block:: python

    import os
    sys.environ.get('ENV_VAR', '')


Structure (of ``ReStructuredText``)
-----------------------------------
This is a paragraph.  It's quite
short.

   This paragraph will result in an indented block of
   text, typically used for quoting other text.

This is another one.

Text styles
-----------
This is how to use *italics* and **bold** text.
This markup can not be used in ``fixed-space literals (*not italic*)``.
Use backslash for \*text\* that would otherwise be processed.

Lists
-----
Enumerated Lists
................
1. numbers

A. upper-case letters
   and it goes over many lines

   with two paragraphs and all!

a. lower-case letters

   3. with a sub-list starting at a different number
   4. make sure the numbers are in the correct sequence though!

I. upper-case roman numerals

i. lower-case roman numerals

(1) numbers again

1) and again

Bulleted Lists
..............
* a bullet point using "*"

  - a sub-list using "-"

    + yet another sub-list

  - another item

Preformatting
-------------
An example::

    Whitespace, newlines, blank lines, and all kinds of markup
      (like *this* or \this) is preserved by literal blocks.
  Lookie here, I've dropped an indentation level
  (but not far enough)

no more example

::

    This is preformatted text, and the
    last "::" paragraph is removed

Images
------
.. image:: images/sample.png
  :alt: sample image

This is too big. This is how we can reduce the size - set ``height``:

.. image:: images/sample.png
  :alt: sample image
  :height: 300px

or set ``width``:

.. image:: images/sample.png
  :alt: sample image
  :width: 300px

or set both:

.. image:: images/sample.png
  :alt: sample image
  :width: 300px
  :height: 300px
