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
  <xsl:param name="refentry.generate.name" select="0"/>
  <xsl:param name="man.output.quietly" select="1"/>
  <xsl:param name="funcsynopsis.style" select="ansi"/>
  <xsl:param name="man.authors.section.enabled" select="0"/>
  <xsl:param name="man.copyright.section.enabled" select="0"/>
  <xsl:param name="html.stylesheet">bus1.css</xsl:param>

  <!-- Add page header. -->
  <xsl:template name="user.head.content">
    <link rel="icon" href="bus1.png" type="image/png"/>
    <script>
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
      ga('create', 'UA-75729104-1', 'auto');
      ga('send', 'pageview');
    </script>
  </xsl:template>

  <xsl:template name="user.header.content">
    <header>
      <a>
        <xsl:attribute name="href">
          <xsl:text>index.html</xsl:text>
        </xsl:attribute>
        <img src="bus1.svg" alt="bus1" style="width:64px;height:64px;"/>
      </a>

      <span class="version">
        <xsl:text>Version </xsl:text>
        <xsl:value-of select="$bus1.version"/>
      </span>
    </header>
  </xsl:template>

  <!-- Translate references to links. -->
  <xsl:template match="citerefentry">
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="refentrytitle"/>
        <xsl:text>.html</xsl:text>
      </xsl:attribute>
      <xsl:call-template name="inline.charseq"/>
    </a>
  </xsl:template>

  <!-- External links. -->
  <xsl:template match="citerefentry[refentrytitle='close'] |
                       citerefentry[refentrytitle='epoll'] |
                       citerefentry[refentrytitle='ioctl'] |
                       citerefentry[refentrytitle='mmap'] |
                       citerefentry[refentrytitle='munmap'] |
                       citerefentry[refentrytitle='open'] |
                       citerefentry[refentrytitle='poll'] |
                       citerefentry[refentrytitle='ppoll'] |
                       citerefentry[refentrytitle='pselect'] |
                       citerefentry[refentrytitle='select']">
    <a>
      <xsl:attribute name="href">
        <xsl:text>http://linux.die.net/man/</xsl:text>
        <xsl:value-of select="manvolnum"/>
        <xsl:text>/</xsl:text>
        <xsl:value-of select="refentrytitle"/>
      </xsl:attribute>
      <xsl:call-template name="inline.charseq"/>
    </a>
  </xsl:template>
</xsl:stylesheet>
