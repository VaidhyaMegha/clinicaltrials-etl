package com.vaidhyamegha;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class App {
    private static BufferedOutputStream bos = new BufferedOutputStream(System.out);

    public static void main(String[] args) throws Exception {
        if (args.length > 1 && "replaceDelimiter".equals(args[1])) {
            bos = new BufferedOutputStream(new FileOutputStream(args[2]));
            replaceDelimiter(args[0]);
        } else {
            replaceInnerComma(args[0]);
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

                if (!quoteStarted && current == ',') current = '|';

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
        File file = new File(fileName);

        if (!file.exists()) {
            throw new IOException(file.getName() + " does not exist.");
        }
        if (!(file.isFile() && file.canRead())) {
            throw new IOException(file.getName() + " cannot be read from.");
        }

        FileInputStream fis = new FileInputStream(file);
        return new BufferedInputStream(fis);
    }
}