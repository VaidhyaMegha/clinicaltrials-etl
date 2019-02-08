mvn clean package
head -n 100000 ~/temp/generatedmarker.csv | java -jar -Xmx8G target/StringSearch-1.0-SNAPSHOT.jar
