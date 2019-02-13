package com.vaidhyamegha;


import java.util.HashMap;
import java.util.Map;

class Trie {
    private Node root;      // root of trie
    private int n;          // number of keys in trie
    private int q;

    private static class Node {
        private Map<Byte, Node> next;
    }

    Trie(int r) {
        this.q = r;
    }

    void put(String key) {
        if (key == null) throw new IllegalArgumentException("first argument to put() is null");

        root = put(root, getBytes(key), 0);
    }

    private byte[] getBytes(String key) {
        char[] chars = key.toCharArray();
        int len = chars.length;
        int numOfBytes = (len / 4) + ((len % 4 != 0) ? 1 : 0);
        byte[] bytes = new byte[numOfBytes];

        for (int i = 0; i < (len + 4) && (i / 4 < numOfBytes); i = i + 4) {
            byte b = 0;

            for (int j = 0; j < 4 && ((i + j) < len); j++)
                b = (byte) ((b << 2) | encode(chars[i + j]));

            bytes[i / 4] = b;
        }

        if (len % 4 != 0) bytes[numOfBytes - 1] = (byte) (bytes[numOfBytes - 1] << 2*(4 - (len % 4)));

        return bytes;
    }

    private byte encode(char cd) {
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
        byte c = key[d];
        return get(x.next.get(c), key, d + 1);
    }

    private Node put(Node x, byte[] key, int d) {
        if (x == null) x = new Node();
        if (d == key.length) {
            n++;
            return x;
        }
        byte c = key[d];
        if (x.next == null) x.next = new HashMap<>();
        x.next.put(c, put(x.next.get(c), key, d + 1));
        return x;
    }

    private void collect(Node x, StringBuilder prefix, Queue<String> results) {
        if (x == null) return;
        else if (x.next == null) results.enqueue(prefix.toString());
        else {
            x.next.forEach((c,v) -> {
                int numOfChars = decodeByte(prefix, c);
                collect(v, prefix, results);
                int len = prefix.length();
                if (numOfChars > 0) prefix.delete(len - numOfChars, len - 1);
            });
        }
    }

    private String decode(byte[] bytes) {
        StringBuilder sb = new StringBuilder();

        for (int i = 0; i < bytes.length && sb.length() < q; i++) {
            byte b = bytes[i];

            decodeByte(sb, b);
        }

        return sb.toString();
    }

    private int decodeByte(StringBuilder sb, byte b) {
        int k = 0;

        for (; k < 4 && sb.length() < q; k++) {
            int temp = (192 & b);

            if (temp == 0) sb.append('A');
            else if (temp == 64) sb.append('T');
            else if (temp == 128) sb.append('C');
            else sb.append('G');

            b = (byte) (b << 2);
        }

        return k;
    }
}
