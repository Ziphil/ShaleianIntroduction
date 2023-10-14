<?xml version="1.0" encoding="utf-8"?>


<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
                xmlns:zp="http://ziphil.com/XSL">
  <xsl:output method="xml" indent="no"/>

  <xsl:param name="europian-font-family" select="'Brill'"/>
  <xsl:param name="japanese-font-family" select="'Yu Mincho'"/>
  <xsl:param name="symbol-font-family" select="'IPA明朝'"/>
  <xsl:param name="europian-shaleia-font-family" select="'Inter'"/>
  <xsl:param name="japanese-shaleia-font-family" select="'Yu Gothic Medium'"/>
  <xsl:param name="emphasis-font-family" select="'Gill Sans Nova Cn Book'"/>
  <xsl:param name="font-size" select="'9pt'"/>
  <xsl:param name="shaleia-font-size" select="'100%'"/>
  <xsl:param name="line-height" select="'1.5'"/>
  <xsl:param name="close-line-height" select="'1.3'"/>
  <xsl:param name="border-color" select="'#444444'"/> <!-- rgb(140, 255, 85) -->
  <xsl:param name="background-color" select="'#DDDDDD'"/> <!-- rgb(140, 255, 221) -->
  <xsl:param name="light-background-color" select="'#FFFFFF'"/>
  <xsl:param name="page-width" select="'148mm'"/>
  <xsl:param name="page-height" select="'210mm'"/>
  <xsl:param name="page-top-space" select="'15mm'"/>
  <xsl:param name="page-bottom-space" select="'23mm'"/>
  <xsl:param name="page-inner-space" select="'23mm'"/>
  <xsl:param name="page-outer-space" select="'17mm'"/>
  <xsl:param name="footer-extent" select="'15mm'"/>
  <xsl:param name="bleed-size" select="'3mm'"/>
  <xsl:param name="maximum-ratio" select="'1.4'"/>
  <xsl:param name="minimum-ratio" select="'0.8'"/>
  <xsl:param name="bordered-space-ratio" select="'1.5'"/>
  <xsl:param name="border-width" select="'0.2mm'"/>
  <xsl:param name="thick-border-width" select="'0.5mm'"/>
  <xsl:param name="thin-border-width" select="'0.2mm'"/>

  <xsl:param name="font-family" select="concat($europian-font-family, ', ', $japanese-font-family)"/>
  <xsl:param name="shaleia-font-family" select="concat($europian-shaleia-font-family, ', ', $japanese-shaleia-font-family)"/>

  <xsl:include href="bookmark_tree.xsl"/>
  <xsl:include href="section.xsl"/>
  <xsl:include href="exercise.xsl"/>
  <xsl:include href="part.xsl"/>
  <xsl:include href="title.xsl"/>
  <xsl:include href="preface.xsl"/>
  <xsl:include href="content_table.xsl"/>
  <xsl:include href="exercise_answer.xsl"/>
  <xsl:include href="index.xsl"/>
  <xsl:include href="colophon.xsl"/>
  <xsl:include href="blank.xsl"/>
  <xsl:include href="common_designs.xsl"/>
  <xsl:include href="functions.xsl"/>

  <xsl:template match="/root">
    <fo:root xml:lang="ja"
             font-family="{$font-family}"
             font-size="{$font-size}"
             font-variant="lining-nums"
             axf:ligature-mode="all">
      <fo:layout-master-set>
        <xsl:call-template name="section.page-master"/>
        <xsl:call-template name="exercise.page-master"/>
        <xsl:call-template name="part.page-master"/>
        <xsl:call-template name="title.page-master"/>
        <xsl:call-template name="preface.page-master"/>
        <xsl:call-template name="content-table.page-master"/>
        <xsl:call-template name="exercise-answer.page-master"/>
        <xsl:call-template name="index.page-master"/>
        <xsl:call-template name="colophon.page-master"/>
        <xsl:call-template name="blank.page-master"/>
      </fo:layout-master-set>
      <fo:bookmark-tree>
        <xsl:call-template name="bookmark-tree"/>
      </fo:bookmark-tree>
      <xsl:apply-templates/>
    </fo:root>
  </xsl:template>

</xsl:stylesheet>