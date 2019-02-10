mvn clean package
head -n 100000 ~/temp/generatedmarker.csv | java -jar -Xmx8G target/StringSearch-1.0-SNAPSHOT.jar ~/temp/generatedgenome.csv 250

root@tingri:~/datasets#


grep -oE "[A|T|C|G|a|t|c|g]+" hg38.fa  > hg38.fa.cleaned
cat hg38.fa.cleaned | tr -d '\n'  > hg38.fa.cleaned.2

grep "^@" -A 1 SRR8278846_1.fastq | grep -v "^@" | grep -v "^#" | grep -v "-" | head -n 100 | java -jar -Xmx8G StringSearch-1.0-SNAPSHOT.jar hg38.fa 101  | less


# works
head -n 10000 hg38.fa.cleaned > hg38.fa.cleaned.3.head10000
grep "^@" -A 1 SRR8278846_1.fastq | grep -v "^@" | grep -v "^#" | grep -v "-" | head -n 100000 | java -jar -Xmx4G StringSearch-1.0-SNAPSHOT.jar hg38.fa.cleaned.3.head10000 101  | less





keys With Prefix(CTGATGCATGGGAAACATAATTTGATCATTTTTAAGTTACAGTCCAAATCTTTTTGTACCTGAATAACATGTTGCCCAGTCAGTCTCTCTT):
CTGATGCATGGGAAACATAATTTGATCATTTTTAAGTTACAGTCCAAATCTTTTTGTACCTGAATAACATGTTGCCCAGTCAGTCTCTCTTCCTGGATTCA
