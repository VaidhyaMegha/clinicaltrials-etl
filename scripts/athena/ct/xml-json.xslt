<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>

    <xsl:template match="/">{
        <xsl:apply-templates select="*"/>}
    </xsl:template>

    <!-- Object or Element Property-->
    <xsl:template match="*">
        "<xsl:value-of select="name()"/>" :
        <xsl:call-template name="Properties">
            <xsl:with-param name="parent" select="'Yes'"/>
        </xsl:call-template>
    </xsl:template>

    <!-- Array Element -->
    <xsl:template match="*" mode="ArrayElement">
        <xsl:call-template name="Properties">
            <xsl:with-param name="parent" select="'Yes'"/>
        </xsl:call-template>
    </xsl:template>

    <!-- Object Properties -->
    <xsl:template name="Properties">
        <xsl:param name="parent"/>
        <xsl:variable name="childName" select="name(*[1])"/>
        <xsl:choose>
            <xsl:when test="not(*|@*)">
                <xsl:choose>
                    <xsl:when test="$parent='Yes'">
                        <xsl:text>&quot;</xsl:text>
                        <xsl:call-template name="string-replace-all">
                            <xsl:with-param name="text">
                                <xsl:value-of select="."/>
                            </xsl:with-param>
                            <xsl:with-param name="replace" select="'&quot;'"/>
                            <xsl:with-param name="by" select="' '"/>
                        </xsl:call-template>
                        <xsl:text>&quot;</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        "<xsl:value-of select="name()"/>":"
                        <xsl:call-template name="string-replace-all">
                            <xsl:with-param name="text">
                                <xsl:value-of select="."/>
                            </xsl:with-param>
                            <xsl:with-param name="replace" select="'&quot;'"/>
                            <xsl:with-param name="by" select="' '"/>
                        </xsl:call-template>
                        "
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="count(*[name()=$childName]) > 1">{
                "<xsl:value-of select="$childName"/>" :[<xsl:apply-templates select="*" mode="ArrayElement"/>]
                }
            </xsl:when>
            <xsl:otherwise>{
                <xsl:apply-templates select="@*"/>
                <xsl:apply-templates select="*"/>
                }
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="following-sibling::*">,</xsl:if>
    </xsl:template>

    <!-- Attribute Property -->
    <xsl:template match="@*">"
        <xsl:value-of select="name()"/>" : "<xsl:value-of select="."/>",
    </xsl:template>

    <xsl:template name="string-replace-all">
        <xsl:param name="text"/>
        <xsl:param name="replace"/>
        <xsl:param name="by"/>
        <xsl:choose>
            <xsl:when test="$text = '' or $replace = '' or not($replace)">
                <!-- Prevent this routine from hanging -->
                <xsl:value-of select="$text"/>
            </xsl:when>
            <xsl:when test="contains($text, $replace)">
                <xsl:value-of select="substring-before($text,$replace)"/>
                <xsl:value-of select="$by"/>
                <xsl:call-template name="string-replace-all">
                    <xsl:with-param name="text" select="substring-after($text,$replace)"/>
                    <xsl:with-param name="replace" select="$replace"/>
                    <xsl:with-param name="by" select="$by"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$text"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>