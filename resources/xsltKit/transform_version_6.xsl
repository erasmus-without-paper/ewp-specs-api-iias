<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:func="http://exslt.org/functions"
                xmlns:ewp="http://example.org"
                exclude-result-prefixes="ewp"
                extension-element-prefixes="func"
>

  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

  <!-- Enclose the value of an element between two markers (_ and _) -->
  <xsl:function name="ewp:dumpElement">
    <xsl:param name="elValue"/>
    <xsl:param name="elName"/>
    <xsl:value-of select="concat('_', $elName, '=', $elValue,'_')"/>
  </xsl:function>



  <!-- Enclose the value of an attribute between two markers (_@ and @_) -->
  <xsl:function name="ewp:dumpAttribute">
    <xsl:param name="attValue"/>
    <xsl:param name="attName"/>
    <xsl:value-of select="concat('_@', $attName, '=', $attValue,'@_')"/>
  </xsl:function>



  <xsl:template match="/">
    <iias>
    <xsl:for-each select="//*[local-name()='iia']">
      <iia>
        <iia-id>
          <xsl:value-of select="*[local-name()='partner'][1]/*[local-name()='iia-id']"/>
        </iia-id>


        <text-to-hash>
          <xsl:for-each select="*[local-name()='partner']">
            <xsl:value-of select="ewp:dumpElement(*[local-name()='iia-id'], concat('iia-id', '_', position()))"/>
          </xsl:for-each>

          <xsl:for-each select="*[local-name()='cooperation-conditions']/*"> <!-- for each mobility -->
            <xsl:for-each select=".//*">  <!-- iterate over the inside elements -->
              <!-- but excluding receiving/sending contacts (and their children) and receiving-academic-year-id -->
              <xsl:if test="count(ancestor::*[local-name() = 'sending-contact']) = 0 and
                                count(ancestor::*[local-name() = 'receiving-contact']) = 0 and
                                local-name() != 'receiving-academic-year-id'"
              >
                <xsl:if test="count(*) = 0"> <!-- process the element only if it has no children -->
                  <xsl:value-of select="ewp:dumpElement(., concat(local-name(../..), '.',
                					local-name(..), '.',
                					local-name(.)))"/> <!-- the element value -->
                </xsl:if>
              </xsl:if>
            </xsl:for-each>
            <!-- finally the first and the last academic year, as per version 7 -->
            <xsl:value-of select="ewp:dumpElement(*[local-name()='receiving-academic-year-id'][1], 'receiving-first-academic-year-id')"/>
            <xsl:value-of select="ewp:dumpElement(*[local-name()='receiving-academic-year-id'][last()], 'receiving-last-academic-year-id')"/>

          </xsl:for-each>
        </text-to-hash>
      </iia>
    </xsl:for-each>
    </iias>
  </xsl:template>
</xsl:stylesheet>