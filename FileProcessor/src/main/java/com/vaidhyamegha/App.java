package com.vaidhyamegha;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

public class App {
    public static void main(String[] args) {
        File file = new File(args[0]);
        if (!file.exists()) {
            System.out.println(args[0] + " does not exist.");
            return;
        }
        if (!(file.isFile() && file.canRead())) {
            System.out.println(file.getName() + " cannot be read from.");
            return;
        }
        try {
            FileInputStream fis = new FileInputStream(file);
            BufferedInputStream bis = new BufferedInputStream(fis);
            char current;
            boolean quoteStarted = false;
            while (bis.available() > 0) {
                current = (char) bis.read();
                if(current == '"') quoteStarted = !quoteStarted;

                if(quoteStarted && current == '\n') current = ';';

                System.out.print(current);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}