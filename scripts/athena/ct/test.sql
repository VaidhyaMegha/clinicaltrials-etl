CREATE EXTERNAL TABLE `ct_studies_new` (
  `required_header` struct<
    `download_date`:string,
    `link_text`:string,
    `url`:string
  >,
  `id_info` struct<
    `org_study_id`:string,
    `secondary_id`:string,
    `nct_id`:string
  >,
  `brief_title` string,
  `official_title` string,
  `sponsors` struct<
    `lead_sponsor`:struct<
      `agency`:string,
      `agency_class`:string
    >,
    `collaborator`:struct<
      `agency`:string,
      `agency_class`:string
    >
  >,
  `source` string,
  `oversight_info` struct<
    `has_dmc`:string
  >,
  `brief_summary` struct<
    `textblock`:string
  >,
  `overall_status` string,
  `why_stopped` string,
  `start_date` string,
  `completion_date` struct<
    `type`:string,
    `text`:string
  >,
  `primary_completion_date` struct<
    `type`:string,
    `text`:string
  >,
  `phase` string,
  `study_type` string,
  `has_expanded_access` string,
  `study_design_info` struct<
    `allocation`:string,
    `intervention_model`:string,
    `primary_purpose`:string,
    `masking`:string
  >,
  `primary_outcome` struct<
    `measure`:string,
    `time_frame`:string,
    `description`:string
  >,
  `secondary_outcome` struct<
    `measure`:string,
    `time_frame`:string
  >,
  `number_of_arms` string,
  `enrollment` struct<
    `type`:string,
    `text`:string
  >,
  `condition` string,
  `arm_group` array<struct<
      `arm_group_label`:string,
      `arm_group_type`:string,
      `description`:string
    >>,
  `intervention` array<struct<
      `intervention_type`:string,
      `intervention_name`:string,
      `arm_group_label`:array<string>
    >>,
  `eligibility` struct<
    `criteria`:struct<
      `textblock`:string
    >,
    `gender`:string,
    `minimum_age`:string,
    `maximum_age`:string,
    `healthy_volunteers`:string
  >,
  `location` struct<
    `facility`:struct<
      `name`:string,
      `address`:struct<
        `city`:string,
        `state`:string,
        `zip`:string,
        `country`:string
      >
    >
  >,
  `location_countries` struct<
    `country`:string
  >,
  `verification_date` struct<
    `tail`:string,
    `text`:string
  >,
  `study_first_submitted` string,
  `study_first_submitted_qc` string,
  `study_first_posted` struct<
    `type`:string,
    `text`:string
  >,
  `last_update_submitted` string,
  `last_update_submitted_qc` string,
  `last_update_posted` struct<
    `type`:string,
    `text`:string
  >,
  `responsible_party` struct<
    `responsible_party_type`:string,
    `investigator_affiliation`:string,
    `investigator_full_name`:string,
    `investigator_title`:string
  >,
  `condition_browse` struct<
    `mesh_term`:array<string>
  >,
  `intervention_browse` struct<
    `mesh_term`:array<string>
  >
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://datainsights-results/temp/AllPublicXMLs/NCT0338xxxx/';


