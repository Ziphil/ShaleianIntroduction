<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
                xmlns:zp="http://ziphil.com/XSL">
  <xsl:output method="xml" indent="no"/>

  <xsl:template name="bookmark-tree">
    <fo:bookmark internal-destination="preface">
      <fo:bookmark-title><xsl:text>初めに</xsl:text></fo:bookmark-title>
    </fo:bookmark>
    <fo:bookmark internal-destination="content-table">
      <fo:bookmark-title><xsl:text>目次</xsl:text></fo:bookmark-title>
    </fo:bookmark>
    <xsl:apply-templates select="/root/part" mode="bookmark-tree"/>
    <fo:bookmark internal-destination="exercise-answer">
      <fo:bookmark-title><xsl:text>演習問題解答</xsl:text></fo:bookmark-title>
    </fo:bookmark>
    <fo:bookmark internal-destination="index">
      <fo:bookmark-title><xsl:text>新出単語一覧</xsl:text></fo:bookmark-title>
    </fo:bookmark>
  </xsl:template>

  <xsl:template match="part" mode="bookmark-tree">
    <xsl:variable name="position" select="position()"/>
    <fo:bookmark internal-destination="part.top-{$position}"
                 starting-state="show">
      <fo:bookmark-title>
        <xsl:text>第 </xsl:text>
        <xsl:number value="$position"/>
        <xsl:text> 部</xsl:text>
      </fo:bookmark-title>
      <xsl:apply-templates select="(following-sibling::section | following-sibling::exercise)[count(preceding-sibling::part) = $position]" mode="bookmark-tree.item"/>
    </fo:bookmark>
  </xsl:template>

  <xsl:template match="section" mode="bookmark-tree.item">
    <fo:bookmark internal-destination="section.top-{count(preceding-sibling::section) + 1}">
      <fo:bookmark-title>
        <xsl:number value="count(preceding-sibling::section) + 1"/>
        <xsl:text>. </xsl:text>
        <xsl:value-of select="zp:plain(title)"/>
      </fo:bookmark-title>
    </fo:bookmark>
  </xsl:template>

  <xsl:template match="exercise" mode="bookmark-tree.item">
    <fo:bookmark internal-destination="exercise.top-{count(preceding-sibling::exercise) + 1}">
      <fo:bookmark-title>
        <xsl:text>演習問題 </xsl:text>
        <xsl:number value="count(preceding-sibling::exercise) + 1"/>
      </fo:bookmark-title>
    </fo:bookmark>
  </xsl:template>

</xsl:stylesheet>