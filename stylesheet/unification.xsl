<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="no"/>

  <xsl:param name="full" select="true()"/>

  <xsl:template match="/root">
    <root>
      <xsl:apply-templates/>
    </root>
  </xsl:template>

  <xsl:template match="import">
    <xsl:if test="not(@full) or $full">
      <xsl:copy-of select="document(@src)"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*">
    <xsl:if test="not(@full) or $full">
      <xsl:copy-of select="."/>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>