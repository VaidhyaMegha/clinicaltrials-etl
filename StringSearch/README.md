mvn clean package
head -n 100000 ~/temp/generatedmarker.csv | java -jar -Xmx8G target/StringSearch-1.0-SNAPSHOT.jar ~/temp/generatedgenome.csv 250

root@tingri:~/datasets#

grep "^@" -A 1 SRR8278846_1.fastq | grep -v "^@" | grep -v "^#" | grep -v "-" | head -n 100 | java -jar -Xmx8G StringSearch-1.0-SNAPSHOT.jar hg38.fa 102  | less

NTATTCTAAATCTGTCACTTGAAATAGCATACTCATGATTAAAAGCAAATTACCTTTTACACCACCAAATGATCCATAGGTCATATTGCAGGCTGTTCTCT
GGACCCCTGAGCTAGCCATGCTCTGACAGTCTCAGTTGCACACACGAGCCAGCAGAGGGGTTTTGTGCCACTTCTGGATGCTAGGGTTACACTGGGAGAC
