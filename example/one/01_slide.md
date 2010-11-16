!SLIDE 
.notes It even parses out slide notes when entered all on one line with the notes class. Try it out!
# Introducing showoff2pdf #

* Uses on Prawn to dynamically generate PDF
  files form Markdown Slides
* Favours sensible defaults to make readable
  and printable documents 
* Just depends on Ruby and Prawn (--pre)
* Based on my Markdown Prawn library

!SLIDE 
#Supported features#

![images](./images.png)

##Multi
###Level
####Headings

!SLIDE 
#Supported features continued

    $ cat slide.md | ./md2pdf > slide.pdf 
    $ formatting for command line segments
    

!SLIDE 
.notes I'm  happy to accept any patches for this; so please get in touch. There's still a lot that needs to be done!
# What doesn't work #

* Custom CSS styles and the like will not be
  preserved, if you want that, then use Prince
* For obvious reasons, executing Ruby or JavaScript
  won't work.
* A lot of inline HTML will be silently dropped.
