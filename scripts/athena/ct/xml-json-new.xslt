<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>


    <xsl:template match="/">{
        "clinical_results": {
            "participant_flow": {
                "recruitment_details":"<xsl:value-of select="/clinical_study/clinical_results/participant_flow/recruitment_details"/>",
                "pre_assignment_details":"<xsl:value-of select="/clinical_study/clinical_results/participant_flow/pre_assignment_details"/>",
                "group_list": {
                    "group": [
                        <xsl:for-each select="/clinical_study/clinical_results/participant_flow/group_list/group">{
                            "title":"<xsl:value-of select="title"/>",
                            "description":"<xsl:value-of select="description"/>",
                            "group_id":"<xsl:value-of select="@group_id"/>"
                        }<xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>
                    ]
                },
                "period_list":{
                    "period": [
                        <xsl:for-each select="/clinical_study/clinical_results/participant_flow/group_list/group">{
                            "title":"<xsl:value-of select="title"/>",
                            "milestone_list":{
                                "milestone": [
                                    <xsl:for-each select="milestone_list/milestone">{
                                        "title":"<xsl:value-of select="title"/>",
                                        "participants":[
                                            <xsl:for-each select="participants">{
                                                "group_id":"<xsl:value-of select="@group_id"/>",
                                                "count":"<xsl:value-of select="@count"/>",
                                                "text_node_value":"<xsl:value-of select="text()"/>"
                                            }<xsl:if test="position() != last()">,</xsl:if>
                                            </xsl:for-each>
                                        ]
                                    }<xsl:if test="position() != last()">,</xsl:if>
                                    </xsl:for-each>
                                ]
                            },
                            "group_id":"<xsl:value-of select="@group_id"/>"
                        }<xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>
                    ]
                },
            },
            "baseline" : {
                "population":"<xsl:value-of select="/clinical_study/clinical_results/baseline/population"/>",
                "group_list": {
                    "group": [
                        <xsl:for-each select="/clinical_study/clinical_results/baseline/group_list/group">{
                            "title":"<xsl:value-of select="title"/>",
                            "description":"<xsl:value-of select="description"/>",
                            "group_id":"<xsl:value-of select="@group_id"/>"
                            }<xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>
                    ]
                },
                "analyzed_list": {
                    "analyzed": [
                        <xsl:for-each select="/clinical_study/clinical_results/baseline/analyzed_list/analyzed">{
                            "units":"<xsl:value-of select="units"/>",
                            "scope":"<xsl:value-of select="scope"/>",
                            "count_list": {
                                "count": [
                                <xsl:for-each select="count_list/count">{ 
                                    "group_id":"<xsl:value-of select="@group_id"/>",
                                    "value":"<xsl:value-of select="@value"/>",
                                    "text_node_value":"<xsl:value-of select="text()"/>"
                                    }<xsl:if test="position() != last()">,</xsl:if>
                                </xsl:for-each>
                            }
                            }<xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>
                    ]
                },
                "measure_list": {
                    "measure": [
                    <xsl:for-each select="/clinical_study/clinical_results/baseline/measure_list/measure">{
                        "title":"<xsl:value-of select="title"/>",
                        "description":"<xsl:value-of select="description"/>",
                        "population":"<xsl:value-of select="population"/>",
                        "units":"<xsl:value-of select="units"/>",
                        "param":"<xsl:value-of select="param"/>",
                        "dispersion":"<xsl:value-of select="dispersion"/>",
                        "units_analyzed":"<xsl:value-of select="units_analyzed"/>",
                        "analyzed_list": {
                            "analyzed": [
                            <xsl:for-each select="analyzed_list/analyzed">{
                                "units":"<xsl:value-of select="units"/>",
                                "scope":"<xsl:value-of select="scope"/>",
                                "count_list": {
                                    "count": [
                                    <xsl:for-each select="count_list/count">{
                                        "group_id":"<xsl:value-of select="@group_id"/>",
                                        "value":"<xsl:value-of select="@value"/>",
                                        "text_node_value":"<xsl:value-of select="text()"/>"
                                        }<xsl:if test="position() != last()">,</xsl:if>
                                    </xsl:for-each>
                                }
                                }<xsl:if test="position() != last()">,</xsl:if>
                            </xsl:for-each>
                            ]
                        },
                        "class_list": {
                            "class": [
                            <xsl:for-each select="class_list/class">{
                                "title":"<xsl:value-of select="title"/>",
                                "analyzed_list": {
                                    "analyzed": [
                                    <xsl:for-each select="analyzed_list/analyzed">{
                                        "units":"<xsl:value-of select="units"/>",
                                        "scope":"<xsl:value-of select="scope"/>",
                                        "count_list": {
                                        "count": [
                                        <xsl:for-each select="count_list/count">{
                                            "group_id":"<xsl:value-of select="@group_id"/>",
                                            "value":"<xsl:value-of select="@value"/>",
                                            "text_node_value":"<xsl:value-of select="text()"/>"
                                            }<xsl:if test="position() != last()">,</xsl:if>
                                        </xsl:for-each>
                                        }
                                        }<xsl:if test="position() != last()">,</xsl:if>
                                    </xsl:for-each>
                                    ]
                                },
                                "category_list": {
                                    "category": [
                                    <xsl:for-each select="category_list/category">{
                                        "title":"<xsl:value-of select="title"/>",
                                        "measurement_list": {
                                        "measurement": [
                                        <xsl:for-each select="measurement_list/measurement">{
                                            "group_id":"<xsl:value-of select="@group_id"/>",
                                            "value":"<xsl:value-of select="@value"/>",
                                            "spread":"<xsl:value-of select="@spread"/>",
                                            "lower_limit":"<xsl:value-of select="@lower_limit"/>",
                                            "upper_limit":"<xsl:value-of select="@upper_limit"/>",
                                            "text_node_value":"<xsl:value-of select="text()"/>"
                                            }<xsl:if test="position() != last()">,</xsl:if>
                                        </xsl:for-each>
                                        }
                                        }<xsl:if test="position() != last()">,</xsl:if>
                                    </xsl:for-each>
                                    ]
                                }
                                }<xsl:if test="position() != last()">,</xsl:if>
                            </xsl:for-each>
                            ]
                        }
                    </xsl:for-each>
                    ]
                },
            },
            "outcome_list": {
                "outcome": [
                    <xsl:for-each select="/clinical_study/clinical_results/outcome_list/outcome">{
                        "type":"<xsl:value-of select="type"/>",
                        "title":"<xsl:value-of select="title"/>",
                        "description":"<xsl:value-of select="description"/>",
                        "time_frame":"<xsl:value-of select="time_frame"/>",
                        "safety_issue":"<xsl:value-of select="safety_issue"/>",
                        "posting_date":"<xsl:value-of select="posting_date"/>",
                        "population":"<xsl:value-of select="population"/>",
                        "group_list": {
                            "group": [
                            <xsl:for-each select="group_list/group">{
                                "title":"<xsl:value-of select="title"/>",
                                "description":"<xsl:value-of select="description"/>",
                                "group_id":"<xsl:value-of select="@group_id"/>"
                                }<xsl:if test="position() != last()">,</xsl:if>
                            </xsl:for-each>
                            ]
                        },
                        "measure": {
                            "title":"<xsl:value-of select="measure/title"/>",
                            "description":"<xsl:value-of select="measure/description"/>",
                            "population":"<xsl:value-of select="measure/population"/>",
                            "units":"<xsl:value-of select="measure/units"/>",
                            "param":"<xsl:value-of select="measure/param"/>",
                            "dispersion":"<xsl:value-of select="measure/dispersion"/>",
                            "units_analyzed":"<xsl:value-of select="measure/units_analyzed"/>",
                            "analyzed_list": {
                                "analyzed": [
                                    <xsl:for-each select="measure/analyzed_list/analyzed">{
                                        "units":"<xsl:value-of select="units"/>",
                                        "scope":"<xsl:value-of select="scope"/>",
                                        "count_list": {
                                        "count": [
                                        <xsl:for-each select="measure/count_list/count">{
                                            "group_id":"<xsl:value-of select="@group_id"/>",
                                            "value":"<xsl:value-of select="@value"/>",
                                            "text_node_value":"<xsl:value-of select="text()"/>"
                                            }<xsl:if test="position() != last()">,</xsl:if>
                                        </xsl:for-each>
                                        }
                                        }<xsl:if test="position() != last()">,</xsl:if>
                                    </xsl:for-each>
                                    ]
                                },
                            "class_list": {
                                "class": [
                                <xsl:for-each select="measure/class_list/class">{
                                    "title":"<xsl:value-of select="title"/>",
                                    "analyzed_list": {
                                    "analyzed": [
                                    <xsl:for-each select="analyzed_list/analyzed">{
                                        "units":"<xsl:value-of select="units"/>",
                                        "scope":"<xsl:value-of select="scope"/>",
                                        "count_list": {
                                        "count": [
                                        <xsl:for-each select="count_list/count">{
                                            "group_id":"<xsl:value-of select="@group_id"/>",
                                            "value":"<xsl:value-of select="@value"/>",
                                            "text_node_value":"<xsl:value-of select="text()"/>"
                                            }<xsl:if test="position() != last()">,</xsl:if>
                                        </xsl:for-each>
                                        }
                                        }<xsl:if test="position() != last()">,</xsl:if>
                                    </xsl:for-each>
                                    ]
                                    },
                                    "category_list": {
                                    "category": [
                                    <xsl:for-each select="category_list/category">{
                                        "title":"<xsl:value-of select="title"/>",
                                        "measurement_list": {
                                        "measurement": [
                                        <xsl:for-each select="measurement_list/measurement">{
                                            "group_id":"<xsl:value-of select="@group_id"/>",
                                            "value":"<xsl:value-of select="@value"/>",
                                            "spread":"<xsl:value-of select="@spread"/>",
                                            "lower_limit":"<xsl:value-of select="@lower_limit"/>",
                                            "upper_limit":"<xsl:value-of select="@upper_limit"/>",
                                            "text_node_value":"<xsl:value-of select="text()"/>"
                                            }<xsl:if test="position() != last()">,</xsl:if>
                                        </xsl:for-each>
                                        }
                                        }<xsl:if test="position() != last()">,</xsl:if>
                                    </xsl:for-each>
                                    ]
                                    }
                                    }<xsl:if test="position() != last()">,</xsl:if>
                                </xsl:for-each>
                                ]
                            },
                        },
                        "analysis_list": {
                            "analysis": [
                                <xsl:for-each select="analysis_list/analysis">{
                                    "group_id_list": {
                                        "group_id": [
                                            <xsl:for-each select="group_id_list/group_id">
                                                "<xsl:value-of select="."/>"<xsl:if test="position() != last()">,</xsl:if>
                                            </xsl:for-each>
                                            ]
                                        }
                                    "groups_desc":"<xsl:value-of select="groups_desc"/>",
                                    "non_inferiority_type":"<xsl:value-of select="non_inferiority_type"/>",
                                    "non_inferiority_desc":"<xsl:value-of select="non_inferiority_desc"/>",
                                    "p_value":"<xsl:value-of select="p_value"/>",
                                    "p_value_desc":"<xsl:value-of select="p_value_desc"/>",
                                    "method":"<xsl:value-of select="method"/>",
                                    "method_desc":"<xsl:value-of select="method_desc"/>",
                                    "param_type":"<xsl:value-of select="param_type"/>",
                                    "param_value":"<xsl:value-of select="param_value"/>",
                                    "dispersion_type":"<xsl:value-of select="dispersion_type"/>",
                                    "dispersion_value":"<xsl:value-of select="dispersion_value"/>",
                                    "ci_percent":"<xsl:value-of select="ci_percent"/>",
                                    "ci_n_sides":"<xsl:value-of select="ci_n_sides"/>",
                                    "ci_lower_limit":"<xsl:value-of select="ci_lower_limit"/>",
                                    "ci_upper_limit":"<xsl:value-of select="ci_upper_limit"/>",
                                    "ci_upper_limit_na_comment":"<xsl:value-of select="ci_upper_limit_na_comment"/>",
                                    "estimate_desc":"<xsl:value-of select="estimate_desc"/>",
                                    "other_analysis_desc":"<xsl:value-of select="other_analysis_desc"/>"
                                    }<xsl:if test="position() != last()">,</xsl:if>
                                </xsl:for-each>
                            ]
                        }<xsl:if test="position() != last()">,</xsl:if>
                    </xsl:for-each>
                ]
            },
            "reported_events":{
                "time_frame":"<xsl:value-of select="/clinical_study/clinical_results/reported_events/time_frame"/>",
                "desc":"<xsl:value-of select="/clinical_study/clinical_results/reported_events/desc"/>",
                "group_list": {
                    "group": [
                    <xsl:for-each select="/clinical_study/clinical_results/reported_events/group_list/group">{
                        "title":"<xsl:value-of select="title"/>",
                        "description":"<xsl:value-of select="description"/>",
                        "group_id":"vocab"
                        }<xsl:if test="position() != last()">,</xsl:if>
                    </xsl:for-each>
                    ]
                },
                "serious_events":{
                    "frequency_threshold":"<xsl:value-of select="/clinical_study/clinical_results/reported_events/serious_events/frequency_threshold"/>",
                    "default_vocab":"<xsl:value-of select="/clinical_study/clinical_results/reported_events/serious_events/default_vocab"/>",
                    "default_assessment":"<xsl:value-of select="/clinical_study/clinical_results/reported_events/serious_events/default_assessment"/>",
                    "category_list": {
                        "category": [
                        <xsl:for-each select="/clinical_study/clinical_results/reported_events/serious_events/category_list/category">{
                            "title":"<xsl:value-of select="title"/>",
                            "event_list": {
                                "event": [
                                <xsl:for-each select="event_list/event">{
                                    "sub_title":{
                                        "vocab":"<xsl:value-of select="@vocab"/>",
                                        "text_node_value":"<xsl:value-of select="."/>"
                                    },
                                    "assessment":"<xsl:value-of select="assessment"/>",
                                    "description":"<xsl:value-of select="description"/>",
                                    "counts":[
                                    <xsl:for-each select="counts">{
                                        "group_id":"<xsl:value-of select="@group_id"/>",
                                        "subjects_affected":"<xsl:value-of select="@subjects_affected"/>",
                                        "subjects_at_risk":"<xsl:value-of select="@subjects_at_risk"/>",
                                        "events":"<xsl:value-of select="@events"/>",
                                        "text_node_value":"<xsl:value-of select="."/>"
                                    }<xsl:if test="position() != last()">,</xsl:if>
                                    </xsl:for-each>
                                    ]
                                }<xsl:if test="position() != last()">,</xsl:if>
                                </xsl:for-each>
                                ]
                            },
                            }<xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>
                        ]
                    },
                },
                "other_events":{
                    "frequency_threshold":"<xsl:value-of select="/clinical_study/clinical_results/reported_events/other_events/frequency_threshold"/>",
                    "default_vocab":"<xsl:value-of select="/clinical_study/clinical_results/reported_events/other_events/default_vocab"/>",
                    "default_assessment":"<xsl:value-of select="/clinical_study/clinical_results/reported_events/other_events/default_assessment"/>",
                    "category_list": {
                        "category": [
                        <xsl:for-each select="/clinical_study/clinical_results/reported_events/other_events/category_list/category">{
                            "title":"<xsl:value-of select="title"/>",
                            "event_list": {
                            "event": [
                            <xsl:for-each select="event_list/event">{
                                "sub_title":{
                                "vocab":"<xsl:value-of select="@vocab"/>",
                                "text_node_value":"<xsl:value-of select="."/>"
                                },
                                "assessment":"<xsl:value-of select="assessment"/>",
                                "description":"<xsl:value-of select="description"/>",
                                "counts":[
                                <xsl:for-each select="counts">{
                                    "group_id":"<xsl:value-of select="@group_id"/>",
                                    "subjects_affected":"<xsl:value-of select="@subjects_affected"/>",
                                    "subjects_at_risk":"<xsl:value-of select="@subjects_at_risk"/>",
                                    "events":"<xsl:value-of select="@events"/>",
                                    "text_node_value":"<xsl:value-of select="."/>"
                                    }<xsl:if test="position() != last()">,</xsl:if>
                                </xsl:for-each>
                                ]
                                }<xsl:if test="position() != last()">,</xsl:if>
                            </xsl:for-each>
                            ]
                            },
                            }<xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>
                        ]
                    },
                },
            },
            "certain_agreements":{
                "pi_employee":"<xsl:value-of select="/clinical_study/clinical_results/certain_agreements/pi_employee"/>",
                "restrictive_agreement":"<xsl:value-of select="/clinical_study/clinical_results/certain_agreements/restrictive_agreement"/>"
            },
            "limitations_and_caveats":"<xsl:value-of select="/clinical_study/clinical_results/limitations_and_caveats"/>",
            "point_of_contact":{
                "name_or_title":"<xsl:value-of select="/clinical_study/clinical_results/point_of_contact/name_or_title"/>",
                "organization":"<xsl:value-of select="/clinical_study/clinical_results/point_of_contact/organization"/>",
                "phone":"<xsl:value-of select="/clinical_study/clinical_results/point_of_contact/phone"/>",
                "email":"<xsl:value-of select="/clinical_study/clinical_results/point_of_contact/email"/>"
            }
        },
        "patient_data": {
            "sharing_ipd":"<xsl:value-of select="/clinical_study/patient_data/sharing_ipd"/>",
            "ipd_description":"<xsl:value-of select="/clinical_study/patient_data/ipd_description"/>"
        },
        "study_docs": {
            "study_doc": [
                <xsl:for-each select="/clinical_study/study_docs/study_doc">{
                    "doc_id":"<xsl:value-of select="doc_id"/>",
                    "doc_type":"<xsl:value-of select="doc_type"/>",
                    "doc_url":"<xsl:value-of select="doc_url"/>",
                    "doc_comment":"<xsl:value-of select="doc_comment"/>"
                    }<xsl:if test="position() != last()">,</xsl:if>
                </xsl:for-each>
            ]
        },
        "responsible_party": {
            "responsible_party_type":"<xsl:value-of select="/clinical_study/responsible_party/responsible_party_type"/>",
            "investigator_affiliation":"<xsl:value-of select="/clinical_study/responsible_party/investigator_affiliation"/>",
            "investigator_full_name":"<xsl:value-of select="/clinical_study/responsible_party/investigator_full_name"/>",
            "invewastigator_title":"<xsl:value-of select="/clinical_study/responsible_party/investigator_title"/>"
        },
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
            "phone_ext":"<xsl:value-of select="/clinical_study/overall_contact/phone_ext"/>",
            "email":"<xsl:value-of select="/clinical_study/overall_contact/email"/>"
        },
        "overall_contact_backup": {
            "first_name":"<xsl:value-of select="/clinical_study/overall_contact_backup/first_name"/>",
            "middle_name":"<xsl:value-of select="/clinical_study/overall_contact_backup/middle_name"/>",
            "last_name":"<xsl:value-of select="/clinical_study/overall_contact_backup/last_name"/>",
            "degrees":"<xsl:value-of select="/clinical_study/overall_contact_backup/degrees"/>",
            "phone":"<xsl:value-of select="/clinical_study/overall_contact_backup/phone"/>",
            "phone_ext":"<xsl:value-of select="/clinical_study/overall_contact_backup/phone_ext"/>",
            "email":"<xsl:value-of select="/clinical_study/overall_contact_backup/email"/>"
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
            "text_node_value":"<xsl:value-of select="/clinical_study/enrollment/text()"/>"
        },
        "study_first_posted":{
            "type":"<xsl:value-of select="/clinical_study/study_first_posted/@type"/>",
            "text_node_value":"<xsl:value-of select="/clinical_study/study_first_posted/text()"/>"
        },
        "results_first_posted":{
            "type":"<xsl:value-of select="/clinical_study/results_first_posted/@type"/>",
            "text_node_value":"<xsl:value-of select="/clinical_study/results_first_posted/text()"/>"
        },
        "disposition_first_posted":{
            "type":"<xsl:value-of select="/clinical_study/disposition_first_posted/@type"/>",
            "text_node_value":"<xsl:value-of select="/clinical_study/disposition_first_posted/text()"/>"
        },
        "last_update_posted":{
            "type":"<xsl:value-of select="/clinical_study/last_update_posted/@type"/>",
            "text_node_value":"<xsl:value-of select="/clinical_study/last_update_posted/text()"/>"
        },
        "completion_date":{
            "type":"<xsl:value-of select="/clinical_study/completion_date/@type"/>",
            "text_node_value":"<xsl:value-of select="/clinical_study/completion_date/text()"/>"
        },
        "start_date":{
            "type":"<xsl:value-of select="/clinical_study/start_date/@type"/>",
            "text_node_value":"<xsl:value-of select="/clinical_study/start_date/text()"/>"
        },
        "primary_completion_date":{
            "type":"<xsl:value-of select="/clinical_study/primary_completion_date/@type"/>",
            "text_node_value":"<xsl:value-of select="/clinical_study/primary_completion_date/text()"/>"
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