reStructuredText Directives
===========================

:date: 2017-11-12
:summary: ReStructuredText showcase based on
  `official directives documentation <http://docutils.sourceforge.net/docs/ref/rst/directives.html>`_.

Directives have the following syntax::

  +-------+-------------------------------+
  | ".. " | directive type "::" directive |
  +-------+ block                         |
          |                               |
          +-------------------------------+

Admonitions
-----------

.. attention:: First line
  Second line

  - Can have markup
  - Can have more paragraphs

  Just like here

.. caution::
  Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  Quisque eget est eget odio vulputate accumsan.
  Curabitur tincidunt varius venenatis.
  Cras scelerisque sagittis erat vel imperdiet.
  In pretium vitae nibh et dictum.
  Ut et ullamcorper enim.
  Vivamus ultrices, odio vitae dapibus aliquet,
  magna mi iaculis justo, at malesuada neque sem non.

.. danger::
  Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  Quisque eget est eget odio vulputate accumsan.
  Curabitur tincidunt varius venenatis.
  Cras scelerisque sagittis erat vel imperdiet.
  In pretium vitae nibh et dictum.
  Ut et ullamcorper enim.
  Vivamus ultrices, odio vitae dapibus aliquet,
  magna mi iaculis justo, at malesuada neque sem non.

.. error::
  Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  Quisque eget est eget odio vulputate accumsan.
  Curabitur tincidunt varius venenatis.
  Cras scelerisque sagittis erat vel imperdiet.
  In pretium vitae nibh et dictum.
  Ut et ullamcorper enim.
  Vivamus ultrices, odio vitae dapibus aliquet,
  magna mi iaculis justo, at malesuada neque sem non.

.. hint::
  Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  Quisque eget est eget odio vulputate accumsan.
  Curabitur tincidunt varius venenatis.
  Cras scelerisque sagittis erat vel imperdiet.
  In pretium vitae nibh et dictum.
  Ut et ullamcorper enim.
  Vivamus ultrices, odio vitae dapibus aliquet,
  magna mi iaculis justo, at malesuada neque sem non.

.. important::
  Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  Quisque eget est eget odio vulputate accumsan.
  Curabitur tincidunt varius venenatis.
  Cras scelerisque sagittis erat vel imperdiet.
  In pretium vitae nibh et dictum.
  Ut et ullamcorper enim.
  Vivamus ultrices, odio vitae dapibus aliquet,
  magna mi iaculis justo, at malesuada neque sem non.

.. note::
  Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  Quisque eget est eget odio vulputate accumsan.
  Curabitur tincidunt varius venenatis.
  Cras scelerisque sagittis erat vel imperdiet.
  In pretium vitae nibh et dictum.
  Ut et ullamcorper enim.
  Vivamus ultrices, odio vitae dapibus aliquet,
  magna mi iaculis justo, at malesuada neque sem non.

.. tip::
  Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  Quisque eget est eget odio vulputate accumsan.
  Curabitur tincidunt varius venenatis.
  Cras scelerisque sagittis erat vel imperdiet.
  In pretium vitae nibh et dictum.
  Ut et ullamcorper enim.
  Vivamus ultrices, odio vitae dapibus aliquet,
  magna mi iaculis justo, at malesuada neque sem non.

.. warning::
  Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  Quisque eget est eget odio vulputate accumsan.
  Curabitur tincidunt varius venenatis.
  Cras scelerisque sagittis erat vel imperdiet.
  In pretium vitae nibh et dictum.
  Ut et ullamcorper enim.
  Vivamus ultrices, odio vitae dapibus aliquet,
  magna mi iaculis justo, at malesuada neque sem non.

.. admonition:: Are you sure?

  Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  Quisque eget est eget odio vulputate accumsan.
  Curabitur tincidunt varius venenatis.
  Cras scelerisque sagittis erat vel imperdiet.
  In pretium vitae nibh et dictum.
  Ut et ullamcorper enim.
  Vivamus ultrices, odio vitae dapibus aliquet,
  magna mi iaculis justo, at malesuada neque sem non.

Images
------

