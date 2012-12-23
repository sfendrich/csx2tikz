<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
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
-->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:strip-space elements="*"/>
<xsl:output method="text"/>

<!-- Declare styles for nodes and labels. -->
<xsl:template match="/">
% include \usetikzlibrary{positioning} in preamble
\tikzstyle{concept}=[circle,draw=black,thick]
\tikzstyle{alabel}=[rectangle,draw=black,fill=white,anchor=south,node distance=0,inner sep=0.2ex,font=\tiny]
\tikzstyle{olabel}=[rectangle,draw=black,fill=white,anchor=north,node distance=0,inner sep=0.2ex,font=\tiny]
  <xsl:apply-templates/>
</xsl:template>

<!-- Create a tikzpicture for each diagram. -->
<xsl:template match="diagram">
\begin{tikzpicture}[scale=0.02]
  % Concepts
  <xsl:for-each select="node">\node[concept] (con<xsl:value-of select="@id"/>) at (<xsl:value-of select="position/@x"/>,<xsl:value-of select="-position/@y"/>){};
  </xsl:for-each>
  % Lines
  <xsl:for-each select="edge">\draw (con<xsl:value-of select="@from"/>)--(con<xsl:value-of select="@to"/>);
  </xsl:for-each>
  % Attribute labels
  <xsl:for-each select="node">
    <xsl:apply-templates select="concept/attributeContingent"/>
  </xsl:for-each>
  % Object labels
  <xsl:for-each select="node">
    <xsl:apply-templates select="concept/objectContingent"/>
  </xsl:for-each>
\end{tikzpicture}
</xsl:template>

<!-- Make a label for the attribute contingent -->
<xsl:template match="concept/attributeContingent">
  <xsl:if test="attribute">\node[alabel,above=of con<xsl:value-of select="../../@id"/>,xshift=<xsl:value-of select="../../attributeLabelStyle/offset/@x"/>,yshift=<xsl:value-of select="-../../attributeLabelStyle/offset/@y"/>] (int<xsl:value-of select="../../@id"/>) {\begin{tabular}{@{}l@{}}<xsl:for-each select="attribute"><xsl:value-of select="."/>\\</xsl:for-each>\end{tabular}}; 
  \draw[dashed] (con<xsl:value-of select="../../@id"/>)--(int<xsl:value-of select="../../@id"/>);
  </xsl:if>
</xsl:template>

<!-- Make a label for the object contingent -->
<xsl:template match="concept/objectContingent">
  <xsl:if test="object">\node[olabel,below=of con<xsl:value-of select="../../@id"/>,xshift=<xsl:value-of select="../../objectLabelStyle/offset/@x"/>,yshift=<xsl:value-of select="-../../objectLabelStyle/offset/@y"/>] (ext<xsl:value-of select="../../@id"/>) {\begin{tabular}{@{}l@{}}<xsl:for-each select="object"><xsl:value-of select="."/>\\</xsl:for-each>\end{tabular}}; 
  \draw[dashed] (con<xsl:value-of select="../../@id"/>)--(ext<xsl:value-of select="../../@id"/>);
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
