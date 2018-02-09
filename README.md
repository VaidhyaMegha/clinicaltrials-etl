Focus
-----
- DATA ---> Health ---> Open Health Data ---> India
    - HMIS (in-progress)
        -  PUBLISHEDREPORTS - PERFORMANCE OF KEY HMIS INDICATORS(UPTO DISTRICT LEVEL)
    - data.gov.in (in-progress)
        - APIs
    - https://github.com/opentrials/registers
        - clinicaltrials.gov
        - http://ctri.nic.in/Clinicaltrials/advancesearchmain.php - https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3667290/
        - https://github.com/CrossRef/clinical-trials-importer/blob/develop/resources/clinical-trial-registries.edn
    - Mesh
    - opentrials.net
    - https://www.healthdata.gov/search/type/dataset
    
    Autocomplete and autoselection for defaults and list sizes ex: 10 for trials and 5 for papers based on citation						

Artifacts
--------
- Searcable Navigable data --> SPA 
- CTRI scraper and postgres db dump along with a postgres RDS snapshot containing both clinicaltrials.gov, ctri and possibly other trial registries
- Interesting insights --> Articles (Freakonomics) ex:     
    - Skew in Tubectomy vs Vasectomy and its social inferences
    - Crime statistics vs population esp. choice in birth, abortion
- Focused actions --> APP ex: 
    - based on blood bank data build a geo-location aware app to find closest/best-match blood bank.
    
            Platform for real time monitoring of blood bank capacity (falls into a category EHR, HMS)
            B+,1200L
            A+,2000L
            AB-,10L
- Analytical reports --> Papers (ex: https://timesofindia.indiatimes.com/india/fertility-rate-below-replacement-level-for-all-but-hindus-muslims/articleshow/62465588.cms)
    - Conditions and metrics related to each ex: Anaemia
    
            Year, District, Anemia metrics1, Anemia metrics2,
            % Pregnant women having severe anaemia (Hb<7) treated at institution to women having hb level<11
    - Services and their reach (keywords are registration, received) 
        ex: JSY,  number of Pregnant women received TT2 or Booster
    - Data outliers (anomalies) ex: Aizwal 2009-10 no data for most of the metrics

Ideas
-----
- aact inspired project for data.gov.in to use RSS Feeds from data.gov.in and use it to generate jsons (and postgreSQL database?)
- aact inspired project for ctri.nic.in and use it to generate jsons (and postgreSQL database?)
- OCR and CV based mobile app on BYOD for tabulating blood bank repositories 
    - Incentive for hospitals - free, easy access through apps, analytics
- Ontology for data.gov.in

Key Terms
---------
RDF, SPARQL,JSON-LD,Linked Data, Semantic web

Reference Projects, Tools and Articles
--------------------------------------
- https://github.com/HHS/meshrdf
- https://github.com/EBISPOT/lodestar
- https://github.com/openlink/virtuoso-opensource
- https://github.com/Keyang/node-csvtojson
- http://aact.ctti-clinicaltrials.org/pipe_files_with_r
- https://www.coursera.org/learn/clinical-research
- http://tabula.technology/
- https://docs.aws.amazon.com/athena/latest/ug/code-samples.html
- https://docs.aws.amazon.com/athena/latest/ug/getting-started.html
- https://aws.amazon.com/about-aws/whats-new/2017/05/amazon-athena-adds-api-cli-aws-sdk-support-and-audit-logging-with-aws-cloudtrail/
- https://aws.amazon.com/blogs/big-data/10-best-practices-for-amazon-redshift-spectrum/
- https://wiki.openoffice.org/wiki/Documentation/DevGuide/Spreadsheets/Filter_Options#Filter_Options_for_the_CSV_Filter