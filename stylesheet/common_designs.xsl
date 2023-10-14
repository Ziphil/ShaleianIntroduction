<?xml version="1.0" encoding="utf-8"?>


<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
                xmlns:zp="http://ziphil.com/XSL">
  <xsl:output method="xml" indent="no"/>

  <xsl:template name="miscellaneous-header">
    <xsl:param name="text"/>
    <fo:block space-before="8mm"
              space-after="8mm"
              text-align-last="center">
      <fo:inline-container width="70.5mm"
                           height="12.5mm"
                           background-image="url('../document/material/miscellaneous_header.svg')">
        <fo:block font-size="16pt"
                  color="{$border-color}"
                  letter-spacing="0.25em"
                  line-height="12.5mm">
          <xsl:sequence select="zp:enrich($text)"/>
        </fo:block>
      </fo:inline-container>
    </fo:block>
  </xsl:template>

  <xsl:template name="exercise-element-number"> <!-- 1.1em -->
    <xsl:param name="number"/>
    <fo:inline font-family="{$emphasis-font-family}"
               font-size="1.4em"
               font-weight="bold"
               color="{$border-color}"
               line-height="0">
      <fo:inline-container width="0.5em"
                           start-indent="0em"
                           end-indent="0em"
                           text-align-last="center">
        <fo:block>
          <xsl:number value="$number"/>
        </fo:block>
      </fo:inline-container>
      <xsl:text>.</xsl:text>
    </fo:inline>
  </xsl:template>

  <xsl:template name="exercise-item-number"> <!-- 1.4em -->
    <xsl:param name="number"/>
    <fo:inline font-family="{$emphasis-font-family}"
               font-size="1em"
               font-weight="bold"
               color="{$border-color}"
               line-height="0">
      <fo:inline font-size="0.8em"
                 baseline-shift="-0em">
        <xsl:text>(</xsl:text>
      </fo:inline>
      <fo:inline-container width="0.8em"
                           start-indent="0em"
                           end-indent="0em"
                           text-align-last="center"
                           baseline-shift="-0.15em">
        <fo:block>
          <xsl:number value="$number"/>
        </fo:block>
      </fo:inline-container>
      <fo:inline font-size="0.8em"
                 baseline-shift="-0em">
        <xsl:text>)</xsl:text>
      </fo:inline>
    </fo:inline>
  </xsl:template>

  <xsl:template name="left-page-number">
    <fo:block-container margin="0mm"
                        padding="0mm 0mm 0mm 0mm"
                        top="0mm"
                        left="0mm"
                        font-family="{$emphasis-font-family}"
                        font-size="1.1em"
                        font-weight="bold"
                        text-align="left"
                        line-height="1"
                        absolute-position="absolute">
      <fo:block margin="0mm"
                border-left="2.5em + {$bleed-size} {$border-color} solid">
        <fo:inline padding="0em 0em 0em 0.5em">
          <fo:page-number/>
        </fo:inline>
      </fo:block>
    </fo:block-container>
  </xsl:template>

  <xsl:template name="right-page-number">
    <fo:block-container margin="0mm"
                        padding="0mm 0mm 0mm 0mm"
                        top="0mm"
                        right="0mm"
                        font-family="{$emphasis-font-family}"
                        font-size="1.1em"
                        font-weight="bold"
                        text-align="right"
                        line-height="1"
                        absolute-position="absolute">
      <fo:block margin="0mm"
                border-right="2.5em + {$bleed-size} {$border-color} solid">
        <fo:inline padding="0em 0.5em 0em 0em">
          <fo:page-number/>
        </fo:inline>
      </fo:block>
    </fo:block-container>
  </xsl:template>

  <xsl:template match="text()" mode="#all">
    <xsl:sequence select="zp:enrich(replace(., '\n\s+', '&#xA;'))"/>
  </xsl:template>

</xsl:stylesheet>