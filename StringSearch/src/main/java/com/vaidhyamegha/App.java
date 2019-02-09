package com.vaidhyamegha;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class App {
    public static void main(String[] args) {
        TrieST<Integer> st = buildTrie();

        int ml = Integer.parseInt(args[1]);

        Map<String, List<String>> map = new HashMap<>();

        try (BufferedInputStream r = new BufferedInputStream(new FileInputStream(new File(args[0])))) {
            readStream(st, ml, map, r);

            map.forEach((k,v) -> {
                StdOut.println("-----------------------");
                StdOut.println("keys With Prefix(" + k + "):");

                v.forEach(StdOut::println);
            });

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void readStream(TrieST<Integer> st, int ml, Map<String, List<String>> map, BufferedInputStream r) throws IOException {
        int rc = -1;
        StringBuilder sb = new StringBuilder();

        while ((rc = r.read()) !=  -1){
            char c = Character.toUpperCase((char) rc);
            if(c == '\r' || c == '\n') continue;
            else if(c != 'A' && c != 'T' && c != 'C' && c != 'G') {
                if (sb.length() > 0) sb.delete(0, sb.length());
                continue;
            }

            sb.append(c);

            if(sb.length() < ml) continue;

            String m = sb.toString();
            Iterable<String> i = st.keysWithPrefix(m);

            i.forEach(s -> {
                map.computeIfAbsent(m, k -> new ArrayList<>());
                map.get(m).add(s);
            });

            sb.deleteCharAt(0);
        }
    }

    private static TrieST<Integer> buildTrie() {
        // build symbol table from standard input
        TrieST<Integer> st = new TrieST<>();
        for (int i = 0; !StdIn.isEmpty(); i++) {
            String key = StdIn.readString();
            st.put(key, i);
        }

        // print results
        if (st.size() < 100) {
            StdOut.println("keys(\"\"):");
            for (String key : st.keys()) {
                StdOut.println(key + " " + st.get(key));
            }
            StdOut.println();
        }
        return st;
    }
}
