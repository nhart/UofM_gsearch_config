<?xml version="1.0" encoding="UTF-8"?>
<!-- RELS-EXT -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:foxml="info:fedora/fedora-system:def/foxml#"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
     exclude-result-prefixes="foxml rdf">

  <xsl:template match="foxml:datastream[@ID='RELS-EXT']/foxml:datastreamVersion[last()]" name='index_RELS-EXT'>
    <xsl:param name="content"/>
    <xsl:param name="prefix">RELS_EXT_</xsl:param>
    <xsl:param name="suffix">_ms</xsl:param>

    <xsl:apply-templates select="$content//rdf:Description/* | $content//rdf:description/*" mode="index_RELS-EXT">
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- XXX: Hack the isMemberOfCollection value apart to not mess with Danny Joris's solr views -->
  <xsl:template match="*[local-name()='isMemberOfCollection' and @rdf:resource]" mode="index_RELS-EXT">
    <xsl:param name="prefix"/>
    <xsl:param name="suffix"/>

    <field>
      <xsl:attribute name="name">
        <xsl:value-of select="concat($prefix, local-name(), '_uri', $suffix)"/>
      </xsl:attribute>
      <xsl:value-of select="substring-after(@rdf:resource, '/')"/>
    </field>
  </xsl:template>
  <!-- XXX: End of hack. -->

  <xsl:template match="*[@rdf:resource]" mode="index_RELS-EXT">
    <xsl:param name="prefix"/>
    <xsl:param name="suffix"/>

    <field>
      <xsl:attribute name="name">
        <xsl:value-of select="concat($prefix, local-name(), '_uri', $suffix)"/>
      </xsl:attribute>
      <xsl:value-of select="@rdf:resource"/>
    </field>
  </xsl:template>

  <xsl:template match="*[not(@rdf:resource)]" mode="index_RELS-EXT">
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

  <xsl:template match="text()" mode="index_RELS-EXT"/>
</xsl:stylesheet>
