<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
                xmlns:zp="http://ziphil.com/XSL">
  <xsl:output method="xml" indent="no"/>

  <xsl:param name="index.maximum-tiny-space" select="'0.2em'"/>

  <!-- page-master ============================================================================= -->

  <xsl:template name="index.page-master">
    <fo:simple-page-master master-name="index.first"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm"
                           background-image="url('../material/blank.svg')">
      <fo:region-body region-name="index.body"
                      margin-top="{$page-top-space} + {$bleed-size}"
                      margin-right="{$page-inner-space} + {$bleed-size}"
                      margin-bottom="{$page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-outer-space} + {$bleed-size}"/>
      <fo:region-before region-name="index.first-header"
                        extent="{$bleed-size}"
                        precedence="true"/>
      <fo:region-after region-name="index.left-footer"
                       extent="{$footer-extent} + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="index.left"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm"
                           background-image="url('../material/blank.svg')">
      <fo:region-body region-name="index.body"
                      margin-top="{$page-top-space} + {$bleed-size}"
                      margin-right="{$page-inner-space} + {$bleed-size}"
                      margin-bottom="{$page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-outer-space} + {$bleed-size}"/>
      <fo:region-after region-name="index.left-footer"
                       extent="{$footer-extent} + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="index.right"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm"
                           background-image="url('../material/blank.svg')">
      <fo:region-body region-name="index.body"
                      margin-top="{$page-top-space} + {$bleed-size}"
                      margin-right="{$page-outer-space} + {$bleed-size}"
                      margin-bottom="{$page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-inner-space} + {$bleed-size}"/>
      <fo:region-after region-name="index.right-footer"
                       extent="{$footer-extent} + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:page-sequence-master master-name="index">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference master-reference="index.first"
                                              page-position="first"/>
        <fo:conditional-page-master-reference master-reference="index.left" 
                                              odd-or-even="even"/>
        <fo:conditional-page-master-reference master-reference="index.right" 
                                              odd-or-even="odd"/>
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>
  </xsl:template>

  <!-- main-tag ================================================================================ -->

  <xsl:template match="index">
    <fo:page-sequence master-reference="index"
                      initial-page-number="auto-even">
      <fo:static-content flow-name="index.first-header">
        <fo:block-container id="index"/>
      </fo:static-content>
      <fo:static-content flow-name="index.left-footer">
        <xsl:call-template name="left-page-number"/>
      </fo:static-content>
      <fo:static-content flow-name="index.right-footer">
        <xsl:call-template name="right-page-number"/>
      </fo:static-content>
      <fo:flow flow-name="index.body">
        <fo:block>
          <xsl:call-template name="miscellaneous-header">
            <xsl:with-param name="text" select="'新出単語一覧'"/>
          </xsl:call-template>
          <xsl:call-template name="index.list"/>
        </fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>

  <!-- tag ===================================================================================== -->

  <xsl:template name="index.list">
    <fo:block-container font-size="0.9em"
                        line-height="{$close-line-height}"
                        axf:column-count="2"
                        axf:column-gap="0mm">
      <xsl:apply-templates select="/root/(section | exercise)/word-list/word" mode="index">
        <xsl:sort select="zp:key(sh)" data-type="text"/>
      </xsl:apply-templates>
    </fo:block-container>
  </xsl:template>

  <xsl:template match="word" mode="index">
    <fo:block space-before="0em"
              space-before.maximum="{$index.maximum-tiny-space}"
              space-before.minimum="0em"
              space-after="0em"
              space-after.maximum="{$index.maximum-tiny-space}"
              space-after.minimum="0em">
      <fo:inline margin="0em 0.5em 0em 0em"
                 padding="0.1em 0.1em 0.1em 0.1em"
                 font-size="0.7em"
                 border="{$thin-border-width} {$border-color} solid">
        <xsl:apply-templates select="so" mode="index.word"/>
      </fo:inline>
      <xsl:apply-templates select="sh" mode="index.word"/>
      <xsl:if test="ja">
        <fo:inline margin="0em 0.3em 0em 0.3em"
                   font-family="{$symbol-font-family}">
          <xsl:text>…</xsl:text>
        </fo:inline>
        <xsl:apply-templates select="ja" mode="index.word"/>
      </xsl:if>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>