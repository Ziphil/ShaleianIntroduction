<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
                xmlns:zp="http://ziphil.com/XSL">
  <xsl:output method="xml" indent="no"/>

  <xsl:param name="exercise-answer.large-space" select="'0.5em'"/> <!-- 演習問題番号の前後 -->
  <xsl:param name="exercise-answer.small-space" select="'0.3em'"/> <!-- 大問間 -->
  <xsl:param name="exercise-answer.maximum-tiny-space" select="'0.2em'"/> <!-- 小問間 -->

  <!-- page-master ============================================================================= -->

  <xsl:template name="exercise-answer.page-master">
    <fo:simple-page-master master-name="exercise-answer.first"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm"
                           background-image="url('../document/material/blank.svg')">
      <fo:region-body region-name="exercise-answer.body"
                      margin-top="{$page-top-space} + {$bleed-size}"
                      margin-right="{$page-inner-space} + {$bleed-size}"
                      margin-bottom="{$page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-outer-space} + {$bleed-size}"/>
      <fo:region-before region-name="exercise-answer.first-header"
                        extent="{$bleed-size}"
                        precedence="true"/>
      <fo:region-after region-name="exercise-answer.left-footer"
                       extent="{$footer-extent} + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="exercise-answer.left"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm"
                           background-image="url('../document/material/blank.svg')">
      <fo:region-body region-name="exercise-answer.body"
                      margin-top="{$page-top-space} + {$bleed-size}"
                      margin-right="{$page-inner-space} + {$bleed-size}"
                      margin-bottom="{$page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-outer-space} + {$bleed-size}"/>
      <fo:region-after region-name="exercise-answer.left-footer"
                       extent="{$footer-extent} + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="exercise-answer.right"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm"
                           background-image="url('../document/material/blank.svg')">
      <fo:region-body region-name="exercise-answer.body"
                      margin-top="{$page-top-space} + {$bleed-size}"
                      margin-right="{$page-outer-space} + {$bleed-size}"
                      margin-bottom="{$page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-inner-space} + {$bleed-size}"/>
      <fo:region-after region-name="exercise-answer.right-footer"
                       extent="{$footer-extent} + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:page-sequence-master master-name="exercise-answer">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference master-reference="exercise-answer.first"
                                              page-position="first"/>
        <fo:conditional-page-master-reference master-reference="exercise-answer.left" 
                                              odd-or-even="even"/>
        <fo:conditional-page-master-reference master-reference="exercise-answer.right" 
                                              odd-or-even="odd"/>
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>
  </xsl:template>

  <!-- main-tag ================================================================================ -->

  <xsl:template match="exercise-answer">
    <fo:page-sequence master-reference="exercise-answer"
                      initial-page-number="auto-even">
      <fo:static-content flow-name="exercise-answer.first-header">
        <fo:block-container id="exercise-answer"/>
      </fo:static-content>
      <fo:static-content flow-name="exercise-answer.left-footer">
        <xsl:call-template name="left-page-number"/>
      </fo:static-content>
      <fo:static-content flow-name="exercise-answer.right-footer">
        <xsl:call-template name="right-page-number"/>
      </fo:static-content>
      <fo:flow flow-name="exercise-answer.body">
        <fo:block>
          <xsl:call-template name="miscellaneous-header">
            <xsl:with-param name="text" select="'演習問題解答'"/>
          </xsl:call-template>
          <xsl:call-template name="exercise-answer.list"/>
        </fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>

  <!-- tag ===================================================================================== -->

  <xsl:template name="exercise-answer.list">
    <fo:block-container axf:column-count="2"
                        axf:column-gap="8mm">
      <xsl:apply-templates select="/root/exercise" mode="exercise-answer"/>
    </fo:block-container>
  </xsl:template>

  <xsl:template match="exercise" mode="exercise-answer">
    <fo:block space-before="{$exercise-answer.large-space}"
              space-before.maximum="{$exercise-answer.large-space} * {$maximum-ratio}"
              space-before.minimum="{$exercise-answer.large-space} * {$minimum-ratio}"
              space-after="{$exercise-answer.large-space}"
              space-after.maximum="{$exercise-answer.large-space} * {$maximum-ratio}"
              space-after.minimum="{$exercise-answer.large-space} * {$minimum-ratio}"
              keep-with-next.within-page="always"
              keep-with-next.within-column="always"
              font-size="1.2em"
              color="{$border-color}"
              line-height="1"
              text-align="center"
              linefeed-treatment="ignore">
      <fo:inline>
        <xsl:text>演習問題</xsl:text>
      </fo:inline>
      <fo:inline margin="0em 0.3em 0em 0.3em"
                 font-family="{$emphasis-font-family}"
                 font-size="1.5em"
                 font-weight="bold"
                 line-height="0"
                 baseline-shift="-0.05em">
        <xsl:number value="position()"/>
      </fo:inline>
    </fo:block>
    <fo:block font-size="0.9em">
      <xsl:apply-templates select="answer" mode="exercise-answer"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="answer" mode="exercise-answer">
    <fo:block space-before="{$exercise-answer.small-space}"
              space-before.maximum="{$exercise-answer.small-space} * {$maximum-ratio}"
              space-before.minimum="{$exercise-answer.small-space} * {$minimum-ratio}"
              space-after="{$exercise-answer.small-space}"
              space-after.maximum="{$exercise-answer.small-space} * {$maximum-ratio}"
              space-after.minimum="{$exercise-answer.small-space} * {$minimum-ratio}">
      <fo:block keep-with-next.within-page="always"
                keep-with-next.within-column="always">
        <xsl:call-template name="exercise-element-number">
          <xsl:with-param name="number" select="position()"/>
        </xsl:call-template>
      </fo:block>
      <fo:block>
        <fo:list-block provisional-distance-between-starts="1.9em"
                       provisional-label-separation="0.5em">
          <xsl:apply-templates select="li" mode="exercise-answer.answer"/>
        </fo:list-block>
      </fo:block>
    </fo:block>
  </xsl:template>

  <xsl:template match="li" mode="exercise-answer.answer">
    <fo:list-item space-before="0em"
                  space-before.maximum="{$exercise-answer.maximum-tiny-space}"
                  space-before.minimum="0em"
                  space-after="0em"
                  space-after.maximum="{$exercise-answer.maximum-tiny-space}"
                  space-after.minimum="0em">
      <fo:list-item-label start-indent="0em" 
                          end-indent="label-end()">
        <fo:block line-height="{$close-line-height}">
          <xsl:call-template name="exercise-item-number">
            <xsl:with-param name="number" select="position()"/>
          </xsl:call-template>
        </fo:block>
      </fo:list-item-label>
      <fo:list-item-body start-indent="body-start()" 
                         end-indent="0em">
        <fo:block text-align="justify"
                  axf:text-justify-trim="punctuation ideograph inter-word"
                  line-height="{$close-line-height}">
          <xsl:apply-templates mode="exercise-answer.element"/>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>

  <xsl:template match="alt" mode="exercise-answer.element">
    <xsl:text> / </xsl:text>
    <xsl:apply-templates mode="exercise-answer.element"/>
  </xsl:template>

</xsl:stylesheet>