package com.vaidhyamegha;

import java.io.*;

public class App {
    private static final int THRESHOLD = 10;
    private static int ml;

    public static void main(String[] args) {
        String faFileName = args[0];
        ml = Integer.parseInt(args[1]);
        String outputFileName = args[2];

        Trie st = buildTrie();

        try (BufferedInputStream r = new BufferedInputStream(new FileInputStream(new File(faFileName)))) {
            BufferedWriter bw = new BufferedWriter(new FileWriter(new File(outputFileName)));

            readStream(st, ml, bw, r);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void readStream(Trie st, int ml, BufferedWriter bw, BufferedInputStream r) throws IOException {
        int rc ; long l = -1;
        StringBuilder sb = new StringBuilder();

        while ((rc = r.read()) !=  -1){
            l++;
            char c = Character.toUpperCase((char) rc);
            if(c == '\r' || c == '\n') continue;
            else if(c != 'A' && c != 'T' && c != 'C' && c != 'G') {
                if (sb.length() > 0) sb.delete(0, sb.length());
                continue;
            }

            sb.append(c);

            if(sb.length() < ml) continue;

            String full = sb.toString();
            String partial = sb.substring(0, ((ml - THRESHOLD)/4)*4 );

            for (String s : st.keysWithPrefix(partial)) bw.write(l + "\t" + full + "\t" + s + "\n");

            sb.deleteCharAt(0);
        }

        bw.flush();
    }

    private static Trie buildTrie() {
        // build symbol table from standard input
        Trie st = new Trie(ml);
        for (int i = 0; !StdIn.isEmpty(); i++) {
            String key = StdIn.readString();
            if(!key.toUpperCase().matches("[ATCG]*")) continue;
            st.put(key.toUpperCase());
        }

        // print results
        if (st.size() < 100) {
            System.out.println("keys(\"\"):");
            st.keys().forEach(System.out::println);
        }
        return st;
    }
}
