mvn clean package
head -n 100000 ~/temp/generatedmarker.csv | java -jar -Xmx8G target/StringSearch-1.0-SNAPSHOT.jar ~/temp/generatedgenome.csv 250

root@tingri:~/datasets#
grep -oE "[A|T|C|G|a|t|c|g]+" hg38.fa  > hg38.fa.cleaned
grep "^@" -A 1 SRR8278846_1.fastq | grep -v "^@" | grep -v "^#" | grep -v "-" | head -n 100000 | java -jar -Xmx4G StringSearch-1.0-SNAPSHOT.jar hg38.fa.cleaned 101  > result100000.txt &

# took 19 min.
 17M -rw-r--r--  1 root root  17M Feb 10 01:06 result100000.txt


keys With Prefix(CTGATGCATGGGAAACATAATTTGATCATTTTTAAGTTACAGTCCAAATCTTTTTGTACCTGAATAACATGTTGCCCAGTCAGTCTCTCTT):
CTGATGCATGGGAAACATAATTTGATCATTTTTAAGTTACAGTCCAAATCTTTTTGTACCTGAATAACATGTTGCCCAGTCAGTCTCTCTTCCTGGATTCA
