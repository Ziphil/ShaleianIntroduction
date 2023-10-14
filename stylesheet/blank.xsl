<?xml version="1.0" encoding="utf-8"?>


<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
                xmlns:zp="http://ziphil.com/XSL">
  <xsl:output method="xml" indent="no"/>
  <xsl:strip-space elements="description"/>

  <!-- page-master ============================================================================= -->

  <xsl:template name="blank.page-master">
    <fo:simple-page-master master-name="blank.left"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm">
      <fo:region-body region-name="blank.body"
                      margin-top="23mm + {$bleed-size}"
                      margin-right="20mm + {$bleed-size}"
                      margin-bottom="23mm + {$bleed-size}"
                      margin-left="20mm + {$bleed-size}"/>
      <fo:region-after region-name="blank.left-footer"
                       extent="15mm + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="blank.right"
                           page-width="{$page-width} + {$bleed-size} * 2"
                           page-height="{$page-height} + {$bleed-size} * 2"
                           margin="0mm">
      <fo:region-body region-name="blank.body"
                      margin-top="23mm + {$bleed-size}"
                      margin-right="20mm + {$bleed-size}"
                      margin-bottom="23mm + {$bleed-size}"
                      margin-left="20mm + {$bleed-size}"/>
      <fo:region-after region-name="blank.right-footer"
                       extent="15mm + {$bleed-size}"
                       precedence="true"/>
    </fo:simple-page-master>
    <fo:page-sequence-master master-name="blank">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference master-reference="blank.left" 
                                              odd-or-even="even"/>
        <fo:conditional-page-master-reference master-reference="blank.right" 
                                              odd-or-even="odd"/>
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>
  </xsl:template>

  <!-- main-tag ================================================================================ -->

  <xsl:template match="blank">
    <fo:page-sequence master-reference="blank">
      <fo:flow flow-name="blank.body"/>
    </fo:page-sequence>
  </xsl:template>

</xsl:stylesheet>