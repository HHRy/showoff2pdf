showoff2pdf
===========

Using Markdown Prawn, showoff2pdf will try to convert
a ShowOff presentation into a sensible PDF document
ready to print.

At the moment it supports the following features:

  * Bulleted Lists
  * Ordered lists
  * Images (local and remote)
  * Multiple levels of headings
  * Bold,  Italic and Underline text

With partial (and in progress) support for:

  * Code blocks
  * Commandline argument
  * Formatting / Alignment

Requirements
------------

Requires the latest <tt>Prawn</tt> and also requires
<tt>ShowOff</tt>.

Prawn is used to generate the PDFs and ShowOff itself
is used to read the configuration information from the
slideshow and pull in its content from each section.


Installation
------------

      $  sudo gem install prawn --pre
      $  sudo gem install show_off_pdf --pre showoff

Usage
-----

      $  cd /path/to/show_off_presentation
      $  showoff2pdf > presentation.pdf

Known Issues
------------

The following known issues are being worked on

  * Detecting and dealing with code blocks is sketchy
    and inconsistant.
  * Detecting and dealing with commandline blocks is
    sketchy and inconsistant.
  * Images may become corrupt on OS X with some versions
    of Prawn. Your best bet to solve this problem is to
    update to at least Prawn 0.11.1.pre, which is what
    fixed the issue for me.

Bugs
----

Please open an issue here if you encounter a problem with
using showoff2pdf. 
