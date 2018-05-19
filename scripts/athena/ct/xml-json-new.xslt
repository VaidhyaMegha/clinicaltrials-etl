<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>



    <!--what's remaining-->


    <!-- name="overall_official" type="investigator_struct" minOccurs="0" maxOccurs="unbounded"/>-->
    <!-- name="overall_contact" type="contact_struct" minOccurs="0"/>-->
    <!-- name="overall_contact_backup" type="contact_struct" minOccurs="0"/>-->
    <!-- name="responsible_party" type="responsible_party_struct" minOccurs="0"/>-->
    <!-- name="patient_data" type="patient_data_struct" minOccurs="0"/>-->
    <!-- name="study_docs" type="study_docs_struct" minOccurs="0"/>-->
    <!-- name="clinical_results" type="clinical_results_struct" minOccurs="0"/>-->

    <xsl:template match="/">{
        "intervention": [
        <xsl:for-each select="/clinical_study/intervention">{
            "intervention_type":"<xsl:value-of select="intervention_type"/>",
            "intervention_name":"<xsl:value-of select="intervention_name"/>",
            "description":"<xsl:value-of select="description"/>",
            "arm_group_label": [
                <xsl:for-each select="arm_group_label">
                    "<xsl:value-of select="."/>"<xsl:if test="position() != last()">,</xsl:if>
                </xsl:for-each>
            ],
            "other_name": [
            <xsl:for-each select="other_name">
                "<xsl:value-of select="."/>"<xsl:if test="position() != last()">,</xsl:if>
            </xsl:for-each>
            ]
            }<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ],
        "eligibility": {
            "study_pop": {
                "textblock":"<xsl:call-template name="string-replace-all">
                    <xsl:with-param name="text">
                        <xsl:value-of select="/clinical_study/eligibility/textblock"/>
                    </xsl:with-param>
                    <xsl:with-param name="replace" select="'&quot;'"/>
                    <xsl:with-param name="by" select="' '"/>
                </xsl:call-template>"
            },
        "overall_official": [
        <xsl:for-each select="/clinical_study/overall_official">{
            "first_name":"<xsl:value-of select="first_name"/>",
            "middle_name":"<xsl:value-of select="middle_name"/>",
            "last_name":"<xsl:value-of select="last_name"/>",
            "degrees":"<xsl:value-of select="degrees"/>",
            "role":"<xsl:value-of select="role"/>",
            "affiliation":"<xsl:value-of select="affiliation"/>"
            }<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ],
        "overall_contact": {
            "first_name":"<xsl:value-of select="/clinical_study/overall_contact/first_name"/>",
            "middle_name":"<xsl:value-of select="/clinical_study/overall_contact/middle_name"/>",
            "last_name":"<xsl:value-of select="/clinical_study/overall_contact/last_name"/>",
            "degrees":"<xsl:value-of select="/clinical_study/overall_contact/degrees"/>",
            "phone":"<xsl:value-of select="/clinical_study/overall_contact/phone"/>",
            "phone_ext":"<xsl:value-of select="/clinical_study/overall_contact/phone_ext"/>"
            "email":"<xsl:value-of select="/clinical_study/overall_contact/email"/>"
        },
            "sampling_method":"<xsl:value-of select="/clinical_study/eligibility/sampling_method"/>",
            "criteria":{
                "textblock":"<xsl:call-template name="string-replace-all">
                    <xsl:with-param name="text">
                        <xsl:value-of select="/clinical_study/criteria/textblock"/>
                    </xsl:with-param>
                    <xsl:with-param name="replace" select="'&quot;'"/>
                    <xsl:with-param name="by" select="' '"/>
                </xsl:call-template>"
            },
            "gender":"<xsl:value-of select="/clinical_study/eligibility/gender"/>",
            "gender_based":"<xsl:value-of select="/clinical_study/eligibility/gender_based"/>",
            "minimum_age":"<xsl:value-of select="/clinical_study/eligibility/minimum_age"/>",
            "maximum_age":"<xsl:value-of select="/clinical_study/eligibility/maximum_age"/>",
            "healthy_volunteers":"<xsl:value-of select="/clinical_study/eligibility/healthy_volunteers"/>"
        },
        "oversight_info":{
            "has_dmc":"<xsl:value-of select="/clinical_study/oversight_info/has_dmc"/>",
            "is_fda_regulated_drug":"<xsl:value-of select="/clinical_study/oversight_info/is_fda_regulated_drug"/>",
            "is_fda_regulated_device":"<xsl:value-of select="/clinical_study/oversight_info/is_fda_regulated_device"/>",
            "is_unapproved_device":"<xsl:value-of select="/clinical_study/oversight_info/is_unapproved_device"/>",
            "is_ppsd":"<xsl:value-of select="/clinical_study/oversight_info/is_ppsd"/>",
            "is_us_export":"<xsl:value-of select="/clinical_study/oversight_info/is_us_export"/>"
        },
        "arm_group":{
            "arm_group_label":"<xsl:value-of select="/clinical_study/arm_group/arm_group_label"/>",
            "arm_group_type":"<xsl:value-of select="/clinical_study/arm_group/arm_group_type"/>",
            "description":"<xsl:value-of select="/clinical_study/arm_group/description"/>"
        },
        "expanded_access_info":{
            "expanded_access_type_individual":"<xsl:value-of select="/clinical_study/expanded_access_info/expanded_access_type_individual"/>",
            "expanded_access_type_intermediate":"<xsl:value-of select="/clinical_study/expanded_access_info/expanded_access_type_intermediate"/>",
            "expanded_access_type_treatment":"<xsl:value-of select="/clinical_study/expanded_access_info/expanded_access_type_treatment"/>"
        },
        "study_design_info":{
            "allocation":"<xsl:value-of select="/clinical_study/study_design_info/allocation"/>",
            "intervention_model":"<xsl:value-of select="/clinical_study/study_design_info/intervention_model"/>",
            "intervention_model_description":"<xsl:value-of select="/clinical_study/study_design_info/intervention_model_description"/>",
            "primary_purpose":"<xsl:value-of select="/clinical_study/study_design_info/primary_purpose"/>",
            "observational_model":"<xsl:value-of select="/clinical_study/study_design_info/observational_model"/>",
            "time_perspective":"<xsl:value-of select="/clinical_study/study_design_info/time_perspective"/>",
            "masking":"<xsl:value-of select="/clinical_study/study_design_info/masking"/>",
            "masking_description":"<xsl:value-of select="/clinical_study/study_design_info/masking_description"/>"
        },
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
        "why_stopped":"<xsl:value-of select="/clinical_study/why_stopped"/>",
        "target_duration":"<xsl:value-of select="/clinical_study/target_duration"/>",
        "overall_status":"<xsl:value-of select="/clinical_study/overall_status"/>",
        "last_known_status":"<xsl:value-of select="/clinical_study/last_known_status"/>",
        "phase":"<xsl:value-of select="/clinical_study/phase"/>",
        "study_type":"<xsl:value-of select="/clinical_study/study_type"/>",
        "has_expanded_access":"<xsl:value-of select="/clinical_study/has_expanded_access"/>",
        "biospec_retention":"<xsl:value-of select="/clinical_study/biospec_retention"/>",
        "number_of_arms":"<xsl:value-of select="/clinical_study/number_of_arms"/>",
        "number_of_groups":"<xsl:value-of select="/clinical_study/number_of_groups"/>",
        "verification_date":"<xsl:value-of select="/clinical_study/verification_date"/>",
        "study_first_submitted":"<xsl:value-of select="/clinical_study/study_first_submitted"/>",
        "study_first_submitted_qc":"<xsl:value-of select="/clinical_study/study_first_submitted_qc"/>",
        "results_first_submitted":"<xsl:value-of select="/clinical_study/results_first_submitted"/>",
        "results_first_submitted_qc":"<xsl:value-of select="/clinical_study/results_first_submitted_qc"/>",
        "disposition_first_submitted":"<xsl:value-of select="/clinical_study/disposition_first_submitted"/>",
        "disposition_first_submitted_qc":"<xsl:value-of select="/clinical_study/disposition_first_submitted_qc"/>",
        "last_update_submitted":"<xsl:value-of select="/clinical_study/last_update_submitted"/>",
        "last_update_submitted_qc":"<xsl:value-of select="/clinical_study/last_update_submitted_qc"/>",
        "enrollment":{
            "type":"<xsl:value-of select="/clinical_study/enrollment/@type"/>",
            "value":"<xsl:value-of select="/clinical_study/enrollment/text()"/>"
        },
        "study_first_posted":{
            "type":"<xsl:value-of select="/clinical_study/study_first_posted/@type"/>",
            "value":"<xsl:value-of select="/clinical_study/study_first_posted/text()"/>"
        },
        "results_first_posted":{
            "type":"<xsl:value-of select="/clinical_study/results_first_posted/@type"/>",
            "value":"<xsl:value-of select="/clinical_study/results_first_posted/text()"/>"
        },
        "disposition_first_posted":{
            "type":"<xsl:value-of select="/clinical_study/disposition_first_posted/@type"/>",
            "value":"<xsl:value-of select="/clinical_study/disposition_first_posted/text()"/>"
        },
        "last_update_posted":{
            "type":"<xsl:value-of select="/clinical_study/last_update_posted/@type"/>",
            "value":"<xsl:value-of select="/clinical_study/last_update_posted/text()"/>"
        },
        "completion_date":{
            "type":"<xsl:value-of select="/clinical_study/completion_date/@type"/>",
            "value":"<xsl:value-of select="/clinical_study/completion_date/text()"/>"
        },
        "start_date":{
            "type":"<xsl:value-of select="/clinical_study/start_date/@type"/>",
            "value":"<xsl:value-of select="/clinical_study/start_date/text()"/>"
        },
        "primary_completion_date":{
            "type":"<xsl:value-of select="/clinical_study/primary_completion_date/@type"/>",
            "value":"<xsl:value-of select="/clinical_study/primary_completion_date/text()"/>"
        },
        "brief_summary":{
            "textblock":"<xsl:call-template name="string-replace-all">
                            <xsl:with-param name="text">
                                <xsl:value-of select="/clinical_study/brief_summary/textblock"/>
                            </xsl:with-param>
                            <xsl:with-param name="replace" select="'&quot;'"/>
                            <xsl:with-param name="by" select="' '"/>
                        </xsl:call-template>"
        },
        "detailed_description":{
            "textblock":"<xsl:call-template name="string-replace-all">
                <xsl:with-param name="text">
                    <xsl:value-of select="/clinical_study/detailed_description/textblock"/>
                </xsl:with-param>
                <xsl:with-param name="replace" select="'&quot;'"/>
                <xsl:with-param name="by" select="' '"/>
            </xsl:call-template>"
        },
        "biospec_descr":{
            "textblock":"<xsl:call-template name="string-replace-all">
                <xsl:with-param name="text">
                    <xsl:value-of select="/clinical_study/biospec_descr/textblock"/>
                </xsl:with-param>
                <xsl:with-param name="replace" select="'&quot;'"/>
                <xsl:with-param name="by" select="' '"/>
            </xsl:call-template>"
        },
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
        ],
        "condition_browse": [
        <xsl:for-each select="/clinical_study/condition_browse/mesh_term">
            "<xsl:value-of select="."/>"<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ],
        "intervention_browse": [
        <xsl:for-each select="/clinical_study/intervention_browse/mesh_term">
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