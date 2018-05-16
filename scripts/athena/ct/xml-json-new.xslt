<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>

    <xsl:template match="/">{
        "required_header":{
            "download_date":"<xsl:value-of select="/clinical_study/required_header/download_date"/>",
            "link_text":"<xsl:value-of select="/clinical_study/required_header/link_text"/>",
            "url":"<xsl:value-of select="/clinical_study/required_header/url"/>",
        },
        "id_info":{
            "org_study_id":"<xsl:value-of select="/clinical_study/id_info/org_study_id"/>",
            "secondary_id":[
                <xsl:for-each select="/clinical_study/id_info/secondary_id">
                    "<xsl:value-of select="."/>"<xsl:if test="position() != last()">,</xsl:if>
                </xsl:for-each>
            ],
            "nct_id":"<xsl:value-of select="/clinical_study/id_info/nct_id"/>",
            "nct_alias":[
                <xsl:for-each select="/clinical_study/id_info/nct_alias">
                    "<xsl:value-of select="."/>"<xsl:if test="position() != last()">,</xsl:if>
                </xsl:for-each>
            ]
        },
        "brief_title":"<xsl:value-of select="/clinical_study/brief_title"/>",
        "acronym":"<xsl:value-of select="/clinical_study/acronym"/>",
        "keyword": [
        <xsl:for-each select="/clinical_study/keyword">
            "<xsl:value-of select="."/>"<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ],
        "condition": [
        <xsl:for-each select="/clinical_study/condition">
            "<xsl:value-of select="."/>"<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ],
        "primary_outcome": [
        <xsl:for-each select="/clinical_study/primary_outcome">
            {
            "measure":"<xsl:value-of select="measure"/>",
            "time_frame":"<xsl:value-of select="time_frame"/>",
            "description":"<xsl:call-template name="string-replace-all">
                <xsl:with-param name="text">
                    <xsl:value-of select="description"/>
                </xsl:with-param>
                <xsl:with-param name="replace" select="'&quot;'"/>
                <xsl:with-param name="by" select="' '"/>
            </xsl:call-template>"}<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ],
        "secondary_outcome": [
        <xsl:for-each select="/clinical_study/secondary_outcome">
            {
            "measure":"<xsl:value-of select="measure"/>",
            "time_frame":"<xsl:value-of select="time_frame"/>",
            "description":"<xsl:call-template name="string-replace-all">
                <xsl:with-param name="text">
                    <xsl:value-of select="description"/>
                </xsl:with-param>
                <xsl:with-param name="replace" select="'&quot;'"/>
                <xsl:with-param name="by" select="' '"/>
            </xsl:call-template>"}<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ],
        "other_outcome": [
        <xsl:for-each select="/clinical_study/other_outcome">
            {
            "measure":"<xsl:value-of select="measure"/>",
            "time_frame":"<xsl:value-of select="time_frame"/>",
            "description":"<xsl:call-template name="string-replace-all">
                <xsl:with-param name="text">
                    <xsl:value-of select="description"/>
                </xsl:with-param>
                <xsl:with-param name="replace" select="'&quot;'"/>
                <xsl:with-param name="by" select="' '"/>
            </xsl:call-template>"}<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ],
        "reference": [
        <xsl:for-each select="/clinical_study/reference">
            {
            "citation":"<xsl:value-of select="citation"/>",
            "PMID":"<xsl:value-of select="PMID"/>"
            }<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ],
        "results_reference": [
        <xsl:for-each select="/clinical_study/results_reference">
            {
            "citation":"<xsl:value-of select="citation"/>",
            "PMID":"<xsl:value-of select="PMID"/>"
            }<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ],
        "link": [
        <xsl:for-each select="/clinical_study/link">
            {
            "url":"<xsl:value-of select="url"/>",
            "description":"<xsl:value-of select="description"/>"
            }<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ],
        "location": [
        <xsl:for-each select="/clinical_study/location">
            {
            "facility": {"name":"<xsl:value-of select="facility/name"/>", 
                        "address":{
                            "city":"<xsl:value-of select="facility/address/city"/>", 
                            "state":"<xsl:value-of select="facility/address/state"/>",
                            "zip":"<xsl:value-of select="facility/address/zip"/>",
                            "country":"<xsl:value-of select="facility/address/country"/>"}},
            "status":"<xsl:value-of select="status"/>",
            "contact": {"first_name":"<xsl:value-of select="contact/first_name"/>",
                        "middle_name":"<xsl:value-of select="contact/middle_name"/>",
                        "last_name":"<xsl:value-of select="contact/last_name"/>",
                        "degrees":"<xsl:value-of select="contact/degrees"/>",
                        "phone":"<xsl:value-of select="contact/phone"/>",
                        "phone_ext":"<xsl:value-of select="contact/phone_ext"/>",
                        "email":"<xsl:value-of select="contact/email"/>"},
            "contact_backup":{"first_name":"<xsl:value-of select="contact_backup/first_name"/>",
                                "middle_name":"<xsl:value-of select="contact_backup/middle_name"/>",
                                "last_name":"<xsl:value-of select="contact_backup/last_name"/>",
                                "degrees":"<xsl:value-of select="contact_backup/degrees"/>",
                                "phone":"<xsl:value-of select="contact_backup/phone"/>",
                                "phone_ext":"<xsl:value-of select="contact_backup/phone_ext"/>",
                                "email":"<xsl:value-of select="contact_backup/email"/>"},
            "investigator":[
                 <xsl:for-each select="investigator">
                            {"first_name":"<xsl:value-of select="investigator/first_name"/>",
                            "middle_name":"<xsl:value-of select="investigator/middle_name"/>",
                            "last_name":"<xsl:value-of select="investigator/last_name"/>",
                            "degrees":"<xsl:value-of select="investigator/degrees"/>",
                            "role":"<xsl:value-of select="investigator/role"/>",
                            "affiliation":"<xsl:value-of select="investigator/affiliation"/>"}<xsl:if test="position() != last()">,</xsl:if>
                 </xsl:for-each>]
            }<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ],

        "location_countries": [
        <xsl:for-each select="/clinical_study/location_countries/country">
            "<xsl:value-of select="."/>"<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ],
        "removed_countries": [
        <xsl:for-each select="/clinical_study/removed_countries/country">
            "<xsl:value-of select="."/>"<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ]
        }
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