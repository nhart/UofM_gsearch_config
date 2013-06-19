<?xml version="1.0" encoding="UTF-8"?>
<!-- RELS-INT 
@todo make the subject of a relationship included in the name of the field-->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:foxml="info:fedora/fedora-system:def/foxml#"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
     exclude-result-prefixes="foxml rdf">

  <xsl:template match="foxml:datastream[@ID='RELS-INT']/foxml:datastreamVersion[last()]" name='index_RELS-INT'>
    <xsl:param name="content"/>
    <xsl:param name="prefix">RELS_INT_</xsl:param>
    <xsl:param name="suffix">_ms</xsl:param>

    <xsl:apply-templates select="$content//rdf:Description/*" mode="index_RELS-INT">
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="*[@rdf:resource]" mode="index_RELS-INT">
    <xsl:param name="prefix"/>
    <xsl:param name="suffix"/>

    <field>
      <xsl:attribute name="name">
        <xsl:value-of select="concat($prefix, local-name(), '_uri', $suffix)"/>
      </xsl:attribute>
      <xsl:value-of select="@rdf:resource"/>
    </field>
  </xsl:template>

  <xsl:template match="*[not(@rdf:resource)]" mode="index_RELS-INT">
    <xsl:param name="prefix"/>
    <xsl:param name="suffix"/>

    <xsl:variable name="textValue" select="normalize-space(text())"/>
    <xsl:if test="$textValue">
      <field>
        <xsl:attribute name="name">
          <xsl:value-of select="concat($prefix, local-name(), '_literal', $suffix)"/>
        </xsl:attribute>
        <xsl:value-of select="text()"/>
      </field>
    </xsl:if>
  </xsl:template>

  <xsl:template match="text()" mode="index_RELS-INT"/>
</xsl:stylesheet>
