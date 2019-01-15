package com.vaidhyamegha;

import java.io.*;
import java.util.HashMap;
import java.util.Map;
import java.util.StringJoiner;

public class App {
    private static BufferedWriter bos = new BufferedWriter(new OutputStreamWriter(System.out));

    public static void main(String[] args) throws Exception {
        if (args.length > 1) {
            bos = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(args[2])));

            if ("replaceDelimiter".equals(args[1])) {
                replaceDelimiter(args[0]);
            } else if ("replaceInnerComma".equals(args[1])) {
                replaceInnerComma(args[0]);
            } else if ("encodeAndGenerateSummary".equals(args[1])) {
                encodeAndGenerateSummary(args[0]);
            }
        } else {
            System.out.println("not enough arguments");
        }
    }

    private static void encodeAndGenerateSummary(String fileName) {
        try {
            BufferedReader br = new BufferedReader(new FileReader(doesFileExist(fileName)));
            Map<String, Map<String, Integer>> dictionary = new HashMap<>();

            int i = 0;
            String line =  br.readLine();
            String[] headers = line.split("\\t");

            for(String s: headers) dictionary.put(s, new HashMap<>());

            while ((line = br.readLine()) != null) {
                i = 0;
                for (String s : line.split("\\t")) {
                    String field = headers[i];
                    i++;
                    Map<String, Integer> distinctValues = dictionary.get(field);
                    Integer count = distinctValues.get(s);
                    distinctValues.put(s, (( count != null) ? (count + 1) : 1));
                }
            }

            br = new BufferedReader(new FileReader(doesFileExist(fileName)));
            String headerLine = br.readLine();
            StringJoiner headerLineJoined = new StringJoiner(",", "", "");

            for(String s: headerLine.split("\\t")) headerLineJoined.add(s);

            bos.write(headerLineJoined.toString());
            bos.newLine();

            while ((line = br.readLine()) != null) {
                StringJoiner newLine = new StringJoiner(",", "", "");
                i = 0;
                for (String s: line.split("\\t")){
                    String field = headers[i++];

                    if (dictionary.get(field).keySet().size() > 50 ){
                        newLine.add(s);
                    } else {
                        newLine.add(field.hashCode() + "");
                    }
                }
                bos.write((newLine.toString()));
                bos.newLine();
            }
            bos.flush();

            //System.out.println("Summary");
            //System.out.println(dictionary.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void replaceDelimiter(String fileName) {
        try {
            BufferedInputStream bis = readIfFileExists(fileName);
            char current;
            boolean quoteStarted = false;
            while (bis.available() > 0) {
                current = (char) bis.read();
                if (current == '"') quoteStarted = !quoteStarted;

                if (!quoteStarted && current == ',') current = '\t';

                bos.write(current);
            }
            bos.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void replaceInnerComma(String fileName) {
        try {
            BufferedInputStream bis = readIfFileExists(fileName);
            char current;
            boolean quoteStarted = false;
            while (bis.available() > 0) {
                current = (char) bis.read();
                if (current == '"') quoteStarted = !quoteStarted;

                if (quoteStarted && current == '\n') current = ';';

                bos.write(current);
            }
            bos.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static BufferedInputStream readIfFileExists(String fileName) throws IOException {
        File file = doesFileExist(fileName);

        FileInputStream fis = new FileInputStream(file);
        return new BufferedInputStream(fis);
    }

    private static File doesFileExist (String fileName) throws IOException{
        File file = new File(fileName);

        if (!file.exists()) {
            throw new IOException(file.getName() + " does not exist.");
        }
        if (!(file.isFile() && file.canRead())) {
            throw new IOException(file.getName() + " cannot be read from.");
        }

        return file;
    }
}