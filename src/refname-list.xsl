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

<!--
  Print the list of refname aliases to create symlinks from.

  $ xsltproc -nonet -xinclude src/refname-list.xsl src/bus1_client_new_from_fd.xml
  bus1_client_new_from_fd bus1_client_new_from_path
  bus1_client_new_from_fd bus1_client_free
  bus1_client_new_from_fd bus1_client_get_fd
  bus1_client_new_from_fd bus1_client_get_pool_size
  bus1_client_new_from_fd bus1_client_get_pool
  bus1_client_new_from_fd bus1_client_ioctl
  bus1_client_new_from_fd bus1_client_query
  bus1_client_new_from_fd bus1_client_mmap
  bus1_client_new_from_fd bus1_client_init
  bus1_client_new_from_fd bus1_client_clone
  bus1_client_new_from_fd bus1_client_node_destroy
  bus1_client_new_from_fd bus1_client_handle_release
  bus1_client_new_from_fd bus1_client_slice_release
  bus1_client_new_from_fd bus1_client_slice_from_offset
  bus1_client_new_from_fd bus1_client_slice_to_offset
  bus1_client_new_from_fd bus1_client_slice_release
  bus1_client_new_from_fd bus1_client_slice_from_offset
  bus1_client_new_from_fd bus1_client_slice_to_offset
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text"/>
  <xsl:template match="/">
    <xsl:for-each select="refentry/refnamediv/refname">
      <xsl:if test="not(/refentry/refmeta/refentrytitle=.)">
        <xsl:value-of select="/refentry/refmeta/refentrytitle"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>&#xa;</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
