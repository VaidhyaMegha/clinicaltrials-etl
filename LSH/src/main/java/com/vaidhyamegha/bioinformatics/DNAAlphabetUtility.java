package com.vaidhyamegha.bioinformatics;

import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class DNAAlphabetUtility implements IBIAlphabet {

    @Override
    public int charToIndex(char c) {
        int cnum = -1;

        switch (c) {
            case 'A':
                cnum = 0;
                break;
            case 'C':
                cnum = 1;
                break;
            case 'G':
                cnum = 2;
                break;
            case 'T':
                cnum = 3;
                break;
        }

        return cnum;
    }

    @Override
    public char indexToChar(int num) {
        char c = '-';

        switch (num) {
            case 0:
                c = 'A';
                break;
            case 1:
                c = 'C';
                break;
            case 2:
                c = 'G';
                break;
            case 3:
                c = 'T';
                break;
        }

        return c;
    }

    @Override
    public String reverseComplement(String pattern) {
        int len = pattern.length();
        StringBuilder str = new StringBuilder();

        for (int i = 0; i < len; i++) {
            char c = pattern.charAt(i);
            char cc = '-';

            switch (c) {
                case 'A':
                    cc = 'T';
                    break;
                case 'C':
                    cc = 'G';
                    break;
                case 'G':
                    cc = 'C';
                    break;
                case 'T':
                    cc = 'A';
                    break;
            }

            str.append(cc);
        }

        return str.reverse().toString();
    }

    @Override
    public Map<Character, Integer> countAlphabets(List<String> motifs, int i) {
        Map<Character, Integer> chars = new TreeMap<>();

        return buildCounts(motifs, i, chars);
    }

    @Override
    public Map<Character, Integer> countAlphabetsWithPseudoCount(List<String> motifs, int i) {
        Map<Character, Integer> chars = new TreeMap<>();
        chars.put('A', 1);
        chars.put('C', 1);
        chars.put('T', 1);
        chars.put('G', 1);

        return buildCounts(motifs, i, chars);
    }

    private Map<Character, Integer> buildCounts(List<String> motifs, int i, Map<Character, Integer> chars) {
        for (String s : motifs) {
            char c = s.charAt(i);
            Integer k = chars.get(c);
            chars.put(c, (k == null) ? 1 : k + 1);
        }

        return chars;
    }
}
