# Datasets
- FDA
- ICIJ IMDDB

# Commands
        
        athena --db hsdlc --execute " select * from vm_devices.v_icij_devices" --output-format TSV --region 'us-east-1' > v_icij_devices.tsv    