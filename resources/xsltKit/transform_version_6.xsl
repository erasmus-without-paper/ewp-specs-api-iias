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
    <xsl:param name="el"/>
    <xsl:value-of select="concat('_', $el,'_')"/>
  </xsl:function>



  <!-- Enclose the value of an attribute between two markers (_@ and @_) -->
  <xsl:function name="ewp:dumpAttribute">
    <xsl:param name="att"/>
    <xsl:value-of select="concat('_@', $att,'@_')"/>
  </xsl:function>



  <xsl:template match="/">
    
    <xsl:for-each select="//*[local-name()='iia']">
      <iia>
        <iia-id>
          <xsl:value-of select="*[local-name()='partner'][1]/*[local-name()='iia-id']"/>
        </iia-id>


        <text-to-hash>
          <xsl:for-each select="*[local-name()='partner']">
            <xsl:value-of select="ewp:dumpElement(*[local-name()='iia-id'])"/>
          </xsl:for-each>

          <xsl:for-each select="*[local-name()='cooperation-conditions']/*"> <!-- for each mobilities -->
            <xsl:for-each select=".//*">  <!-- iterate over the inside elements -->
              <!-- but excluding receiving/sending contacts (and their children) and receiving-academic-year-id -->
              <xsl:if test="local-name() != 'sending-contact' and 
                                local-name() != 'receiving-contact' and
                                local-name(..) != 'sending-contact' and 
                                local-name(..) != 'receiving-contact' and
                                local-name() != 'receiving-academic-year-id'"
              >
                <xsl:for-each select="@*"> <!-- the value of all the attributes -->
                    <xsl:value-of select="ewp:dumpAttribute(.)"/>
                </xsl:for-each>
                <xsl:if test="count(*)=0"> <!-- process the element only if it has no children -->                  
                  <xsl:value-of select="ewp:dumpElement(.)"/> <!-- the element value -->
                </xsl:if>
              </xsl:if>
            </xsl:for-each>
            <!-- finally the first and the last academic year, as per version 7 -->
            <xsl:value-of select="ewp:dumpElement(*[local-name()='receiving-academic-year-id'][1])"/>
            <xsl:value-of select="ewp:dumpElement(*[local-name()='receiving-academic-year-id'][last()])"/>

          </xsl:for-each>
        </text-to-hash>
      </iia>
    </xsl:for-each>    
  </xsl:template>
</xsl:stylesheet>