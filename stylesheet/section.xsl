<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
                xmlns:zp="http://ziphil.com/XSL">
  <xsl:output method="xml" indent="no"/>
  <xsl:strip-space elements="p"/>

  <xsl:param name="section.first-page-top-space" select="'36mm'"/>
  <xsl:param name="section.page-top-space" select="'23mm'"/>
  <xsl:param name="section.first-header-extent" select="'36mm'"/>
  <xsl:param name="section.header-extent" select="'15mm'"/>
  <xsl:param name="section.huge-space" select="'1.5em'"/> <!-- 冒頭例文の直後 -->
  <xsl:param name="section.large-space" select="'1em'"/> <!-- 節の直前 -->
  <xsl:param name="section.small-space" select="'0.3em'"/> <!-- 段落間 -->

  <!-- page-master ============================================================================= -->

  <xsl:template name="section.page-master">
    <fo:simple-page-master master-name="section.first"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm"
                           background-image="url('material/section_header.svg')">
      <fo:region-body region-name="section.body"
                      margin-top="{$section.first-page-top-space} + {$bleed-size}"
                      margin-right="{$page-inner-space} + {$bleed-size}"
                      margin-bottom="{$page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-outer-space} + {$bleed-size}"/>
      <fo:region-before region-name="section.first-header"
                        extent="{$section.first-header-extent} + {$bleed-size}"
                        precedence="true"/>
      <fo:region-after region-name="section.left-footer"
                       extent="{$footer-extent} + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="section.left"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm"
                           background-image="url('material/blank.svg')">
      <fo:region-body region-name="section.body"
                      margin-top="{$section.page-top-space} + {$bleed-size}"
                      margin-right="{$page-inner-space} + {$bleed-size}"
                      margin-bottom="{$page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-outer-space} + {$bleed-size}"/>
      <fo:region-before region-name="section.left-header"
                        extent="{$section.header-extent} + {$bleed-size}"
                        precedence="true"/>
      <fo:region-after region-name="section.left-footer"
                       extent="{$footer-extent} + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="section.right"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm"
                           background-image="url('material/blank.svg')">
      <fo:region-body region-name="section.body"
                      margin-top="{$section.page-top-space} + {$bleed-size}"
                      margin-right="{$page-outer-space} + {$bleed-size}"
                      margin-bottom="{$page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-inner-space} + {$bleed-size}"/>
      <fo:region-before region-name="section.right-header"
                        extent="{$section.header-extent} + {$bleed-size}"
                        precedence="true"/>
      <fo:region-after region-name="section.right-footer"
                       extent="{$footer-extent} + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:page-sequence-master master-name="section">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference master-reference="section.first"
                                              page-position="first"/>
        <fo:conditional-page-master-reference master-reference="section.left" 
                                              odd-or-even="even"/>
        <fo:conditional-page-master-reference master-reference="section.right" 
                                              odd-or-even="odd"/>
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>
  </xsl:template>

  <!-- main-tag ================================================================================ -->

  <xsl:template match="section">
    <fo:page-sequence master-reference="section"
                      initial-page-number="auto-even">
      <fo:static-content flow-name="section.first-header">
        <fo:block-container id="section.top-{count(preceding-sibling::section) + 1}"
                            height="36mm + {$bleed-size}">
          <fo:block-container width="20mm"
                              top="3mm + {$bleed-size}"
                              left="2mm + {$bleed-size}"
                              font-family="{$emphasis-font-family}"
                              font-size="56pt"
                              color="{$border-color}"
                              text-align="center"
                              letter-spacing="-0.05em"
                              absolute-position="absolute">
            <fo:block>
              <xsl:number value="count(preceding-sibling::section) + 1" format="1"/>
            </fo:block>
          </fo:block-container>
          <fo:block-container top="9mm + {$bleed-size}"
                              left="43mm + {$bleed-size}"
                              font-size="20pt"
                              letter-spacing="0.05em"
                              absolute-position="absolute">
            <fo:block>
              <xsl:sequence select="zp:enrich(@title)"/>
            </fo:block>
          </fo:block-container>
        </fo:block-container>
      </fo:static-content>
      <fo:static-content flow-name="section.left-header">
        <fo:block-container margin="0mm 0mm 0mm 8mm"
                            height="15mm + {$bleed-size}"
                            text-align="left"
                            display-align="after">
          <fo:block border-bottom="{$border-width} {$border-color} solid">
            <fo:inline padding="0mm 0mm 0mm 1mm">
              <xsl:sequence select="zp:enrich(@title)"/>
            </fo:inline>
          </fo:block>
        </fo:block-container>
      </fo:static-content>
      <fo:static-content flow-name="section.right-header">
        <fo:block-container margin="0mm 8mm 0mm 0mm"
                            height="15mm + {$bleed-size}"
                            text-align="right"
                            display-align="after">
          <fo:block border-bottom="{$border-width} {$border-color} solid">
            <fo:inline padding="0mm 1mm 0mm 0mm">
              <xsl:sequence select="zp:enrich(@title)"/>
            </fo:inline>
          </fo:block>
        </fo:block-container>
      </fo:static-content>
      <fo:static-content flow-name="section.left-footer">
        <xsl:call-template name="left-page-number"/>
      </fo:static-content>
      <fo:static-content flow-name="section.right-footer">
        <xsl:call-template name="right-page-number"/>
      </fo:static-content>
      <fo:flow flow-name="section.body">
        <fo:block>
          <xsl:apply-templates select="example-list | word-list | element" mode="section"/>
        </fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>

  <!-- tag ===================================================================================== -->

  <xsl:template match="example-list" mode="section">
    <fo:block space-before="{$section.huge-space}"
              space-before.maximum="{$section.huge-space} * {$maximum-ratio}"
              space-before.minimum="{$section.huge-space} * {$minimum-ratio}"
              space-after="{$section.huge-space}"
              space-after.maximum="{$section.huge-space} * {$maximum-ratio}"
              space-after.minimum="{$section.huge-space} * {$minimum-ratio}"
              padding="0.1em 2mm 0.1em 2mm"
              font-size="1.1em"
              line-height="1.3"
              border="{$border-width} * 3 {$border-color} double">
      <xsl:apply-templates select="li" mode="section.xl"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="element" mode="section">
    <fo:block id="section.element-{count(../preceding-sibling::section) + 1}-{count(preceding-sibling::element) + 1}"
              space-before="{$section.large-space}"
              space-before.maximum="{$section.large-space} * {$maximum-ratio}"
              space-before.minimum="{$section.large-space} * {$minimum-ratio}"
              space-after="{$section.large-space}"
              space-after.maximum="{$section.large-space} * {$maximum-ratio}"
              space-after.minimum="{$section.large-space} * {$minimum-ratio}">
      <xsl:call-template name="section.element-title"/>
      <fo:block>
        <xsl:apply-templates mode="section.element"/>
      </fo:block>
    </fo:block>
  </xsl:template>

  <xsl:template name="section.element-title">
    <fo:block space-before="{$section.small-space}"
              space-before.maximum="{$section.small-space} * {$maximum-ratio}"
              space-before.minimum="{$section.small-space} * {$minimum-ratio}"
              space-after="{$section.small-space}"
              space-after.maximum="{$section.small-space} * {$maximum-ratio}"
              space-after.minimum="{$section.small-space} * {$minimum-ratio}"
              font-size="1.2em"
              text-align-last="justify"
              keep-with-next.within-page="always"
              keep-with-next.within-column="always">
      <fo:inline-container width="1em"
                           height="1em"
                           margin="0em 0.5em 0em 0em"
                           font-family="{$emphasis-font-family}"
                           font-size="1.2em"
                           color="{$border-color}"
                           text-align-last="center"
                           line-height="1"
                           border="{$border-width} {$border-color} solid"
                           background-color="{$background-color}">
        <fo:block>
          <xsl:number value="count(preceding-sibling::element) + 1"/>
        </fo:block>
      </fo:inline-container>
      <xsl:sequence select="zp:enrich(@title)"/> 
      <fo:leader margin="0em 0em 0em 0.5em"
                 color="{$border-color}"
                 leader-pattern="rule"
                 rule-thickness="{$border-width} * 2"
                 rule-style="dotted"
                 baseline-shift="0.3em"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xl" mode="section.element">
    <fo:block space-before="{$section.small-space}"
              space-before.maximum="{$section.small-space} * {$maximum-ratio}"
              space-before.minimum="{$section.small-space} * {$minimum-ratio}"
              space-after="{$section.small-space}"
              space-after.maximum="{$section.small-space} * {$maximum-ratio}"
              space-after.minimum="{$section.small-space} * {$minimum-ratio}"
              margin="0em"
              padding="0em 0em 0em 0.5em"
              line-height="1.3"
              border-left="0.7em {$background-color} solid"
              border="0.1mm #FFFFFF00 solid">
      <xsl:apply-templates select="li" mode="section.xl"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="li" mode="section.xl">
    <fo:block space-before="0.3em"
              space-after="0.3em">
      <xsl:apply-templates select="sh | ja" mode="section.xl.li"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="sh" mode="section.xl.li">
    <fo:block font-size="1.2em"
              keep-with-next.within-page="always"
              keep-with-next.within-column="always">
      <xsl:apply-templates mode="section.xl.li.sh"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="ja" mode="section.xl.li">
    <fo:block>
      <fo:inline padding="0em 0.3em 0em 0.5em"
                 font-family="{$symbol-font-family}"
                 color="{$border-color}">
        <xsl:text>▶</xsl:text>
      </fo:inline>
      <xsl:apply-templates mode="section.xl.li.ja"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="s" mode="section.xl.li.sh">
    <fo:inline margin="0em"
               padding="0.1em 0.2em 0.1em 0.2em"
               border="{$thin-border-width} {$border-color} solid"
               background-color="{$background-color}">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="s" mode="section.xl.li.ja">
    <fo:inline margin="0em"
               border-bottom="{$thin-border-width} {$border-color} solid">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="p" mode="section.element">
    <fo:block space-before="{$section.small-space}"
              space-before.maximum="{$section.small-space} * {$maximum-ratio}"
              space-before.minimum="{$section.small-space} * {$minimum-ratio}"
              space-after="{$section.small-space}"
              space-after.maximum="{$section.small-space} * {$maximum-ratio}"
              space-after.minimum="{$section.small-space} * {$minimum-ratio}"
              text-align="justify"
              axf:text-justify-trim="punctuation ideograph inter-word"
              linefeed-treatment="ignore"
              line-height="{$line-height}"
              widows="2"
              orphans="2">
      <xsl:apply-templates mode="section.element"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="section-number" mode="section.element">
    <xsl:variable name="title" select="@title"/>
    <xsl:variable name="section-number" select="count(/root/section[@title=$title]/preceding-sibling::section) + 1"/>
    <fo:basic-link internal-destination="section.top-{$section-number}">
      <fo:inline>
        <xsl:choose>
          <xsl:when test="/root/section[@title=$title]">
            <xsl:text>第 </xsl:text>
            <xsl:number value="$section-number"/>
            <xsl:text> 課</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <fo:inline color="#FFFFFF"
                       background-color="#FF0000">
              <xsl:text>??</xsl:text>
            </fo:inline>
          </xsl:otherwise>
        </xsl:choose>
      </fo:inline>
    </fo:basic-link>
  </xsl:template>

  <xsl:template match="half-space" mode="#all">
    <fo:inline font-family="{$japanese-font-family}">
      <xsl:text>&#x2002;</xsl:text>
    </fo:inline>
  </xsl:template>

  <xsl:template match="sup" mode="#all">
    <fo:inline font-size="75%"
               baseline-shift="super"
               line-height="0.1">
      <xsl:value-of select="."/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="caution" mode="#all">
    <fo:inline color="#FFFFFF"
               background-color="#FF0000">
      <xsl:value-of select="."/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="img" mode="section.element">
    <fo:block space-before="{$section.small-space} * {$bordered-space-ratio}"
              space-before.maximum="{$section.small-space} * {$maximum-ratio} * {$bordered-space-ratio}"
              space-before.minimum="{$section.small-space} * {$minimum-ratio} * {$bordered-space-ratio}"
              space-after="{$section.small-space} * {$bordered-space-ratio}"
              space-after.maximum="{$section.small-space} * {$maximum-ratio} * {$bordered-space-ratio}"
              space-after.minimum="{$section.small-space} * {$minimum-ratio} * {$bordered-space-ratio}"
              font-size="0pt"
              text-align="center">
      <xsl:choose>
        <xsl:when test="doc-available(concat('../', @src))">
          <fo:external-graphic src="url({@src})"/>
        </xsl:when>
        <xsl:otherwise>
          <fo:inline color="#FFFFFF"
                     background-color="#FF0000">
            <xsl:text>図がありません</xsl:text>
          </fo:inline>
        </xsl:otherwise>
      </xsl:choose>
    </fo:block>
  </xsl:template>

  <xsl:template match="vertical-letter-list" mode="section.element">
    <fo:block space-before="{$section.small-space} * {$bordered-space-ratio}"
              space-before.maximum="{$section.small-space} * {$maximum-ratio} * {$bordered-space-ratio}"
              space-before.minimum="{$section.small-space} * {$minimum-ratio} * {$bordered-space-ratio}"
              space-after="{$section.small-space} * {$bordered-space-ratio}"
              space-after.maximum="{$section.small-space} * {$maximum-ratio} * {$bordered-space-ratio}"
              space-after.minimum="{$section.small-space} * {$minimum-ratio} * {$bordered-space-ratio}">
      <xsl:apply-templates select="letter" mode="section.vertical-letter-list"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="letter" mode="section.vertical-letter-list">
    <fo:table-and-caption space-before="{$section.small-space} * 1.2"
                          space-before.maximum="{$section.small-space} * {$maximum-ratio} * 1.2"
                          space-before.minimum="{$section.small-space} * {$minimum-ratio} * 1.2"
                          space-after="{$section.small-space} * 1.2"
                          space-after.maximum="{$section.small-space} * {$maximum-ratio} * 1.2"
                          space-after.minimum="{$section.small-space} * {$minimum-ratio} * 1.2">
      <fo:table>
        <fo:table-body>
          <fo:table-row>
            <fo:table-cell>
              <fo:block font-size="0pt">
                <fo:external-graphic src="url(letter/{@name}.svg)"/>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell padding-left="1em">
              <fo:block margin-bottom="0.3em"
                        line-height="1">
                <fo:inline font-size="1.2em">
                  <xsl:sequence select="zp:enrich(@trans)"/>
                </fo:inline>
                <fo:inline margin-left="0.8em">
                  <xsl:sequence select="zp:enrich(@pron)"/>
                </fo:inline>
              </fo:block>
              <fo:block text-align="justify"
                        axf:text-justify-trim="punctuation ideograph inter-word"
                        linefeed-treatment="ignore"
                        line-height="{$line-height}">
                <xsl:apply-templates mode="section.element"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
    </fo:table-and-caption>
  </xsl:template>

  <xsl:template match="horizontal-letter-list" mode="section.element">
    <fo:block space-before="{$section.small-space}"
              space-before.maximum="{$section.small-space} * {$maximum-ratio}"
              space-before.minimum="{$section.small-space} * {$minimum-ratio}"
              space-after="{$section.small-space}"
              space-after.maximum="{$section.small-space} * {$maximum-ratio}"
              space-after.minimum="{$section.small-space} * {$minimum-ratio}"
              text-align="center">
      <xsl:apply-templates select="row" mode="section.horizontal-letter-list"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="row" mode="section.horizontal-letter-list">
    <fo:block space-before="{$section.small-space} * 0.5"
              space-before.maximum="{$section.small-space} * {$maximum-ratio} * 0.5"
              space-before.minimum="{$section.small-space} * {$minimum-ratio} * 0.5"
              space-after="{$section.small-space} * 0.5"
              space-after.maximum="{$section.small-space} * {$maximum-ratio} * 0.5"
              space-after.minimum="{$section.small-space} * {$minimum-ratio} * 0.5">
      <xsl:apply-templates select="letter" mode="section.horizontal-letter-list.row"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="letter" mode="section.horizontal-letter-list.row">
    <fo:inline-container margin="0em 1em">
      <fo:block margin-bottom="0.1em"
                font-size="1.2em"
                text-align="center"
                line-height="1">
        <xsl:sequence select="zp:enrich(@trans)"/>
      </fo:block>
      <fo:block font-size="0pt">
        <fo:external-graphic src="url(letter/{@name}.svg)"/>
      </fo:block>
    </fo:inline-container>
  </xsl:template>

  <xsl:template match="table" mode="section.element">
    <fo:table-and-caption space-before="{$section.small-space} * {$bordered-space-ratio}"
                          space-before.maximum="{$section.small-space} * {$maximum-ratio} * {$bordered-space-ratio}"
                          space-before.minimum="{$section.small-space} * {$minimum-ratio} * {$bordered-space-ratio}"
                          space-after="{$section.small-space} * {$bordered-space-ratio}"
                          space-after.maximum="{$section.small-space} * {$maximum-ratio} * {$bordered-space-ratio}"
                          space-after.minimum="{$section.small-space} * {$minimum-ratio} * {$bordered-space-ratio}"
                          keep-together.within-page="always"
                          keep-together.within-column="always"
                          line-height="{$line-height}"
                          text-align="center">
      <fo:table border-top="{$border-width} {$border-color} solid"
                border-bottom="{$border-width} {$border-color} solid"
                border-collapse="collapse-with-precedence">
        <fo:table-body>
          <xsl:apply-templates select="tr" mode="section.table"/>
        </fo:table-body>
      </fo:table>
    </fo:table-and-caption>
  </xsl:template>

  <xsl:template match="tr" mode="section.table">
    <xsl:variable name="header-size" select="zp:or-else(../@header-size, 1)"/>
    <xsl:choose>
      <xsl:when test="position() = $header-size">
        <fo:table-row border-bottom="{$border-width} {$border-color} solid"> 
          <xsl:apply-templates select="td | td-blank" mode="section.table.tr"/>
        </fo:table-row>
      </xsl:when>
      <xsl:otherwise>
        <fo:table-row> 
          <xsl:apply-templates select="td | td-blank" mode="section.table.tr"/>
        </fo:table-row>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="td" mode="section.table.tr">
    <fo:table-cell padding="0em 0.5em 0em 0.5em"
                   display-align="center"
                   text-align="center">
      <xsl:if test="@rowspan">
        <xsl:attribute name="number-rows-spanned">
          <xsl:value-of select="@rowspan"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@colspan">
        <xsl:attribute name="number-columns-spanned">
          <xsl:value-of select="@colspan"/>
        </xsl:attribute>
      </xsl:if>
      <fo:block>
        <xsl:apply-templates mode="section.element"/>
      </fo:block>
    </fo:table-cell>
  </xsl:template>

  <xsl:template match="td-blank" mode="section.table.tr">
    <fo:table-cell padding="0em"
                   border-top="hidden"
                   border-bottom="hidden"
                   border-before-precedence="force"
                   border-after-precedence="force"
                   display-align="center"
                   text-align="center">
      <xsl:if test="@rowspan">
        <xsl:attribute name="number-rows-spanned">
          <xsl:value-of select="@rowspan"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@colspan">
        <xsl:attribute name="number-columns-spanned">
          <xsl:value-of select="@colspan"/>
        </xsl:attribute>
      </xsl:if>
      <fo:block-container width="3em"/>
    </fo:table-cell>
  </xsl:template>

  <xsl:template match="ul" mode="section.element">
    <fo:block-container space-before="{$section.small-space}"
                        space-before.maximum="{$section.small-space} * {$maximum-ratio}"
                        space-before.minimum="{$section.small-space} * {$minimum-ratio}"
                        space-after="{$section.small-space}"
                        space-after.maximum="{$section.small-space} * {$maximum-ratio}"
                        space-after.minimum="{$section.small-space} * {$minimum-ratio}"
                        keep-together.within-page="always"
                        axf:column-gap="0em"
                        line-height="{$line-height}">
      <xsl:if test="@column-count">
        <xsl:attribute name="axf:column-count">
          <xsl:value-of select="@column-count"/>
        </xsl:attribute>
      </xsl:if>
      <fo:list-block provisional-distance-between-starts="0.85em" 
                     provisional-label-separation="0.3em">
        <xsl:apply-templates select="li" mode="section.ul"/>
      </fo:list-block>
    </fo:block-container>
  </xsl:template>

  <xsl:template match="li" mode="section.ul">
    <fo:list-item>
      <fo:list-item-label start-indent="1em" 
                          end-indent="label-end()">
        <fo:block font-family="{$symbol-font-family}"
                  color="{$border-color}">
          <xsl:text>▷</xsl:text>
        </fo:block>
      </fo:list-item-label>
      <fo:list-item-body start-indent="body-start()" 
                         end-indent="0em">
        <fo:block>
          <xsl:apply-templates select="."/>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>

  <xsl:template match="word-list" mode="section exercise">
    <fo:footnote>
      <fo:inline/>
      <fo:footnote-body>
        <fo:block font-size="0.9em"
                  line-height="{$close-line-height}">
          <fo:block color="{$border-color}"
                    letter-spacing="0.05em"
                    text-align="center"
                    keep-with-next.within-page="always"
                    keep-with-next.within-column="always">
            <xsl:text>新出単語</xsl:text>
          </fo:block>
          <fo:block-container padding="0.2em 2mm 0mm 2mm"
                              border-top="{$border-width} {$border-color} solid"
                              axf:column-count="2"
                              axf:column-gap="0em">
            <xsl:apply-templates select="word" mode="section.word-list"/>
            <xsl:if test="count(word) mod 2 = 1">
              <fo:block>
                <xsl:text>　</xsl:text>
              </fo:block>
            </xsl:if>
          </fo:block-container>
        </fo:block>
      </fo:footnote-body>
    </fo:footnote>
  </xsl:template>

  <xsl:template match="word" mode="section.word-list">
    <fo:block>
      <fo:inline margin="0em 0.5em 0em 0em"
                 padding="0.1em 0.1em 0.1em 0.1em"
                 font-size="0.7em"
                 border="{$thin-border-width} {$border-color} solid">
        <xsl:apply-templates select="so" mode="section.word-list"/>
      </fo:inline>
      <xsl:apply-templates select="sh" mode="section.word-list"/>
      <xsl:if test="shd">
        <xsl:text> (</xsl:text>
        <xsl:for-each select="shd">
          <xsl:apply-templates select="." mode="section.word-list"/>
          <xsl:if test="position() != last()">
            <xsl:text>, </xsl:text>
          </xsl:if>
        </xsl:for-each>
        <xsl:text>)</xsl:text>
      </xsl:if>
      <xsl:if test="ja">
        <fo:inline margin="0em 0.3em 0em 0.3em"
                   font-family="{$symbol-font-family}">
          <xsl:text>…</xsl:text>
        </fo:inline>
        <xsl:apply-templates select="ja" mode="section.word-list"/>
      </xsl:if>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>