#!/usr/bin/env node

let readline = require('readline');
let rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let study = [];


rl.on('line', function(line){
    study.push(line);
});

rl.on('close', function () {
    let finalRecord = {};
    let sites = [];
    let primaryOutcomes = [];
    let secondaryOutcomes = [];
    let contactPerson = [];
    let sourceMonetary = [];
    let Sponsor = [];
    let Arm = [];
    let temp = null;
    let curObject = null;
    let curKey = null;

    for (let i = 0; i < study.length ; i++) {
if(study[i].indexOf('"CRIS Registration Number"') !== -1) {
                        curKey = "cris_registration_number";
                curKey = "cris_registration_number";
        }   else if(study[i].indexOf('"Unique Protocol ID"') !== -1) {
                                curKey = "unique_protocol id";
        }   else if(study[i].indexOf('"Public/Brief Title"') !== -1) {
                                curKey = "public_or_brief_title";
        }   else if(study[i].indexOf('"Scientific Title"') !== -1) {
                                curKey = "scientific_title";
        }   else if(study[i].indexOf('"Acronym"') !== -1) {
                                curKey = "acronym";
        }   else if(study[i].indexOf('"MFDS Regulated Study"') !== -1) {
                                curKey = "mfds_regulated_study";
        }   else if(study[i].indexOf('"IND/IDE Protocol"') !== -1) {
                                curKey = "ind_ide_protocol";
        }   else if(study[i].indexOf('"Registered at Other Registry"') !== -1) {
                                curKey = "registered_at_other_registry";
        }   else if(study[i].indexOf('"Healthcare Benefit Approval"') !== -1) {
                                curKey = "healthcare_benefit_approval_status";
}   else if(study[i].indexOf('"Board Approval Status"') !== -1) {
                                curKey = "board_approval_status";

        }   else if(study[i].indexOf('"Board Approval Number"') !== -1) {
                                curKey = "board_approval_number";

        }   else if(study[i].indexOf('"Approval Date"') !== -1) {
                                curKey = "approval_date";
        }   else if(study[i].indexOf('"Data Monitoring Committee"') !== -1) {
                                curKey = "data_monitoring_committee";
} else if(study[i].indexOf("Contact Person for ") !== -1) {
                            curObject = "Contact Person";
                            if(temp != null) contactPerson.push(temp);
                            temp = {};
                            curKey = null;
} else if (curObject === "Contact Person" && study[i].indexOf("- Name") !== -1) {
                  curKey = "name";

            } else if (curObject === "Contact Person" && study[i].indexOf("- Title") !== -1){
                  curKey = "title";

            } else if (curObject === "Contact Person" && study[i].indexOf("- Telephone") !== -1){
                   curKey = "telephone";

            } else if (curObject === "Contact Person" && study[i].indexOf("- Affiliation") !== -1){
                   curKey = "affiliation";

            } else if (curObject === "Contact Person" && study[i].indexOf("- Address") !== -1){
                    curKey = "address";

            } else if (curObject === "Contact Person" && curKey !== null && study[i].indexOf("text") !== -1){
                    temp[curKey] = cleanLine(study[i]);
                    curKey = null; // reset the curKey
} else if(study[i].indexOf('"Study Site"') !== -1) {
            curKey = "study_site";
        } else if(study[i].indexOf('"Overall Recruitment Status"') !== -1) {
            curKey = "overall_recruitment_status";
        } else if(study[i].indexOf('"Date of First Enrollment"') !== -1) {
            curKey = "date_of_first_enrollment";
        } else if(study[i].indexOf('"Target Number of Participant"') !== -1) {
            curKey = "target_number_of_participant";
        } else if(study[i].indexOf('"Primary Completion Date"') !== -1) {
            curKey = "primary_completion_date";
        } else if(study[i].indexOf('"Study Completion Date"') !== -1) {
            curKey = "study_completion_date";
} else if(study[i].indexOf("Recruitment Status by Participating Study Site") !== -1) {
            curObject = "Site";
            if(temp != null) sites.push(temp);
            temp = {};
            curKey = null;
} else if (curObject === "Site" && study[i].indexOf("Name of Study Site") !== -1){
            curKey = "name_of_study_site";

            } else if (curObject === "Site" && study[i].indexOf("Recruitment Status") !== -1){
                 curKey = "recruitment_status";

            } else if (curObject === "Site" && study[i].indexOf("Date of First Enrollment") !== -1){
                 curKey = "date_of_first_enrollment";

            } else if (curObject === "Site" && curKey !== null && study[i].indexOf("text") !== -1){
                 temp[curKey] = cleanLine(study[i]);
            curKey = null; // reset the curKey
 } else if(study[i].indexOf("Source of Monetary/Material Support") !== -1) {
                            curObject = "source_of_monetary_or_material_support";
                            if(temp != null) sourceMonetary.push(temp);
                            temp = {};
                            curKey = null;
 } else if (curObject === "source_of_monetary_or_material_support" && study[i].indexOf("- Organization Name") !== -1){
                                curKey = "organization_name";

                         } else if (curObject === "source_of_monetary_or_material_support" && study[i].indexOf("- Organization Type") !== -1){
                                curKey = "organization_type";

                         } else if (curObject === "source_of_monetary_or_material_support" && study[i].indexOf("- Project ID") !== -1){
                                 curKey = "project_id";

                         } else if (curObject === "source_of_monetary_or_material_support" && curKey !== null && study[i].indexOf("text") !== -1){
                                 temp[curKey] = cleanLine(study[i]);
                                 curKey = null; // reset the curKey
} else if(study[i].indexOf("Sponsor Organization") !== -1) {
                    curObject = "Sponsor";
                    if(temp != null) Sponsor.push(temp);
                    temp = {};
                    curKey = null;
 } else if (curObject === "Sponsor" && study[i].indexOf("- Organization Name") !== -1){
                                             curKey = "sponsor_organization_name";

                              } else if (curObject === "Sponsor" && study[i].indexOf("- Organization Type") !== -1){
                                             curKey = "sponsor_organization_type";

                                      } else if (curObject === "Sponsor" && curKey !== null && study[i].indexOf("text") !== -1){
                                              temp[curKey] = cleanLine(study[i]);
                                              curKey = null; // reset the curKey
 }   else if(study[i].indexOf('"Lay Summary"') !== -1) {
                                curKey = "lay_summary";

        }   else if(study[i].indexOf('"Study Type"') !== -1) {
                                curKey = "study_type";

        }   else if(study[i].indexOf('"Study Purpose"') !== -1) {
                                curKey = "study_purpose";

        }   else if(study[i].indexOf('"Phase"') !== -1) {
                                curKey = "phase";

        }   else if(study[i].indexOf('"intervention_model"') !== -1) {
                                curKey = "mfds_regulated_study";

        }   else if(study[i].indexOf('"Blinding/Masking"') !== -1) {
                                curKey = "blinding_or_masking";

        }   else if(study[i].indexOf('"Allocation"') !== -1) {
                                curKey = "allocation";

        }   else if(study[i].indexOf('"Intervention Type"') !== -1) {
                                curKey = "intervention_type";

        }   else if(study[i].indexOf('"Intervention Description"') !== -1) {
                                curKey = "intervention_description";

        }   else if(study[i].indexOf('"Number of Arms"') !== -1) {
                                curKey = "number_of_arms";
} else if (study[i].indexOf("Arm Label") !== -1){
                       curKey = "arm_label";

                } else if (study[i].indexOf("Target Number of Participant") !== -1){
                       curKey = "target_number_of_participant";
         } else if (study[i].indexOf("Arm Type") !== -1){
                       curKey = "arm_type";

                } else if (study[i].indexOf("Arm Description") !== -1){
                       curKey = "arm_description";
  }   else if(study[i].indexOf('"Condition(s)/Problem(s)"') !== -1) {
                                curKey = "conditions_problems";

        }   else if(study[i].indexOf('"Rare Disease"') !== -1) {
                                curKey = "rare_disease";
}   else if(study[i].indexOf('"Gender"') !== -1) {
                                curKey = "gender";

        }   else if(study[i].indexOf('"Age"') !== -1) {
                                curKey = "age";

        }   else if(study[i].indexOf('"Description"') !== -1) {
                                curKey = "description";
}   else if(study[i].indexOf('"Exclusion Criteria"') !== -1) {
                                curKey = "exclusion_criteria";

        }   else if(study[i].indexOf('"Healthy Volunteers"') !== -1) {
                                curKey = "healthy_volunteers";

        }   else if(study[i].indexOf('"Type of Primary Outcome"') !== -1) {
                                curKey = "type_of_primary_outcome";
} else if(study[i].indexOf("Primary Outcome(s)") !== -1) {
            curObject = "Primary Outcome";
            if(temp != null) primaryOutcomes.push(temp);
            temp = {};
            curKey = null;
 } else if (curObject === "Primary Outcome" && study[i].indexOf("- Outcome") !== -1){
                     curKey = "outcome";

            } else if (curObject === "Primary Outcome" && study[i].indexOf("- Timepoint") !== -1){
                     curKey = "timepoint";

            }  else if (curObject === "Primary Outcome" && curKey !== null && study[i].indexOf("text") !== -1){
                      temp[curKey] = cleanLine(study[i]);
                      curKey = null; // reset the curKey
 } else if(study[i].indexOf("Secondary Outcome(s) ") !== -1) {
                    curObject = "Secondary Outcome";
                    if(temp != null) secondaryOutcomes.push(temp);
                    temp = {};
                    curKey = null;
 } else if (curObject === "Secondary Outcome" && study[i].indexOf("- Outcome") !== -1){
                       curKey = "outcome";

                } else if (curObject === "Secondary Outcome" && study[i].indexOf("- Timepoint") !== -1){
                       curKey = "timepoint";

                } else if (curObject === "Secondary Outcome" && curKey !== null && study[i].indexOf("text") !== -1){
                        temp[curKey] = cleanLine(study[i]);
                        curKey = null; // reset the curKey
 }   else if(study[i].indexOf('"Result Registerd"') !== -1) {
                                curKey = "result_registerd";

        }   else if(study[i].indexOf('"Sharing Statement"') !== -1) {
                                curKey = "sharing_statement";
  } else { // catchall
                    if ( curKey !== null && study[i].indexOf("text") !== -1){
                    finalRecord[curKey] = cleanLine(study[i]);
                     curKey = null;
            }
        }

    }


    finalRecord['sites'] = sites;
    finalRecord['subject Eligibility and study design'] = primaryOutcomes;
    finalRecord['primary_outcomes'] = secondaryOutcomes;
    finalRecord['Contact Person'] = contactPerson;
    finalRecord['site'] = sourceMonetary;
    finalRecord['source_of_monetary_or_material_support'] = Sponsor;
        process.stdout.write(JSON.stringify(finalRecord) + '\n');
});

function cleanLine(l){
    let line = l;
    line = line.replace(/"/g, '');
    line = line.replace(/text: /g, '');

    return line;
}