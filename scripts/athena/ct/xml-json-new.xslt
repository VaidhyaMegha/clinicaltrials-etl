<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>

    <xsl:template match="/">{
        "keyword": [
        <xsl:for-each select="/clinical_study/keyword">
            "<xsl:call-template name="string-replace-all">
                <xsl:with-param name="text">
                    <xsl:value-of select="."/>
                </xsl:with-param>
                <xsl:with-param name="replace" select="'&quot;'"/>
                <xsl:with-param name="by" select="' '"/>
            </xsl:call-template>",
        </xsl:for-each>
        ],
        "condition": [
        <xsl:for-each select="/clinical_study/condition">
            "<xsl:call-template name="string-replace-all">
                <xsl:with-param name="text">
                    <xsl:value-of select="."/>
                </xsl:with-param>
                <xsl:with-param name="replace" select="'&quot;'"/>
                <xsl:with-param name="by" select="' '"/>
            </xsl:call-template>",
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
            </xsl:call-template>"},
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
            </xsl:call-template>"},
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
            </xsl:call-template>"},
        </xsl:for-each>
        ],
        "reference": [
        <xsl:for-each select="/clinical_study/reference">
            {
            "citation":"<xsl:value-of select="citation"/>",
            "PMID":"<xsl:value-of select="PMID"/>"
            },
        </xsl:for-each>
        ],
        "results_reference": [
        <xsl:for-each select="/clinical_study/results_reference">
            {
            "citation":"<xsl:value-of select="citation"/>",
            "PMID":"<xsl:value-of select="PMID"/>"
            },
        </xsl:for-each>
        ],
        "link": [
        <xsl:for-each select="/clinical_study/link">
            {
            "url":"<xsl:value-of select="url"/>",
            "description":"<xsl:value-of select="description"/>"
            },
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
                            "affiliation":"<xsl:value-of select="investigator/affiliation"/>"}, 
                 </xsl:for-each>]
            },
        </xsl:for-each>
        ],

        <xsl:apply-templates select="*"/>
        }
    </xsl:template>


    <xsl:template match="/clinical_study/required_header">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/id_info">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/brief_title">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/acronym">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/official_title">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/sponsors">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/source">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/oversight_info">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/brief_summary">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/detailed_description">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/overall_status">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/last_known_status">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/why_stopped">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/start_date">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/completion_date">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/primary_completion_date">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/phase">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/study_type">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/has_expanded_access">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/expanded_access_info">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/study_design_info">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/target_duration">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/number_of_arms">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/number_of_groups">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/enrollment">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/arm_group">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/intervention">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/biospec_retention">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/biospec_descr">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/eligibility">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/overall_official">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/overall_contact">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/overall_contact_backup">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/location_countries">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/removed_countries">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/verification_date">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <!-- === Old Dates will be dropped in a few months (sometime in 2018) ========= -->
    <xsl:template match="/clinical_study/lastchanged_date">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/firstreceived_date">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/firstreceived_results_date">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/firstreceived_results_disposition_date">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <!-- === New Dates ============================================================ -->
    <xsl:template match="/clinical_study/study_first_submitted">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/study_first_submitted_qc">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/study_first_posted">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/results_first_submitted">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/results_first_submitted_qc">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/results_first_posted">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/disposition_first_submitted">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/disposition_first_submitted_qc">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/disposition_first_posted">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/last_update_submitted">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/last_update_submitted_qc">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/last_update_posted">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <!-- === End of Dates ========================================================= -->
    <xsl:template match="/clinical_study/responsible_party">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/condition_browse">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/intervention_browse">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/patient_data">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/study_docs">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
    </xsl:template>
    <xsl:template match="/clinical_study/clinical_results">"<xsl:value-of select="name()"/>" :
        "
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:value-of select="."/>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'&quot;'"/>
            <xsl:with-param name="by" select="' '"/>
        </xsl:call-template>
        ",
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