.. image:: images/sample.png
  :height: 200
  :alt: sample image

Alignment simply should not be used here.

Inline Images
.............

.. |top-image| image:: images/sample.png
  :height: 50
  :alt: sample inline
  :align: top

.. |middle-image| image:: images/sample.png
  :height: 50
  :alt: sample inline
  :align: middle

.. |bottom-image| image:: images/sample.png
  :height: 50
  :alt: sample inline
  :align: bottom

This is an image aligned |top-image| top,
this middle |middle-image| and this bottom |bottom-image|.

With proper ``css`` it works.

Figures
-------

.. figure:: images/sample.png
  :alt: sample figure
  :height: 100

  This is the caption of the figure (a simple paragraph).

  The legend consists of all elements after the caption.  In this
  case, the legend consists of this paragraph and the following
  table:

  +-------------+-----------------------+
  | Symbol      | Meaning               |
  +=============+=======================+
  | A           | Campground            |
  +-------------+-----------------------+
  | B           | Lake                  |
  +-------------+-----------------------+
  | C           | Mountain              |
  +-------------+-----------------------+

This is not part of the figure.

Body Elements
-------------
Topic
.....
.. topic:: Topic Title

    Subsequent indented lines comprise
    the body of the topic, and are
    interpreted as body elements.

Sidebar
.......
.. sidebar:: Sidebar Title
   :subtitle: Optional Sidebar Subtitle

   Subsequent indented lines comprise
   the body of the sidebar, and are
   interpreted as body elements.

Line Block
..........
"To Ma Own Beloved Lassie: A Poem on her 17th Birthday", by
Ewan McTeagle (for Lassie O'Shea):

    .. line-block::

        Lend us a couple of bob till Thursday.
        I'm absolutely skint.
        But I'm expecting a postal order and I can pay you back
            as soon as it comes.
        Love, Ewan.

Parsed Literal Block
....................
Not supported.

Code
....
.. code:: python

  def my_function():
      "just a test"
      print 8/2

Use ``code-block`` instead.

Math
....
.. math::

  α_t(i) = P(O_1, O_2, … O_t, q_t = S_i λ)

Rubric
......
It is a big question mark...

.. rubric:: Something

Epigraph
........
.. epigraph::

   No matter where you go, there you are.

   -- Buckaroo Banzai

Highlights
..........
.. highlights::

  This maybe?

Pull-Quote
..........
.. pull-quote:: This is...
  a pull quote.

Compound Paragraph
..................
.. compound::

   The 'rm' command is very dangerous.  If you are logged
   in as root and enter ::

       cd /
       rm -rf *

   you will erase the entire contents of your file system.

Container
.........
.. container:: custom

   This paragraph might be rendered in a custom way.

Tables
------
Table
.....
.. table:: Truth table for "not"
   :widths: auto

   =====  =====
     A    not A
   =====  =====
   False  True
   True   False
   =====  =====

.. table:: Truth table for "not"
  :widths: 3 10

  =====  =====
    A    not A
  =====  =====
  False  True
  True   False
  =====  =====

``CSV`` Table
.............
.. csv-table:: Frozen Delights!
   :header: "Treat", "Quantity", "Description"
   :widths: 15, 10, 30

   "Albatross", 2.99, "On a stick!"
   "Crunchy Frog", 1.49, "If we took the bones out, it wouldn't be
   crunchy, now would it?"
   "Gannet Ripple", 1.99, "On a stick!"

List Table
..........
.. list-table:: Frozen Delights!
   :widths: 15 10 30
   :header-rows: 1

   * - Treat
     - Quantity
     - Description
   * - Albatross
     - 2.99
     - On a stick!
   * - Crunchy Frog
     - 1.49
     - If we took the bones out, it wouldn't be
       crunchy, now would it?
   * - Gannet Ripple
     - 1.99
     - On a stick!

Document Parts
--------------
Table of Contents
.................
.. contents:: Table of Contents
   :depth: 2

Automatic Section Numbering
...........................
.. sectnum::
  :depth: 3

All the other features are not supported.
