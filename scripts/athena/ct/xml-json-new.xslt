<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>



    <!--what's remaining-->

    
    <!-- name="oversight_info" type="oversight_info_struct" minOccurs="0"/>-->
    <!-- name="brief_summary" type="textblock_struct" minOccurs="0"/>-->
    <!-- name="detailed_description" type="textblock_struct" minOccurs="0"/>-->
    <!-- name="overall_status" type="overall_status_enum"/>-->
    <!-- name="last_known_status" type="overall_status_enum" minOccurs="0"/>-->
    <!-- name="why_stopped" type="xs:string" minOccurs="0"/>-->
    <!-- name="start_date" type="variable_date_struct" minOccurs="0"/>-->
    <!-- name="completion_date" type="variable_date_struct" minOccurs="0"/>-->
    <!-- name="primary_completion_date" type="variable_date_struct" minOccurs="0"/>-->
    <!-- name="phase" type="phase_enum" minOccurs="0"/>-->
    <!-- name="study_type" type="study_type_enum"/>-->
    <!-- name="has_expanded_access" type="yes_no_enum" minOccurs="0"/>-->
    <!-- name="expanded_access_info" type="expanded_access_info_struct" minOccurs="0"/>-->
    <!-- name="study_design_info" type="study_design_info_struct" minOccurs="0"/>-->
    <!-- name="target_duration" type="xs:string" minOccurs="0"/>-->
    <!-- name="primary_outcome" type="protocol_outcome_struct" minOccurs="0" maxOccurs="unbounded"/>-->
    <!-- name="secondary_outcome" type="protocol_outcome_struct" minOccurs="0" maxOccurs="unbounded"/>-->
    <!-- name="other_outcome" type="protocol_outcome_struct" minOccurs="0" maxOccurs="unbounded"/>-->
    <!-- name="number_of_arms" type="xs:integer" minOccurs="0"/>-->
    <!-- name="number_of_groups" type="xs:integer" minOccurs="0"/>-->
    <!-- name="enrollment" type="enrollment_struct" minOccurs="0"/>-->
    <!-- name="condition" type="xs:string" minOccurs="0" maxOccurs="unbounded"/>-->
    <!-- name="arm_group" type="arm_group_struct" minOccurs="0" maxOccurs="unbounded"/>-->
    <!-- name="intervention" type="intervention_struct" minOccurs="0" maxOccurs="unbounded"/>-->
    <!-- name="biospec_retention" type="biospec_retention_enum" minOccurs="0"/>-->
    <!-- name="biospec_descr" type="textblock_struct" minOccurs="0"/>-->
    <!-- name="eligibility" type="eligibility_struct" minOccurs="0"/>-->
    <!-- name="overall_official" type="investigator_struct" minOccurs="0" maxOccurs="unbounded"/>-->
    <!-- name="overall_contact" type="contact_struct" minOccurs="0"/>-->
    <!-- name="overall_contact_backup" type="contact_struct" minOccurs="0"/>-->
    <!-- name="location" type="location_struct" minOccurs="0" maxOccurs="unbounded"/>-->
    <!-- name="location_countries" type="countries_struct" minOccurs="0"/>-->
    <!-- name="removed_countries" type="countries_struct" minOccurs="0"/>-->
    <!-- name="link" type="link_struct" minOccurs="0" maxOccurs="unbounded"/>-->
    <!-- name="reference" type="reference_struct" minOccurs="0" maxOccurs="unbounded"/>-->
    <!-- name="results_reference" type="reference_struct" minOccurs="0" maxOccurs="unbounded"/>-->
    <!-- name="verification_date" type="variable_date_type" minOccurs="0"/>-->
    <!--&lt;!&ndash; === Old Dates will be dropped in a few months (sometime in 2018) ========= &ndash;&gt;-->
    <!-- name="lastchanged_date" type="variable_date_type" minOccurs="0"/>-->
    <!-- name="firstreceived_date" type="variable_date_type" minOccurs="0"/>-->
    <!-- name="firstreceived_results_date" type="variable_date_type" minOccurs="0"/>-->
    <!-- name="firstreceived_results_disposition_date" type="variable_date_type" minOccurs="0"/>-->
    <!--&lt;!&ndash; === New Dates ============================================================ &ndash;&gt;-->
    <!-- name="study_first_submitted" type="variable_date_type" minOccurs="0"/>-->
    <!-- name="study_first_submitted_qc" type="variable_date_type" minOccurs="0"/>-->
    <!-- name="study_first_posted" type="variable_date_struct" minOccurs="0"/>-->
    <!-- name="results_first_submitted" type="variable_date_type" minOccurs="0"/>-->
    <!-- name="results_first_submitted_qc" type="variable_date_type" minOccurs="0"/>-->
    <!-- name="results_first_posted" type="variable_date_struct" minOccurs="0"/>-->
    <!-- name="disposition_first_submitted" type="variable_date_type" minOccurs="0"/>-->
    <!-- name="disposition_first_submitted_qc" type="variable_date_type" minOccurs="0"/>-->
    <!-- name="disposition_first_posted" type="variable_date_struct" minOccurs="0"/>-->
    <!-- name="last_update_submitted" type="variable_date_type" minOccurs="0"/>-->
    <!-- name="last_update_submitted_qc" type="variable_date_type" minOccurs="0"/>-->
    <!-- name="last_update_posted" type="variable_date_struct" minOccurs="0"/>-->
    <!--&lt;!&ndash; === End of Dates ========================================================= &ndash;&gt;-->
    <!-- name="responsible_party" type="responsible_party_struct" minOccurs="0"/>-->
    <!-- name="keyword" type="xs:string" minOccurs="0" maxOccurs="unbounded"/>-->
    <!-- name="condition_browse" type="browse_struct" minOccurs="0"/>-->
    <!-- name="intervention_browse" type="browse_struct" minOccurs="0"/>-->
    <!-- name="patient_data" type="patient_data_struct" minOccurs="0"/>-->
    <!-- name="study_docs" type="study_docs_struct" minOccurs="0"/>-->
    <!-- name="clinical_results" type="clinical_results_struct" minOccurs="0"/>-->

    <xsl:template match="/">{
        "required_header":{
            "download_date":"<xsl:value-of select="/clinical_study/required_header/download_date"/>",
            "link_text":"<xsl:value-of select="/clinical_study/required_header/link_text"/>",
            "url":"<xsl:value-of select="/clinical_study/required_header/url"/>"
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
        "official_title":"<xsl:value-of select="/clinical_study/official_title"/>",
        "sponsors":{
            "lead_sponsor":{
                "agency":"<xsl:value-of select="/clinical_study/sponsors/lead_sponsor/agency"/>",
                "agency_class":"<xsl:value-of select="/clinical_study/sponsors/lead_sponsor/agency_class"/>"
            },
            "collaborator":[
                <xsl:for-each select="/clinical_study/sponsors/collaborator">{
                        "agency":"<xsl:value-of select="agency"/>",
                        "agency_class":"<xsl:value-of select="agency_class"/>"
                    }<xsl:if test="position() != last()">,</xsl:if>
                </xsl:for-each>
            ]
        },
        "source":"<xsl:value-of select="/clinical_study/source"/>",
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
                            {"first_name":"<xsl:value-of select="first_name"/>",
                            "middle_name":"<xsl:value-of select="middle_name"/>",
                            "last_name":"<xsl:value-of select="last_name"/>",
                            "degrees":"<xsl:value-of select="degrees"/>",
                            "role":"<xsl:value-of select="role"/>",
                            "affiliation":"<xsl:value-of select="affiliation"/>"}<xsl:if test="position() != last()">,</xsl:if>
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