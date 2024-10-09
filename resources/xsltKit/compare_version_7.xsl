<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:func="http://exslt.org/functions"
                xmlns:ewp="http://example.org"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="ewp"
                extension-element-prefixes="func">

  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

  <xsl:function name="func:iscedPatch">
    <xsl:param name="el" as="element()*"/> <!-- Updated to expect element nodes -->
    <xsl:choose>
      <xsl:when test="$el/@v6-value">
        <xsl:value-of select="$el/@v6-value"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$el"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

<xsl:function name="ewp:dumpElement">
  <xsl:param name="elValue" as="element()*"/>
  <xsl:param name="elName"/>
  <xsl:if test="normalize-space($elValue) != '' or $elValue/*">
    <!-- Process only if the element is not empty -->
    <xsl:choose>
      <!-- Special handling for <blended> elements -->
      <xsl:when test="local-name($elValue) = 'blended'">
        <xsl:choose>
          <xsl:when test="normalize-space($elValue) = 'true'">
            <xsl:value-of select="concat('_', $elName, '=', '1', '_')"/>
          </xsl:when>
          <xsl:when test="normalize-space($elValue) = 'false'">
            <xsl:value-of select="concat('_', $elName, '=', '0', '_')"/>
          </xsl:when>
          <xsl:otherwise>
            <!-- Preserve the value if it's neither 'true' nor 'false' -->
            <xsl:value-of select="concat('_', $elName, '=', $elValue, '_')"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>

      <xsl:when test="local-name($elValue) = 'language'">
        <!-- Extract the language code before the hyphen if present -->
        <xsl:variable name="langCode" select="substring-before($elValue, '-')"/>
        <!-- Use the substring before the hyphen if present; otherwise, use the entire value -->
        <xsl:choose>
          <xsl:when test="$langCode">
            <xsl:value-of select="concat('_', $elName, '=', lower-case($langCode), '_')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat('_', $elName, '=', lower-case($elValue), '_')"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>

      <xsl:when test="local-name($elValue) = 'total-months-per-year' or local-name($elValue) = 'mobilities-per-year' or local-name($elValue) = 'total-days-per-year'">
        <!-- Apply the ewp:formatDecimal function only to specific elements if the value is numeric -->
        <xsl:choose>
          <xsl:when test="number($elValue) = number($elValue)">
            <xsl:value-of select="concat('_', $elName, '=', ewp:formatDecimal(xs:decimal($elValue)),'_')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat('_', $elName, '=', $elValue,'_')"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>


      <!-- Handling for ISCED-F codes that may require patching -->
      <xsl:when test="local-name($elValue) = 'isced-f-code'">
        <xsl:value-of select="concat('_', $elName, '=', func:iscedPatch($elValue), '_')"/>
      </xsl:when>
      <!-- Default handling for all other cases -->
      <xsl:otherwise>
        <xsl:value-of select="concat('_', $elName, '=', $elValue, '_')"/>
      </xsl:otherwise>



    </xsl:choose>
  </xsl:if>
</xsl:function>

<xsl:function name="ewp:dumpAttribute">
  <xsl:param name="attValue"/>
  <xsl:param name="attName"/>
  <xsl:choose>
    <xsl:when test="$attName = 'total-months-per-year' or $attName = 'mobilities-per-year' or $attName = 'total-days-per-year'">
      <!-- Apply the ewp:formatDecimal function only to specific attributes if the value is numeric -->
      <xsl:choose>
        <xsl:when test="number($attValue) = number($attValue)">
          <xsl:value-of select="concat('_@', $attName, '=', ewp:formatDecimal(xs:decimal($attValue)),'@_')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('_@', $attName, '=', $attValue,'@_')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="concat('_@', $attName, '=', $attValue,'@_')"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:function>

  <xsl:function name="ewp:formatDecimal">
    <xsl:param name="value" as="xs:decimal"/> <!-- Updated to expect decimal values -->
    <xsl:choose>
      <xsl:when test="matches(string($value), '^-?[0-9]+(\.[0-9]+)?$')">
        <xsl:value-of select="format-number($value, '0.################')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="string($value)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!-- Dummy implementation for the ewp:dumpTerminated function -->
