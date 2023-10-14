<?xml version="1.0" encoding="utf-8"?>


<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
                xmlns:zp="http://ziphil.com/XSL">
  <xsl:output method="xml" indent="no"/>
  <xsl:strip-space elements="description"/>

  <xsl:param name="colophon.page-top-space" select="'20mm'"/>
  <xsl:param name="colophon.page-bottom-space" select="'20mm'"/>

  <!-- page-master ============================================================================= -->

  <xsl:template name="colophon.page-master">
    <fo:simple-page-master master-name="colophon.left"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm">
      <fo:region-body region-name="colophon.body"
                      margin-top="{$colophon.page-top-space} + {$bleed-size}"
                      margin-right="{$page-inner-space} + {$bleed-size}"
                      margin-bottom="{$colophon.page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-outer-space} + {$bleed-size}"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="colophon.right"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm">
      <fo:region-body region-name="colophon.body"
                      margin-top="{$colophon.page-top-space} + {$bleed-size}"
                      margin-right="{$page-outer-space} + {$bleed-size}"
                      margin-bottom="{$colophon.page-bottom-space} + {$bleed-size}"
                      margin-left="{$page-inner-space} + {$bleed-size}"/>
    </fo:simple-page-master>
    <fo:page-sequence-master master-name="colophon">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference master-reference="colophon.left" 
                                              odd-or-even="even"/>
        <fo:conditional-page-master-reference master-reference="colophon.right" 
                                              odd-or-even="odd"/>
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>
  </xsl:template>

  <!-- main-tag ================================================================================ -->

  <xsl:template match="colophon">
    <fo:page-sequence master-reference="colophon"
                      initial-page-number="auto-odd">
      <fo:flow flow-name="colophon.body">
        <fo:block>
          <xsl:call-template name="colophon.colophon"/>
        </fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>

  <!-- tag ===================================================================================== -->

  <xsl:template name="colophon.colophon">
    <fo:block margin-top="130mm"
              start-indent="25mm"
              end-indent="25mm">
      <xsl:apply-templates select="title" mode="colophon"/>
      <xsl:apply-templates select="publish" mode="colophon"/>
      <xsl:call-template name="colophon.author"/>
      <xsl:call-template name="colophon.copyright"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="title" mode="colophon">
    <fo:block padding="2mm 0mm"
              font-size="1em"
              line-height="1"
              text-align="center"
              border-top="{$border-width} {$border-color} solid"
              border-bottom="{$border-width} {$border-color} solid">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="publish" mode="colophon">
    <fo:table-and-caption margin-top="1mm"
                          text-align="center">
      <fo:table width="100%">
        <fo:table-body>
          <xsl:apply-templates select="li" mode="colophon.publish"/>
        </fo:table-body>
      </fo:table>
    </fo:table-and-caption>
  </xsl:template>

  <xsl:template match="li" mode="colophon.publish">
    <fo:table-row>
      <fo:table-cell>
        <fo:block start-indent="8mm"
                  end-indent="0mm"
                  font-size="0.9em"
                  line-height="{$close-line-height}"
                  text-align="left">
          <xsl:apply-templates select="date" mode="section.publish.li"/>
        </fo:block>
      </fo:table-cell>
      <fo:table-cell>
        <fo:block start-indent="0mm"
                  end-indent="8mm"
                  font-size="0.9em"
                  line-height="{$close-line-height}"
                  text-align="right">
          <xsl:apply-templates select="edition" mode="section.publish.li"/>
          <xsl:text> 発行</xsl:text>
        </fo:block>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>

  <xsl:template name="colophon.author">
    <fo:table-and-caption margin-top="1mm"
                          text-align="center">
      <fo:table width="100%">
        <fo:table-body>
          <fo:table-row>
            <fo:table-cell display-align="center">
              <fo:block start-indent="3mm"
                        end-indent="0mm"
                        font-size="0.8em"
                        line-height="{$close-line-height}" 
                        text-align="left">
                <xsl:text>著者</xsl:text>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block start-indent="0mm"
                        end-indent="3mm"
                        font-size="1.2em"
                        line-height="{$close-line-height}"
                        text-align="right">
                <xsl:apply-templates select="author" mode="colophon"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell/>
            <fo:table-cell>
              <fo:block start-indent="0mm"
                        end-indent="3mm"
                        font-size="0.9em"
                        line-height="{$close-line-height}"
                        text-align="right">
                <xsl:apply-templates select="mail" mode="colophon"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell/>
            <fo:table-cell>
              <fo:block start-indent="0mm"
                        end-indent="3mm"
                        font-size="0.9em"
                        line-height="{$close-line-height}"
                        text-align="right">
                <xsl:apply-templates select="url" mode="colophon"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
    </fo:table-and-caption>
  </xsl:template>

  <xsl:template name="colophon.copyright">
    <fo:block margin-top="1mm"
              font-size="0.8em"
              line-height="{$close-line-height}"
              border-top="{$border-width} {$border-color} solid">
      <fo:inline padding="0mm 1mm">
        <xsl:text>© </xsl:text>
        <xsl:apply-templates select="year" mode="colophon"/>
        <xsl:text>　</xsl:text>
        <xsl:apply-templates select="author" mode="colophon"/>
      </fo:inline>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>