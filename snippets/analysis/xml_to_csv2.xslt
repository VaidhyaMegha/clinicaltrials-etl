<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:strip-space elements="*"/>

    <xsl:param name="sep" select="'.'"/>
    <xsl:param name="fileOID">
        <xsl:value-of select="*[local-name() = 'result']/@*[local-name() = 'index_name']"/>
    </xsl:param>

    <xsl:template match="text()">
        <xsl:variable name="path">
            <xsl:for-each select="ancestor-or-self::*">
                <xsl:variable name="predicate">
                    <xsl:call-template name="genPredicate"/>
                </xsl:variable>
                <xsl:if test="ancestor::*">
                    <xsl:value-of select="$sep"/>
                </xsl:if>
                <xsl:value-of select="concat(local-name(),$predicate)"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="concat($fileOID, '|', $path,name(),'|',.)"/>
        <xsl:text>&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="*">
        <xsl:variable name="path">
            <xsl:for-each select="ancestor-or-self::*">
                <xsl:variable name="predicate">
                    <xsl:call-template name="genPredicate"/>
                </xsl:variable>
                <xsl:if test="ancestor::*">
                    <xsl:value-of select="$sep"/>
                </xsl:if>
                <xsl:value-of select="concat(local-name(),$predicate)"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="@*">
            <xsl:value-of select="concat($fileOID, '|',  $path,$sep,name(),'|',.)"/>
            <xsl:text>&#xA;</xsl:text>
        </xsl:for-each>
        <xsl:if test="not(@*)">
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
        <xsl:apply-templates select="node()"/>
    </xsl:template>

    <xsl:template name="genPredicate">
        <xsl:if test="preceding-sibling::*[local-name()=local-name(current())] or following-sibling::*[local-name()=local-name(current())]">
            <xsl:value-of select="concat('[',count(preceding-sibling::*[local-name()=local-name(current())])+1,']')"/>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
