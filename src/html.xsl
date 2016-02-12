<?xml version='1.0'?> <!--*-nxml-*-->

<!--
  This file is part of bus1. See COPYING for details.

  bus1 is free software; you can redistribute it and/or modify it
  under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation; either version 2.1 of the License, or
  (at your option) any later version.

  bus1 is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with bus1; If not, see <http://www.gnu.org/licenses/>.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl"/>
  <xsl:output method="html" encoding="UTF-8" indent="no"/>
  <xsl:param name="generate.consistent.ids" select="1"/>

  <!-- Translate references to links. -->
  <xsl:template match="citerefentry">
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="refentrytitle"/><xsl:text>.html#</xsl:text>
        <xsl:value-of select="refentrytitle/@target"/>
      </xsl:attribute>
      <xsl:call-template name="inline.charseq"/>
    </a>
  </xsl:template>

  <!-- Add page header. -->
  <xsl:template name="user.header.content">
    <a>
      <xsl:attribute name="href">
        <xsl:text>index.html</xsl:text>
      </xsl:attribute>
      <img src="bus1.png" alt="bus1" style="width:48px;height:48px;"/>
    </a>

    <span style="float:right">
      <xsl:text>Version </xsl:text>
      <xsl:value-of select="$bus1.version"/>
    </span>
    <hr/>
  </xsl:template>

</xsl:stylesheet>