<xsl:function name="ewp:dumpTerminated">
  <xsl:param name="terminatedValue" as="attribute()*"/>
  <!-- Check if the attribute terminated-as-a-whole is present and equals "true" or "1" -->
  <xsl:choose>
    <xsl:when test="$terminatedValue = 'true' or $terminatedValue = '1'">
      <!-- If it is true (or "1"), output "1" -->
      <xsl:value-of select="'terminated-as-a-whole=1'"/>
    </xsl:when>
    <xsl:when test="$terminatedValue = 'false' or $terminatedValue = '0'">
      <!-- If it is true (or "1"), output "1" -->
      <xsl:value-of select="'terminated-as-a-whole=0'"/>
    </xsl:when>
    <xsl:otherwise>
      <!-- In any other case, output the attribute's original value -->
      <xsl:value-of select="concat('terminated-as-a-whole=', $terminatedValue)"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:function>

  <xsl:template match="/">
    <iias>
      <xsl:for-each select="//*[local-name()='iia']">
        <iia>
          <iia-id>
            <xsl:value-of select="*[local-name()='partner'][1]/*[local-name()='iia-id']"/>
          </iia-id>
          <text-to-hash>
            <!-- Output terminated-as-a-whole if it exists and equals to "true" or "1" -->
            <xsl:value-of select="ewp:dumpTerminated(//*[local-name()='cooperation-conditions']/@*[local-name()='terminated-as-a-whole'])"/>

            <!-- Iterate through each partner's iia-id -->
            <xsl:for-each select="*[local-name()='partner']">
              <xsl:sort select="*[local-name()='iia-id']" data-type="text" order="ascending"/>
              <xsl:value-of select="ewp:dumpElement(*[local-name()='iia-id'], concat('iia-id', '_', position()))"/>
            </xsl:for-each>

            <!-- Flatten and process cooperation-conditions -->
          <xsl:for-each select="*[local-name()='cooperation-conditions']">
            <xsl:call-template name="flatten-elements">
              <xsl:with-param name="parent" select="''"/>
            </xsl:call-template>
          </xsl:for-each>

          </text-to-hash>

          <!-- Determine whether this record is valid for approval -->
          <xsl:for-each select="//*[local-name()][@not-yet-defined='true'] | //*[local-name()][@v6-value!='']">
            <xsl:if test="position() = 1">
              <valid-for-approval>false</valid-for-approval>
            </xsl:if>
          </xsl:for-each>
        </iia>
      </xsl:for-each>
    </iias>
  </xsl:template>


  <!-- Template to recursively flatten and append parent node names -->
  <xsl:template name="flatten-elements">
    <xsl:param name="parent"/>

    <xsl:for-each select="./*">
      <!-- Sort elements to ensure consistent sequence -->
      <xsl:sort select="local-name()"/>
      <xsl:sort select="string(.)"/>

	  <xsl:if test="not(contains($parent, 'sending-contact')) and not(contains($parent, 'receiving-contact'))">
		
		  <!-- Process child elements -->
		  <xsl:variable name="new-parent">
			<xsl:choose>
			  <xsl:when test="$parent != ''">
				<xsl:value-of select="concat($parent, '.', local-name())"/>
			  </xsl:when>
			  <xsl:otherwise>
				<xsl:value-of select="local-name()"/>
			  </xsl:otherwise>
			</xsl:choose>
		  </xsl:variable>
		  <xsl:call-template name="flatten-elements">
			<xsl:with-param name="parent" select="$new-parent"/>
		  </xsl:call-template>
		  <!-- If the element has attributes, sort and print them -->
		  <xsl:if test="@*">
			<xsl:for-each select="@*">
			  <xsl:sort select="local-name()"/>
			  <xsl:sort select="string(.)"/>
			  <xsl:value-of select="ewp:dumpAttribute(., concat($new-parent, '.', local-name()))"/>
			</xsl:for-each>
		  </xsl:if>
		  <!-- Elements without children are processed to create structured output -->
		  <xsl:if test="not(*) and normalize-space(.) != ''">
			<xsl:value-of select="ewp:dumpElement(., $new-parent)"/>
		  </xsl:if>
	  </xsl:if>  
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>