<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:func="http://exslt.org/functions"
                xmlns:ewp="http://example.org"
                exclude-result-prefixes="ewp"
                extension-element-prefixes="func"
>

  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

  <!-- Correct the isced with its old value if the attribute v6-value is present-->
  <xsl:function name="func:iscedPatch">
    <xsl:param name="el"/>
    <xsl:variable name="v6_isced">
      <xsl:value-of select="$el/@v6-value" />
    </xsl:variable>

    <xsl:if test="string-length($v6_isced)>0">
      <xsl:value-of select="$v6_isced"/>
    </xsl:if>

    <xsl:if test="string-length($v6_isced)=0">
      <xsl:value-of select="$el"/>
    </xsl:if>
  </xsl:function>



  <!-- Enclose the value of an element between two markers (_ and _) -->
  <xsl:function name="ewp:dumpElement">
    <xsl:param name="elValue"/>
    <xsl:param name="elName"/>
    <xsl:if test="local-name($elValue) = 'isced-f-code'">
      <xsl:value-of select="concat('_', $elName, '=', func:iscedPatch($elValue),'_')"/>
    </xsl:if>
    <xsl:if test="local-name($elValue) != 'isced-f-code'">
      <xsl:value-of select="concat('_', $elName, '=', $elValue,'_')"/>
    </xsl:if>
  </xsl:function>



  <!-- Enclose the value of an attribute between two markers (_@ and @_) -->
  <xsl:function name="ewp:dumpAttribute">
    <xsl:param name="attValue"/>
    <xsl:param name="attName"/>
    <xsl:value-of select="concat('_@', $attName, '=', $attValue,'@_')"/>
  </xsl:function>



  <!-- Return the terminated-as-a-whole value only if its value is true -->
  <xsl:function name="ewp:dumpTerminated">
    <xsl:param name="attValue"/>
    <xsl:if test="$attValue and ($attValue='true' or $attValue='1')">_@terminated-as-a-whole@_</xsl:if>
  </xsl:function>



  <xsl:template match="/">
    <iias>
    <xsl:for-each select="//*[local-name()='iia']">
      <iia>
        <iia-id>
          <xsl:value-of select="*[local-name()='partner'][1]/*[local-name()='iia-id']"/>
        </iia-id>


        <text-to-hash>
          <xsl:value-of select="ewp:dumpTerminated(//*[local-name()='cooperation-conditions']/@*[local-name()='terminated-as-a-whole'])"/>
          <xsl:for-each select="*[local-name()='partner']">
            <xsl:value-of select="ewp:dumpElement(*[local-name()='iia-id'], concat('iia-id', '_', position()))"/>
          </xsl:for-each>

          <xsl:for-each select="*[local-name()='cooperation-conditions']/*"> <!-- for each mobility -->
            <xsl:for-each select=".//*">  <!-- iterate over the inside elements -->
              <!-- but excluding receiving/sending contacts (and their children) and receiving-academic-year-id -->
              <xsl:variable name="notYetDefinedFound" select="count(ancestor-or-self::*[local-name()][@not-yet-defined='true' or @not-yet-defined='1'])" />
              <xsl:if test="count(ancestor::*[local-name() = 'sending-contact']) = 0 and
                                count(ancestor::*[local-name() = 'receiving-contact']) = 0 and
                                local-name() != 'receiving-first-academic-year-id' and
                                local-name() != 'receiving-last-academic-year-id' and
                                $notYetDefinedFound = 0 "
              >
                <xsl:for-each select="@* except @not-yet-defined except @v6-value"> <!-- the value of all the attributes -->
                  <xsl:value-of select="ewp:dumpAttribute(., concat(local-name(../../..), '.',
                    						local-name(../..), '.',
                    						local-name(..), '.',
                    						local-name(.)))"/>
                </xsl:for-each>
                <xsl:if test="count(*) = 0"> <!-- process the element only if it has no children -->
                  <xsl:value-of select="ewp:dumpElement(., concat(local-name(../..), '.',
                					local-name(..), '.',
                					local-name(.)))"/> <!-- the element value -->
                </xsl:if>
              </xsl:if>
            </xsl:for-each>
            <!-- finally the first and the last academic year, as per version 7 -->
            <xsl:value-of select="ewp:dumpElement(*[local-name()='receiving-first-academic-year-id'], 'receiving-first-academic-year-id')"/>
            <xsl:value-of select="ewp:dumpElement(*[local-name()='receiving-last-academic-year-id'], 'receiving-last-academic-year-id')"/>

          </xsl:for-each>
        </text-to-hash>

        <xsl:for-each select="//*[local-name()][@not-yet-defined='true' or @not-yet-defined='1'], //*[local-name()][@v6-value!='']">
          <xsl:choose>
            <xsl:when test="position() = 1">
              <valid-for-approval>false</valid-for-approval>
            </xsl:when>
          </xsl:choose>
        </xsl:for-each>

      </iia>
    </xsl:for-each>
    </iias>
  </xsl:template>
</xsl:stylesheet>