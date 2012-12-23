csx2tikz
========

csx2tikz - convert line diagrams from csx to tikz.

Copyright (C) 2012 Sascha Fendrich

This file is part of csx2tikz.

csx2tikz is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

csx2tikz is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with csx2tikz.  If not, see <http://www.gnu.org/licenses/>.


Description
----------- 

csx2tikz.xsl is a XSLT-transformation allowing to convert
conceptual diagrams from ToscanaJ's .csx format into TikZ
for further processing with LaTeX.


Usage
-----

csx2tikz.xsl can be used with any xslt processor, e.g.
xsltproc outputs the LaTeX code to standard output:

    xsltproc csx2tikz.xsl diagram.csx > diagram.tex

To use the resulting code with LaTeX it should be included
(preferably inside a figure-block) into a LaTeX document
that loads the TikZ package. A minimal working example is:

    \documentclass{article}
    \usepackage{tikz}
    \usetikzlibrary{positioning}
    \begin{document}
    \include{diagram}
    \end{document}

The concept nodes and the object and attribute labels
are set as TikZ nodes with different styles named 'concept',
'alabel', and 'olabel', respectively. This way, the layout
of the three node types can easily be changed by modifying
the corresponding \tikzstyle declarations.


Known issues
------------ 

 * The object and attribute labels are copied as they are.
   Therefore, if they contain special LaTeX-symbols the
   resulting LaTeX code may produce errors or unexpected
   results when compiled with LaTeX.
 * On large lists of object or attribute labels LaTeX
   complains with a 'Dimension too large' error. 

  
References
----------

 * ToscanaJ: <http://toscanaj.sourceforge.net/>
 * TikZ: <http://sourceforge.net/projects/pgf/>
 * LaTeX: <http://www.latex-project.org/>
 * Xsltproc: <http://xmlsoft.org/XSLT/xsltproc2.html>

