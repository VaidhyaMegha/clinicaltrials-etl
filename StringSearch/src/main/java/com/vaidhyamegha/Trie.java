package com.vaidhyamegha;


import java.util.HashMap;
import java.util.Map;

class Trie {
    private int R;
    private Node root;      // root of trie
    private int n;          // number of keys in trie
    private int w;

    private static class Node {
        private Map<Integer, Node> next;
    }

    Trie(int r) {
        this.R = 4*4*4*4;
        this.w = r/4 + ( r % 4 != 0 ? 1 : 0);
    }

    void put(String key) {
        if (key == null) throw new IllegalArgumentException("first argument to put() is null");

        root = put(root, getBytes(key), 0);
    }

    private byte[] getBytes(String key) {
        char[] chars = key.toCharArray();

        byte[] bytes = new byte[w];

        for (int i = 0; i < (chars.length + 4) && (i/4 < w); i = i + 4) {
            byte b = 0;

            for (int j = 0; j < 4 && ((i + j) < chars.length); j++)
                b = (byte) ((b << 2) | encode(chars[i + j]));

            bytes[i/4] = b;
        }

        return bytes;
    }

    private byte encode(char cd){
        char c = Character.toUpperCase(cd);
        return (byte) (c == 'A' ? 0 : c == 'T' ? 1 : c == 'C' ? 2 : 3);
    }

    int size() {
        return n;
    }

    Iterable<String> keys() {
        return keysWithPrefix("");
    }

    Iterable<String> keysWithPrefix(String prefix) {
        Queue<String> results = new Queue<>();
        byte[] bytes = getBytes(prefix);
        Node x = get(root, bytes, 0);
        collect(x, new StringBuilder(prefix), results);
        return results;
    }

    private Node get(Node x, byte[] key, int d) {
        if (x == null) return null;
        if (d == key.length) return x;
        int c = (255 & key[d]);
        return get(x.next.get(c), key, d + 1);
    }

    private Node put(Node x, byte[] key, int d) {
        if (x == null) x = new Node();
        if (d == key.length) {
            n++;
            return x;
        }
        int c = (255 & key[d]);
        if (x.next == null) x.next = new HashMap<>();
        x.next.put(c, put(x.next.get(c), key,d + 1));
        return x;
    }

    private void collect(Node x, StringBuilder prefix, Queue<String> results) {
        if (x == null) return;
        if (x.next == null) results.enqueue(prefix.toString());
        else {
            for (byte c = 0; c < R; c++) {
                int numOfChars = decodeByte(prefix, c);
                collect(x.next.get(255 | c), prefix, results);
                for (int i = 0; i < numOfChars; i++) prefix.deleteCharAt(prefix.length() - 1);
            }
        }
    }

    private String decode(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        int j = 0;

        for (int i = 0; i < bytes.length && sb.length() <= w; i++) {
            byte b = bytes[i];

            decodeByte(sb, b);
        }

        return sb.toString();
    }

    private int decodeByte(StringBuilder sb, byte b) {
        int k = 0;

        for (; k < 4 && sb.length() <= w ; k++) {
            byte temp = (byte) (192 & b);

            if(temp == 0) sb.append('A');
            else if (temp == 1) sb.append('T');
            else if (temp == 2) sb.append('C');
            else  sb.append('G');

            b = (byte)(b << 2);
        }
        
        return k - 1;
    }
}
