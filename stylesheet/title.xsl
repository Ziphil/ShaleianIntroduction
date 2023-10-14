<?xml version="1.0" encoding="utf-8"?>


<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
                xmlns:zp="http://ziphil.com/XSL">
  <xsl:output method="xml" indent="no"/>
  <xsl:strip-space elements="description"/>

  <xsl:param name="title.page-top-space" select="'20mm'"/>
  <xsl:param name="title.page-bottom-space" select="'20mm'"/>

  <!-- page-master ============================================================================= -->

  <xsl:template name="title.page-master">
    <fo:simple-page-master master-name="title.left"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm">
      <fo:region-body region-name="title.body"
                      margin-top="{$title.page-top-space} + {$bleed-size}"
                      margin-right="{$page-inner-space} + {$bleed-size}"
                      margin-bottom="{$title.page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-outer-space} + {$bleed-size}"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="title.right"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm">
      <fo:region-body region-name="title.body"
                      margin-top="{$title.page-top-space} + {$bleed-size}"
                      margin-right="{$page-outer-space} + {$bleed-size}"
                      margin-bottom="{$title.page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-inner-space} + {$bleed-size}"/>
    </fo:simple-page-master>
    <fo:page-sequence-master master-name="title">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference master-reference="title.left" 
                                              odd-or-even="even"/>
        <fo:conditional-page-master-reference master-reference="title.right" 
                                              odd-or-even="odd"/>
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>
  </xsl:template>

  <!-- main-tag ================================================================================ -->

  <xsl:template match="title">
    <fo:page-sequence master-reference="title"
                      initial-page-number="1"
                      force-page-count="even"
                      format="a">
      <fo:flow flow-name="title.body">
        <fo:block>
          <xsl:call-template name="title.title"/>
          <xsl:call-template name="title.author"/>
        </fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>

  <!-- tag ===================================================================================== -->

  <xsl:template name="title.title">
    <fo:block margin="55mm 0mm 0mm 0mm"
              font-size="24pt"
              line-height="1"
              text-align="center">
      <fo:inline>
        <xsl:text>入門 シャレイア語</xsl:text>
      </fo:inline>
    </fo:block>
  </xsl:template>

  <xsl:template name="title.author">
    <fo:block margin="6mm 0mm 0mm 0mm"
              font-size="12pt"
              line-height="1"
              text-align="center">
      <fo:inline>
        <xsl:text>Ziphil Shaleiras</xsl:text>
      </fo:inline>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>