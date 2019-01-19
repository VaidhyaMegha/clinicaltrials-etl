package com.vaidhyamegha;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.*;
import java.util.regex.Pattern;

public class WQUPC implements IProcessor {
    private final String CHARSET_NAME = "UTF-8";
    private Scanner scanner = new Scanner(new java.io.BufferedInputStream(System.in), CHARSET_NAME);
    private int[] parent; 
    private int[] size;
    private BufferedWriter bw;
    private int count;

    public WQUPC(int n, BufferedWriter writer) {
        bw = writer;
        count = n;
        parent = new int[n];
        size = new int[n];

        for (int i = 0; i < n; i++) {
            parent[i] = i;
            size[i] = 1;
        }
    }

    private int find(int p) {
        validate(p);
        int root = p;
        while (root != parent[root])
            root = parent[root];
        while (p != root) {
            int newp = parent[p];
            parent[p] = root;
            p = newp;
        }
        return root;
    }

    private boolean connected(int p, int q) {
        return find(p) == find(q);
    }

   
    private void validate(int p) {
        int n = parent.length;

        if (p < 0 || p >= n) throw new IllegalArgumentException("index " + p + " is not between 0 and " + (n - 1));
    }

    private void union(int p, int q) {
        int rootP = find(p);
        int rootQ = find(q);
        if (rootP == rootQ) return;

       
        if (size[rootP] < size[rootQ]) {
            parent[rootP] = rootQ;
            size[rootQ] += size[rootP];
        }
        else {
            parent[rootQ] = rootP;
            size[rootP] += size[rootQ];
        }
        count--;
    }

    private String readLine() {
        try {
            return scanner.nextLine();
        }
        catch (NoSuchElementException e) {
            throw new NoSuchElementException("attempts to read a 'String' value from standard input, "
                    + "but no more tokens are available");
        }
    }

    private boolean isEmpty() {
        return !scanner.hasNext();
    }

    private static String csvLine(ArrayList<String> line){
        StringJoiner csvLine = new StringJoiner(",","{component:[", "]}");

        for(String s : line) csvLine.add("\"" + s.trim().replaceAll("\"", "") + "\"");

        return csvLine.toString();
    }

    public static void main(String[] args) throws IOException {
        WQUPC uf = new WQUPC(600000, new BufferedWriter(new OutputStreamWriter(System.out)));

        uf.process(uf);
    }

    @Override
    public void process(WQUPC uf) throws IOException {
        Map<String, Integer> idsMap = new HashMap<>();
        Map<Integer, String> mapIds = new HashMap<>();

        int i = 0;

        while (!uf.isEmpty()) {
            String line = uf.readLine();
            String[] ids = line.split(Pattern.quote("|"));

            int id1, id2;

            if(idsMap.get(ids[0]) == null){
                idsMap.put(ids[0], i);
                mapIds.put(i, ids[0]);
                i++;
            }

            id1 = idsMap.get(ids[0]);

            if(idsMap.get(ids[1]) == null){
                idsMap.put(ids[1], i);
                mapIds.put(i, ids[1]);
                i++;
            }

            id2 = idsMap.get(ids[1]);

            if (uf.connected(id1, id2)) continue;

            uf.union(id1, id2);
        }

        Map<String, ArrayList<String>> result = new HashMap<>();
        for (i = 0; i < uf.parent.length ; i++) {
            if(mapIds.get(i) == null) continue;

            String parent = mapIds.get(uf.parent[i]);
            String child = mapIds.get(i);

            if(result.get(parent) == null) result.put(parent, new ArrayList<>());

            result.get(parent).add(child);
        }

        for (String key : result.keySet()) {
            bw.write(csvLine(result.get(key)));
            bw.newLine();
        }

        bw.flush();
    }

}
