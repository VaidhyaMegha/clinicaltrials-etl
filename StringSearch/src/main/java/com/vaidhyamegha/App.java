package com.vaidhyamegha;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.*;

public class App {
    private static final int THRESHOLD = 10;

    private static class Match {
        long location;
        String match;

        Match(long l, String m){
            this.location = l;
            this.match = m;
        }

        public String toString(){
            return "Match at location " + location + " for string " + match;
        }
    }

    public static void main(String[] args) {
        Trie st = buildTrie();

        int ml = Integer.parseInt(args[1]);

        Map<String, List<Match>> map = new HashMap<>();

        try (BufferedInputStream r = new BufferedInputStream(new FileInputStream(new File(args[0])))) {
            readStream(st, ml, map, r);

            map.forEach((k,v) -> {
                StdOut.println("-----------------------");
                StdOut.println("Partial matches > threshold for (" + k + "):");

                v.forEach(m -> StdOut.println(m.toString()));
            });

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void readStream(Trie st, int ml, Map<String, List<Match>> map, BufferedInputStream r) throws IOException {
        int rc = -1; long l = -1;
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

            String partial = sb.substring(0, ml - THRESHOLD);
            Iterable<String> i = st.keysWithPrefix(partial);

            long at = l;
            i.forEach(s -> {
                String full = sb.toString();
                map.computeIfAbsent(full, k -> new ArrayList<>());
                map.get(full).add(new Match(at,s));
            });

            sb.deleteCharAt(0);
        }
    }

    private static Trie buildTrie() {
        // build symbol table from standard input
        Trie st = new Trie();
        for (int i = 0; !StdIn.isEmpty(); i++) {
            String key = StdIn.readString();
            st.put(key);
        }

        // print results
        if (st.size() < 100) {
            StdOut.println("keys(\"\"):");
            st.keys().forEach(StdOut::println);
        }
        return st;
    }
}
