cd ~/temp
cp ~/projects/ctd/DI_ETL/analytics/split_files_by_overall_status.sh  .
./split_files_by_overall_status.sh 2cf23c2e-135a-41c0-b7e7-6b045489750c

# manual steps
- compress completed folder to completed.zip
- compress didnotcomplete folder to didnotcomplete.zip

aws s3 cp completed.zip  s3://default-query-results-519510601754-us-east-1/v3/
aws s3 cp didnotcomplete.zip  s3://default-query-results-519510601754-us-east-1/v3/

# google cloud console shell

sudo pip install awscli
aws s3 cp s3://default-query-results-519510601754-us-east-1/v3/completed.zip v3/
aws s3 cp s3://default-query-results-519510601754-us-east-1/v3/didnotcomplete.zip v3/
cp novartis.csv v3/novartis.csv
vi v3/novartis.csv # edit the contents 
cat v3/novartis.csv
        
        gs://clinicaltrialsdata-lcm/v3/completed.zip,COMPLETED
        gs://clinicaltrialsdata-lcm/v3/didnotcomplete.zip,DID_NOT_COMPLETE

gsutil cp v3/novartis.csv        gs://clinicaltrialsdata-lcm/v3/
gsutil cp v3/completed.zip         gs://clinicaltrialsdata-lcm/v3/
gsutil cp v3/didnotcomplete.zip          gs://clinicaltrialsdata-lcm/v3/


