package com.vaidhyamegha;


class Trie {
    private static final int R = 4;        // ATCG
    private Node root;      // root of trie
    private int n;          // number of keys in trie

    private static class Node {
        private Node[] next;
    }

    Trie() { }

    void put(String key) {
        if (key == null) throw new IllegalArgumentException("first argument to put() is null");
        else root = put(root, key, 0);
    }

    int size() {
        return n;
    }

    Iterable<String> keys() {
        return keysWithPrefix("");
    }

    Iterable<String> keysWithPrefix(String prefix) {
        Queue<String> results = new Queue<>();
        Node x = get(root, prefix, 0);
        collect(x, new StringBuilder(prefix), results);
        return results;
    }

    private Node get(Node x, String key, int d) {
        if (x == null) return null;
        if (d == key.length()) return x;
        int c = charToIndex(key, d);
        return get(x.next[c], key, d + 1);
    }

    private int charToIndex(String key, int d) {
        char cd = Character.toUpperCase(key.charAt(d));
        return (cd == 'A' ? 0 : (cd == 'T' ? 1 : (cd == 'C' ? 2 : 3))) ;
    }

    private Node put(Node x, String key, int d) {
        if (x == null) x = new Node();
        if (d == key.length()) {
            n++;
            return x;
        }
        int c = charToIndex(key, d);
        if (x.next == null) x.next = new Node[R];
        x.next[c] = put(x.next[c], key,d + 1);
        return x;
    }

    private void collect(Node x, StringBuilder prefix, Queue<String> results) {
        if (x == null) return;
        if (x.next == null) results.enqueue(prefix.toString());
        else {
            for (char c = 0; c < R; c++) {
                prefix.append(c == 0 ? 'A' : c == 1 ? 'T' : c == 2 ? 'C' : 'G');
                collect(x.next[c], prefix, results);
                prefix.deleteCharAt(prefix.length() - 1);
            }
        }
    }
}
