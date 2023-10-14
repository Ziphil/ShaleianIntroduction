<?xml version="1.0" encoding="utf-8"?>


<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
                xmlns:zp="http://ziphil.com/XSL">
  <xsl:output method="xml" indent="no"/>
  <xsl:strip-space elements="description"/>

  <xsl:param name="part.page-top-space" select="'20mm'"/>
  <xsl:param name="part.page-bottom-space" select="'20mm'"/>

  <!-- page-master ============================================================================= -->

  <xsl:template name="part.page-master">
    <fo:simple-page-master master-name="part.right"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm"
                           background-image="url('../document/material/part.svg')"
                           background-position-horizontal="{$bleed-size}"
                           background-position-vertical="{$bleed-size}">
      <fo:region-body region-name="part.body"
                      margin-top="{$part.page-top-space} + {$bleed-size}"
                      margin-right="{$page-outer-space} + {$bleed-size}"
                      margin-bottom="{$part.page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-inner-space} + {$bleed-size}"/>
      <fo:region-before region-name="part.right-header"
                        extent="{$bleed-size}"
                        precedence="true"/>
    </fo:simple-page-master>
    <fo:page-sequence-master master-name="part">
      <fo:single-page-master-reference master-reference="part.right"/>  
    </fo:page-sequence-master>
  </xsl:template>

  <!-- main-tag ================================================================================ -->

  <xsl:template match="part">
    <fo:page-sequence master-reference="part"
                      initial-page-number="auto-odd">
      <fo:static-content flow-name="part.right-header">
        <fo:block-container id="part.top-{count(preceding-sibling::part) + 1}"/>
      </fo:static-content>
      <fo:flow flow-name="part.body">
        <fo:block>
          <xsl:call-template name="part.number"/>
          <xsl:apply-templates select="description" mode="part"/>
        </fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>

  <!-- tag ===================================================================================== -->

  <xsl:template name="part.number">
    <fo:block margin="38mm 0mm 0mm 0mm"
              font-size="25pt"
              color="{$border-color}"
              text-align="center">
      <fo:inline baseline-shift="1mm">
        <xsl:text>第</xsl:text>
      </fo:inline>
      <fo:inline margin="0em 0.4em 0em 0.4em"
                 font-family="{$emphasis-font-family}"
                 font-size="3em"
                 font-weight="bold">
        <xsl:number value="count(preceding-sibling::part) + 1" format="1"/>
      </fo:inline>
      <fo:inline baseline-shift="1mm">
        <xsl:text>部</xsl:text>
      </fo:inline>
    </fo:block>
  </xsl:template>

  <xsl:template match="description" mode="part">
    <fo:block space-before="15mm"
              start-indent="7mm"
              end-indent="7mm"
              line-height="{$line-height} * 1.1"
              text-align="justify"
              axf:text-justify-trim="punctuation ideograph inter-word"
              linefeed-treatment="ignore">
      <xsl:apply-templates mode="part.description"/>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>