package com.vaidhyamegha;

public class TrieFlatArray {
    private byte[] patterns;

    public TrieFlatArray(int num) {
        patterns = new byte[num];
    }

    public void put(String s) {
        if (s == null || s.length() == 0) return;
        put(s, 0, 0);
    }

    //too much memory needed
    private void put(String p, int l, int r) {
        if (l == p.length()) return;

        char c = p.charAt(l);
        byte b = (byte) (c == 'A' ? 0 : c == 'T' ? 4 : c == 'C' ? 32 : 192);

        patterns[r] = (byte) (patterns[r] | b);

        r = index(p, ++l);

        put(p, l, r);
    }

    private int index(String p, int l) {
        int j = 1;
        for (int i = 0; i < l; i++) {
            char c = p.charAt(l);
            j =  j*(4^(c == 'A' ? 0 : c == 'T' ? 1 : c == 'C' ? 2 : 3));
        }

        return ((4^(l+1) - 1) / 3) + j;
    }

}
