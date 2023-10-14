<?xml version="1.0" encoding="utf-8"?>


<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
                xmlns:zp="http://ziphil.com/XSL">
  <xsl:output method="xml" indent="no"/>
  <xsl:strip-space elements="p"/>

  <xsl:param name="exercise.page-top-space" select="'32mm'"/>
  <xsl:param name="exercise.first-header-extent" select="'24mm'"/>
  <xsl:param name="exercise.large-space" select="'1.5em'"/> <!-- 大問間 -->
  <xsl:param name="exercise.small-space" select="'0.8em'"/> <!-- 小問間 -->

  <!-- page-master ============================================================================= -->

  <xsl:template name="exercise.page-master">
    <fo:simple-page-master master-name="exercise.first"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm"
                           background-image="url('../document/material/exercise_header.svg')"
                           background-position-vertical="{$bleed-size} - 3mm"
                           background-position-horizontal="{$bleed-size} - 3mm">
      <fo:region-body region-name="exercise.body"
                      margin-top="{$exercise.page-top-space} + {$bleed-size}"
                      margin-right="{$page-inner-space} + {$bleed-size}"
                      margin-bottom="{$page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-outer-space} + {$bleed-size}"/>
      <fo:region-before region-name="exercise.first-header"
                        extent="{$exercise.first-header-extent} + {$bleed-size}"
                        precedence="true"/>
      <fo:region-after region-name="exercise.left-footer"
                       extent="{$footer-extent} + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="exercise.left"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm"
                           background-image="url('../document/material/exercise_header.svg')"
                           background-position-vertical="{$bleed-size} - 3mm"
                           background-position-horizontal="{$bleed-size} - 3mm">
      <fo:region-body region-name="exercise.body"
                      margin-top="{$exercise.page-top-space} + {$bleed-size}"
                      margin-right="{$page-inner-space} + {$bleed-size}"
                      margin-bottom="{$page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-outer-space} + {$bleed-size}"/>
      <fo:region-after region-name="exercise.left-footer"
                       extent="{$footer-extent} + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="exercise.right"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm"
                           background-image="url('../document/material/exercise_header.svg')"
                           background-position-vertical="{$bleed-size} - 3mm"
                           background-position-horizontal="{$bleed-size} - 3mm">
      <fo:region-body region-name="exercise.body"
                      margin-top="{$exercise.page-top-space} + {$bleed-size}"
                      margin-right="{$page-outer-space} + {$bleed-size}"
                      margin-bottom="{$page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-inner-space} + {$bleed-size}"/>
      <fo:region-after region-name="exercise.right-footer"
                       extent="{$footer-extent} + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:page-sequence-master master-name="exercise">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference master-reference="exercise.first"
                                              page-position="first"/>
        <fo:conditional-page-master-reference master-reference="exercise.left" 
                                              odd-or-even="even"/>
        <fo:conditional-page-master-reference master-reference="exercise.right" 
                                              odd-or-even="odd"/>
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>
  </xsl:template>

  <!-- main-tag ================================================================================ -->

  <xsl:template match="exercise">
    <fo:page-sequence master-reference="exercise"
                      initial-page-number="auto-even">
      <fo:static-content flow-name="exercise.first-header">
        <fo:block-container id="exercise.top-{count(preceding-sibling::exercise) + 1}"
                            height="24mm + {$bleed-size}">
          <fo:block-container top="10mm + {$bleed-size}"
                              left="10mm + {$bleed-size}"
                              color="{$border-color}"
                              absolute-position="absolute">
            <fo:block>
              <fo:inline font-size="18pt"
                         letter-spacing="0.05em">
                <xsl:text>演習問題</xsl:text>
              </fo:inline>
              <fo:inline margin="0em 0em 0em 0.2em"
                         font-family="{$emphasis-font-family}"
                         font-size="32pt"
                         font-weight="bold"
                         line-height="0"
                         baseline-shift="-0.05em">
                <xsl:number value="count(preceding-sibling::exercise) + 1" format="1"/>
              </fo:inline>
            </fo:block>
          </fo:block-container>
        </fo:block-container>
      </fo:static-content>
      <fo:static-content flow-name="exercise.left-footer">
        <xsl:call-template name="left-page-number"/>
      </fo:static-content>
      <fo:static-content flow-name="exercise.right-footer">
        <xsl:call-template name="right-page-number"/>
      </fo:static-content>
      <fo:flow flow-name="exercise.body">
        <fo:block>
          <xsl:apply-templates select="element | word-list" mode="exercise"/>
        </fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>

  <!-- tag ===================================================================================== -->

  <xsl:template match="element" mode="exercise">
    <fo:block space-before="{$exercise.large-space}"
              space-before.maximum="{$exercise.large-space} * {$maximum-ratio}"
              space-before.minimum="{$exercise.large-space} * {$minimum-ratio}"
              space-after="{$exercise.large-space}"
              space-after.maximum="{$exercise.large-space} * {$maximum-ratio}"
              space-after.minimum="{$exercise.large-space} * {$minimum-ratio}">
      <fo:block space-before="{$exercise.small-space}"
                space-before.maximum="{$exercise.small-space} * {$maximum-ratio}"
                space-before.minimum="{$exercise.small-space} * {$minimum-ratio}"
                space-after="{$exercise.small-space}"
                space-after.maximum="{$exercise.small-space} * {$maximum-ratio}"
                space-after.minimum="{$exercise.small-space} * {$minimum-ratio}"
                keep-with-next.within-page="always"
                keep-with-next.within-column="always">
        <fo:list-block provisional-distance-between-starts="1.6em"
                       provisional-label-separation="0.5em">
          <fo:list-item>
            <fo:list-item-label start-indent="0em" 
                                end-indent="label-end()">
              <fo:block>
                <xsl:call-template name="exercise-element-number">
                  <xsl:with-param name="number" select="count(preceding-sibling::element) + 1"/>
                </xsl:call-template>
              </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()" 
                               end-indent="0em">
              <fo:block text-align="justify"
                        axf:text-justify-trim="punctuation ideograph inter-word"
                        line-height="{$line-height}">
                <xsl:apply-templates select="state" mode="exercise.element"/>
              </fo:block>
            </fo:list-item-body>
          </fo:list-item>
        </fo:list-block>
      </fo:block>
      <fo:block>
        <xsl:call-template name="exercise.element-content"/>
      </fo:block>
    </fo:block>
  </xsl:template>

  <xsl:template name="exercise.element-content">
    <fo:block keep-together.within-page="always">
      <fo:list-block provisional-distance-between-starts="1.9em"
                     provisional-label-separation="0.5em">
        <xsl:apply-templates select="li" mode="exercise.element"/>
      </fo:list-block>
    </fo:block>
  </xsl:template>

  <xsl:template match="li" mode="exercise.element">
    <fo:list-item space-before="{$exercise.small-space}"
                  space-after="{$exercise.small-space}">
      <fo:list-item-label start-indent="1em" 
                          end-indent="label-end()">
        <fo:block line-height="{$line-height}">
          <xsl:call-template name="exercise-item-number">
            <xsl:with-param name="number" select="position()"/>
          </xsl:call-template>
        </fo:block>
      </fo:list-item-label>
      <fo:list-item-body start-indent="body-start()" 
                         end-indent="0em">
        <fo:block text-align="justify"
                  axf:text-justify-trim="punctuation ideograph inter-word"
                  line-height="{$line-height}">
          <xsl:apply-templates mode="exercise.element"/>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>

  <xsl:template match="u" mode="exercise.element">
    <fo:inline border-bottom="{$border-width} {$border-color} dashed">
      <xsl:apply-templates mode="exercise.element"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="sm" mode="exercise.element">
    <fo:inline font-size="0.9em">
      <xsl:apply-templates mode="exercise.element"/>
    </fo:inline>
  </xsl:template>

</xsl:stylesheet>