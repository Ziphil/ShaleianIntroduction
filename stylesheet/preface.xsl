<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
                xmlns:zp="http://ziphil.com/XSL">
  <xsl:output method="xml" indent="no"/>

  <xsl:param name="preface.large-space" select="'1em'"/> <!-- 日付の直前 -->
  <xsl:param name="preface.small-space" select="'0.3em'"/> <!-- 段落間 -->

  <!-- page-master ============================================================================= -->

  <xsl:template name="preface.page-master">
    <fo:simple-page-master master-name="preface.left"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm"
                           background-image="url('material/blank.svg')">
      <fo:region-body region-name="preface.body"
                      margin-top="{$page-top-space} + {$bleed-size}"
                      margin-right="{$page-inner-space} + {$bleed-size}"
                      margin-bottom="{$page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-outer-space} + {$bleed-size}"/>
      <fo:region-after region-name="preface.left-footer"
                       extent="{$footer-extent} + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="preface.right"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm"
                           background-image="url('material/blank.svg')">
      <fo:region-body region-name="preface.body"
                      margin-top="{$page-top-space} + {$bleed-size}"
                      margin-right="{$page-outer-space} + {$bleed-size}"
                      margin-bottom="{$page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-inner-space} + {$bleed-size}"/>
      <fo:region-before region-name="preface.right-header"
                        extent="{$bleed-size}"
                        precedence="true"/>
      <fo:region-after region-name="preface.right-footer"
                       extent="{$footer-extent} + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:page-sequence-master master-name="preface">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference master-reference="preface.left" 
                                              odd-or-even="even"/>
        <fo:conditional-page-master-reference master-reference="preface.right" 
                                              odd-or-even="odd"/>
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>
  </xsl:template>

  <!-- main-tag ================================================================================ -->

  <xsl:template match="preface">
    <fo:page-sequence master-reference="preface"
                      initial-page-number="1"
                      format="1">
      <fo:static-content flow-name="preface.right-header">
        <fo:block-container id="preface"/>
      </fo:static-content>
      <fo:static-content flow-name="preface.left-footer">
        <xsl:call-template name="left-page-number"/>
      </fo:static-content>
      <fo:static-content flow-name="preface.right-footer">
        <xsl:call-template name="right-page-number"/>
      </fo:static-content>
      <fo:flow flow-name="preface.body">
        <fo:block>
          <xsl:call-template name="miscellaneous-header">
            <xsl:with-param name="text" select="'初めに'"/>
          </xsl:call-template>
          <xsl:apply-templates mode="preface"/>
        </fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>

  <!-- tag ===================================================================================== -->

  <xsl:template match="p" mode="preface">
    <fo:block space-before="{$preface.small-space}"
              space-before.maximum="{$preface.small-space} * {$maximum-ratio}"
              space-before.minimum="{$preface.small-space} * {$minimum-ratio}"
              space-after="{$preface.small-space}"
              space-after.maximum="{$preface.small-space} * {$maximum-ratio}"
              space-after.minimum="{$preface.small-space} * {$minimum-ratio}"
              text-align="justify"
              axf:text-justify-trim="punctuation ideograph inter-word"
              linefeed-treatment="ignore"
              line-height="{$line-height}"
              widows="2"
              orphans="2">
      <xsl:apply-templates mode="preface"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="cite" mode="preface">
    <fo:block space-before="{$preface.small-space}"
              space-before.maximum="{$preface.small-space} * {$maximum-ratio}"
              space-before.minimum="{$preface.small-space} * {$minimum-ratio}"
              space-after="{$preface.small-space}"
              space-after.maximum="{$preface.small-space} * {$maximum-ratio}"
              space-after.minimum="{$preface.small-space} * {$minimum-ratio}"
              keep-together.within-page="always"
              text-align="center"
              line-height="{$line-height}">
      <xsl:apply-templates mode="preface.cite"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="name" mode="preface.cite">
    <fo:block>
      <xsl:apply-templates mode="preface.cite.name"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="url" mode="preface.cite">
    <fo:block font-size="1.2em">
      <xsl:apply-templates mode="preface.cite.url"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="date" mode="preface">
    <fo:block space-before="{$preface.large-space}"
              space-before.maximum="{$preface.large-space} * {$maximum-ratio}"
              space-before.minimum="{$preface.large-space} * {$minimum-ratio}"
              space-after="{$preface.small-space}"
              space-after.maximum="{$preface.small-space} * {$maximum-ratio}"
              space-after.minimum="{$preface.small-space} * {$minimum-ratio}"
              text-align="left"
              line-height="{$line-height}">
      <xsl:apply-templates mode="preface"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="author" mode="preface">
    <fo:block space-before="{$preface.small-space}"
              space-before.maximum="{$preface.small-space} * {$maximum-ratio}"
              space-before.minimum="{$preface.small-space} * {$minimum-ratio}"
              space-after="{$preface.small-space}"
              space-after.maximum="{$preface.small-space} * {$maximum-ratio}"
              space-after.minimum="{$preface.small-space} * {$minimum-ratio}"
              text-align="right"
              line-height="{$line-height}">
      <xsl:apply-templates mode="preface"/>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>