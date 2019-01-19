package com.vaidhyamegha;

import java.io.*;

/**
 * Hello world!
 *
 */
public class App {

    public static void main( String[] args ) throws IOException {
        if (args.length > 1) {
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(args[2])));

            if ("discoverLinks".equals(args[0])) {
                WQUPC uf = new WQUPC(Integer.parseInt(args[1]), bw);

                uf.process(uf);
            }
        } else {
            System.out.println("not enough arguments");
        }
    }
}
