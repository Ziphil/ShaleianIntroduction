<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
                xmlns:zp="http://ziphil.com/XSL">
  <xsl:output method="xml" indent="no"/>

  <xsl:function name="zp:enrich">
    <xsl:param name="text"/>
    <xsl:analyze-string select="string-join(zp:convert-escape($text), '')" regex="\{{(.*?)\}}|\[(.*?)\]|/(.*?)/">
      <xsl:matching-substring>
        <xsl:choose>
          <xsl:when test="matches(., '\{.*?\}')">
            <fo:inline font-family="{$shaleia-font-family}"
                       font-size="{$shaleia-font-size}">
              <xsl:sequence select="zp:enrich(regex-group(1))"/>
            </fo:inline>
          </xsl:when>
          <xsl:when test="matches(., '\[.*?\]')">
            <fo:inline font-family="{$shaleia-font-family}"
                       font-size="{$shaleia-font-size}">
              <xsl:sequence select="zp:enrich(regex-group(2))"/>
            </fo:inline>
          </xsl:when>
          <xsl:when test="matches(., '/.*?/')">
            <fo:inline font-style="italic">
              <xsl:sequence select="zp:enrich(regex-group(3))"/>
            </fo:inline>
          </xsl:when>
        </xsl:choose>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="zp:deconvert-escape(.)"/>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:function>

  <xsl:function name="zp:convert-escape">
    <xsl:param name="text"/>
    <xsl:analyze-string select="$text" regex="\{{\{{|\}}\}}|\[\[|\]\]|//">
      <xsl:matching-substring>
        <xsl:choose>
          <xsl:when test="matches(., '\{\{')">
            <xsl:value-of select="'%%CL%%'"/>
          </xsl:when>
          <xsl:when test="matches(., '\}\}')">
            <xsl:value-of select="'%%CR%%'"/>
          </xsl:when>
          <xsl:when test="matches(., '\[\[')">
            <xsl:value-of select="'%%BL%%'"/>
          </xsl:when>
          <xsl:when test="matches(., '\]\]')">
            <xsl:value-of select="'%%BR%%'"/>
          </xsl:when>
          <xsl:when test="matches(., '//')">
            <xsl:value-of select="'%%S%%'"/>
          </xsl:when>
        </xsl:choose>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="."/>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:function>

  <xsl:function name="zp:deconvert-escape">
    <xsl:param name="text"/>
    <xsl:analyze-string select="$text" regex="%%CL%%|%%CR%%|%%BL%%|%%BR%%|%%S%%">
      <xsl:matching-substring>
        <xsl:choose>
          <xsl:when test="matches(., '%%CL%%')">
            <xsl:value-of select="'{'"/>
          </xsl:when>
          <xsl:when test="matches(., '%%CR%%')">
            <xsl:value-of select="'}'"/>
          </xsl:when>
          <xsl:when test="matches(., '%%BL%%')">
            <xsl:value-of select="'['"/>
          </xsl:when>
          <xsl:when test="matches(., '%%BR%%')">
            <xsl:value-of select="']'"/>
          </xsl:when>
          <xsl:when test="matches(., '%%S%%')">
            <xsl:value-of select="'/'"/>
          </xsl:when>
        </xsl:choose>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="."/>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:function>

  <xsl:function name="zp:plain">
    <xsl:param name="text"/>
    <xsl:analyze-string select="$text" regex="\{{(.*?)\}}|\[(.*?)\]|/(.*?)/">
      <xsl:matching-substring>
        <xsl:choose>
          <xsl:when test="matches(., '\{.*?\}')">
            <xsl:value-of select="zp:plain(regex-group(1))"/>
          </xsl:when>
          <xsl:when test="matches(., '\[.*?\]')">
            <xsl:value-of select="zp:plain(regex-group(2))"/>
          </xsl:when>
          <xsl:when test="matches(., '/.*?/')">
            <xsl:value-of select="regex-group(3)"/>
          </xsl:when>
        </xsl:choose>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="."/>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:function>

  <xsl:function name="zp:key">
    <xsl:param name="name"/>
    <xsl:value-of select="translate($name, 'sztdkgfvpbcqxjlrnmyhaâáàeêéèiîíìoôòuûù''', 'あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよ')"/>
  </xsl:function>

  <xsl:function name="zp:or-else">
    <xsl:param name="value"/>
    <xsl:param name="default-value"/>
    <xsl:choose>
      <xsl:when test="$value">
        <xsl:value-of select="$value"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$default-value"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

</xsl:stylesheet>