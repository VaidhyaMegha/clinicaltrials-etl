package com.vaidhyamegha.bioinformatics;

import java.util.List;
import java.util.Map;

public interface IBIAlphabet {
    int charToIndex(char c);

    char indexToChar(int num);

    String reverseComplement(String pattern);

    Map<Character, Integer> countAlphabets(List<String> motifs, int i);

    Map<Character, Integer> countAlphabetsWithPseudoCount(List<String> motifs, int i);

}
