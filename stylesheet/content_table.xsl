<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
                xmlns:zp="http://ziphil.com/XSL">
  <xsl:output method="xml" indent="no"/>

  <xsl:param name="content-table.large-space" select="'0.5em'"/> <!-- 部の前後 -->
  <xsl:param name="content-table.small-space" select="'0.3em'"/> <!-- 節の前後 -->
  <xsl:param name="content-table.tiny-space" select="'0.2em'"/> <!-- 節と項の間 -->

  <!-- page-master ============================================================================= -->

  <xsl:template name="content-table.page-master">
    <fo:simple-page-master master-name="content-table.first"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm"
                           background-image="url('material/blank.svg')">
      <fo:region-body region-name="content-table.body"
                      margin-top="{$page-top-space} + {$bleed-size}"
                      margin-right="{$page-inner-space} + {$bleed-size}"
                      margin-bottom="{$page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-outer-space} + {$bleed-size}"/>
      <fo:region-before region-name="content-table.first-header"
                        extent="{$bleed-size}"
                        precedence="true"/>
      <fo:region-after region-name="content-table.left-footer"
                       extent="{$footer-extent} + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="content-table.left"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm"
                           background-image="url('material/blank.svg')">
      <fo:region-body region-name="content-table.body"
                      margin-top="{$page-top-space} + {$bleed-size}"
                      margin-right="{$page-inner-space} + {$bleed-size}"
                      margin-bottom="{$page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-outer-space} + {$bleed-size}"/>
      <fo:region-after region-name="content-table.left-footer"
                       extent="{$footer-extent} + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="content-table.right"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm"
                           background-image="url('material/blank.svg')">
      <fo:region-body region-name="content-table.body"
                      margin-top="{$page-top-space} + {$bleed-size}"
                      margin-right="{$page-outer-space} + {$bleed-size}"
                      margin-bottom="{$page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-inner-space} + {$bleed-size}"/>
      <fo:region-after region-name="content-table.right-footer"
                       extent="{$footer-extent} + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:page-sequence-master master-name="content-table">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference master-reference="content-table.first"
                                              page-position="first"/>
        <fo:conditional-page-master-reference master-reference="content-table.left" 
                                              odd-or-even="even"/>
        <fo:conditional-page-master-reference master-reference="content-table.right" 
                                              odd-or-even="odd"/>
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>
  </xsl:template>

  <!-- main-tag ================================================================================ -->

  <xsl:template match="content-table">
    <fo:page-sequence master-reference="content-table"
                      initial-page-number="auto-even">
      <fo:static-content flow-name="content-table.first-header">
        <fo:block-container id="content-table"/>
      </fo:static-content>
      <fo:static-content flow-name="content-table.left-footer">
        <xsl:call-template name="left-page-number"/>
      </fo:static-content>
      <fo:static-content flow-name="content-table.right-footer">
        <xsl:call-template name="right-page-number"/>
      </fo:static-content>
      <fo:flow flow-name="content-table.body">
        <fo:block>
          <xsl:call-template name="miscellaneous-header">
            <xsl:with-param name="text" select="'目次'"/>
          </xsl:call-template>
          <xsl:call-template name="content-table.list"/>
        </fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>

  <!-- tag ===================================================================================== -->

  <xsl:template name="content-table.list">
    <fo:block>
      <xsl:call-template name="content-table.miscellaneous">
        <xsl:with-param name="text" select="'初めに'"/>
        <xsl:with-param name="ref-id" select="'preface'"/>
      </xsl:call-template>
      <xsl:call-template name="content-table.miscellaneous">
        <xsl:with-param name="text" select="'目次'"/>
        <xsl:with-param name="ref-id" select="'content-table'"/>
      </xsl:call-template>
      <xsl:apply-templates select="/root/part" mode="content-table"/>
      <fo:block space-before="{$content-table.large-space}"
                space-before.maximum="{$content-table.large-space} * {$maximum-ratio}"
                space-before.minimum="{$content-table.large-space} * {$minimum-ratio}"
                space-after="{$content-table.large-space}"
                space-after.maximum="{$content-table.large-space} * {$maximum-ratio}"
                space-after.minimum="{$content-table.large-space} * {$minimum-ratio}">
        <xsl:text>　</xsl:text>
      </fo:block>
      <xsl:call-template name="content-table.miscellaneous">
        <xsl:with-param name="text" select="'演習問題解答'"/>
        <xsl:with-param name="ref-id" select="'exercise-answer'"/>
      </xsl:call-template>
      <xsl:call-template name="content-table.miscellaneous">
        <xsl:with-param name="text" select="'新出単語一覧'"/>
        <xsl:with-param name="ref-id" select="'index'"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

  <xsl:template match="part" mode="content-table">
    <xsl:variable name="position" select="position()"/>
    <fo:block space-before="{$content-table.large-space}"
              space-before.maximum="{$content-table.large-space} * {$maximum-ratio}"
              space-before.minimum="{$content-table.large-space} * {$minimum-ratio}"
              space-after="{$content-table.large-space}"
              space-after.maximum="{$content-table.large-space} * {$maximum-ratio}"
              space-after.minimum="{$content-table.large-space} * {$minimum-ratio}"
              keep-with-next.within-page="always"
              font-size="1.2em"
              color="{$border-color}"
              line-height="1"
              text-align="center"
              linefeed-treatment="ignore">
      <fo:inline>
        <xsl:text>第</xsl:text>
      </fo:inline>
      <fo:inline margin="0em 0.3em 0em 0.3em"
                 font-family="{$emphasis-font-family}"
                 font-size="1.5em"
                 line-height="0"
                 baseline-shift="-0.05em">
        <xsl:number value="position()"/>
      </fo:inline>
      <fo:inline>
        <xsl:text>部</xsl:text>
      </fo:inline>
    </fo:block>
    <fo:block>
      <xsl:apply-templates select="(following-sibling::section | following-sibling::exercise)[count(preceding-sibling::part) = $position]" mode="content-table.item"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="section" mode="content-table.item">
    <fo:block space-before="{$content-table.small-space}"
              space-before.maximum="{$content-table.small-space} * {$maximum-ratio}"
              space-before.minimum="{$content-table.small-space} * {$minimum-ratio}"
              space-after="{$content-table.small-space}"
              space-after.maximum="{$content-table.small-space} * {$maximum-ratio}"
              space-after.minimum="{$content-table.small-space} * {$minimum-ratio}"
              line-height="1">
      <xsl:call-template name="content-table.section.top"/>
      <fo:block>
        <xsl:call-template name="content-table.section.element"/>
      </fo:block>
    </fo:block>
  </xsl:template>

  <xsl:template name="content-table.section.top">
    <xsl:variable name="section-number" select="count(preceding-sibling::section) + 1"/>
    <fo:block space-before="{$content-table.tiny-space}"
              space-before.maximum="{$content-table.tiny-space} * {$maximum-ratio}"
              space-before.minimum="{$content-table.tiny-space} * {$minimum-ratio}"
              space-after="{$content-table.tiny-space}"
              space-after.maximum="{$content-table.tiny-space} * {$maximum-ratio}"
              space-after.minimum="{$content-table.tiny-space} * {$minimum-ratio}"
              keep-with-next.within-page="always"
              text-align-last="justify">
      <fo:inline-container width="4mm"
                           height="1em"
                           font-family="{$emphasis-font-family}"
                           font-size="1.4em"
                           color="{$border-color}"
                           text-align-last="center">
        <fo:block text-align="center">
          <xsl:number value="$section-number"/>
        </fo:block>
      </fo:inline-container>
      <fo:inline margin="0em 0.3em 0em 0.3em"
                 font-family="{$symbol-font-family}"
                 color="{$border-color}">
        <xsl:text>▶</xsl:text>
      </fo:inline>
      <fo:basic-link internal-destination="section.top-{$section-number}">
        <fo:inline>
          <xsl:sequence select="zp:enrich(@title)"/>
        </fo:inline>
      </fo:basic-link>
      <fo:leader margin="0em 0.5em 0em 0.5em"
                 color="{$border-color}"
                 leader-pattern="rule"
                 rule-style="dotted"
                 rule-thickness="{$border-width} * 2"
                 baseline-shift="0.3em"/>
      <fo:inline-container width="4mm"
                           height="1em"
                           font-family="{$emphasis-font-family}"
                           font-size="1em"
                           text-align-last="right">
        <fo:block>
          <fo:page-number-citation ref-id="section.top-{$section-number}"/>
        </fo:block>
      </fo:inline-container>
    </fo:block>
  </xsl:template>

  <xsl:template name="content-table.section.element">
    <fo:block-container margin-left="2mm"
                        margin-right="2mm"
                        keep-together.within-page="always"
                        font-size="0.9em"
                        line-height="{$close-line-height}"
                        axf:column-count="2"
                        axf:column-gap="0em">
      <xsl:for-each select="element">
        <fo:block>
          <fo:basic-link internal-destination="section.element-{count(../preceding-sibling::section) + 1}-{position()}">
            <xsl:sequence select="zp:enrich(@title)"/>
          </fo:basic-link>
        </fo:block>
      </xsl:for-each>
      <xsl:if test="count(element) mod 2 = 1">
        <fo:block>
          <xsl:text>　</xsl:text>
        </fo:block>
      </xsl:if>
    </fo:block-container>
  </xsl:template>

  <xsl:template match="exercise" mode="content-table.item">
    <xsl:variable name="exercise-number" select="count(preceding-sibling::exercise) + 1"/>
    <fo:block space-before="{$content-table.small-space}"
              space-before.maximum="{$content-table.small-space} * {$maximum-ratio}"
              space-before.minimum="{$content-table.small-space} * {$minimum-ratio}"
              space-after="{$content-table.small-space}"
              space-after.maximum="{$content-table.small-space} * {$maximum-ratio}"
              space-after.minimum="{$content-table.small-space} * {$minimum-ratio}"
              line-height="1"
              text-align-last="justify">
      <fo:inline margin="0em 0.3em 0em 0em"
                 font-family="{$symbol-font-family}"
                 font-size="0.8em"
                 color="{$border-color}">
        <xsl:text>◆</xsl:text>
      </fo:inline>
      <fo:basic-link internal-destination="exercise.top-{$exercise-number}">
        <fo:inline>
          <xsl:text>演習問題</xsl:text>
        </fo:inline>
        <fo:inline font-family="{$emphasis-font-family}"
                   font-size="1.2em">
          <xsl:number value="$exercise-number"/>
        </fo:inline>
      </fo:basic-link>
      <fo:leader margin="0em 0.5em 0em 0.5em"
                 color="{$border-color}"
                 leader-pattern="rule"
                 rule-style="dotted"
                 rule-thickness="{$border-width} * 2"
                 baseline-shift="0.3em"/>
      <fo:inline-container width="4mm"
                           height="1em"
                           font-family="{$emphasis-font-family}"
                           font-size="1em"
                           text-align-last="right">
        <fo:block>
          <fo:page-number-citation ref-id="exercise.top-{$exercise-number}"/>
        </fo:block>
      </fo:inline-container>
    </fo:block>
  </xsl:template>

  <xsl:template name="content-table.miscellaneous">
    <xsl:param name="text"/>
    <xsl:param name="ref-id"/>
    <fo:block space-before="{$content-table.small-space}"
              space-before.maximum="{$content-table.small-space} * {$maximum-ratio}"
              space-before.minimum="{$content-table.small-space} * {$minimum-ratio}"
              space-after="{$content-table.small-space}"
              space-after.maximum="{$content-table.small-space} * {$maximum-ratio}"
              space-after.minimum="{$content-table.small-space} * {$minimum-ratio}"
              line-height="1"
              text-align-last="justify">
      <fo:basic-link internal-destination="exercise-answer">
        <fo:inline>
          <xsl:value-of select="$text"/>
        </fo:inline>
      </fo:basic-link>
      <fo:leader margin="0em 0.5em 0em 0.5em"
                 color="{$border-color}"
                 leader-pattern="rule"
                 rule-style="dotted"
                 rule-thickness="{$border-width} * 2"
                 baseline-shift="0.3em"/>
      <fo:inline-container width="4mm"
                           height="1em"
                           font-family="{$emphasis-font-family}"
                           font-size="1em"
                           text-align-last="right">
        <fo:block>
          <fo:page-number-citation ref-id="{$ref-id}"/>
        </fo:block>
      </fo:inline-container>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>