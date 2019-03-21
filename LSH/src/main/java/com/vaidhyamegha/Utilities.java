package com.vaidhyamegha;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

public class Utilities {

    // fill in your PatternCount() function here.

    /**
     *      Count(Text, Pattern), our plan is to “slide a window” down Text, checking whether each k-mer substring of Text
     *      matches Pattern. We will therefore refer to the k-mer starting at position i of Text as Text(i, k).
     *      Throughout this book, we will often use 0-based indexing, meaning that we count starting at 0 instead of 1.
     *      In this case, Text begins at position 0 and ends at position |Text| − 1 (|Text| denotes the number of symbols
     *      in Text). For example, if Text = GACCATACTG, then Text(4, 3) = ATA. Note that the last k-mer of Text begins at
     *      position |Text| − k, e.g., the last 3-mer of GACCATACTG starts at position 10 − 3 = 7.
     */
    public static int PatternCount(String text, String pattern) {
        int count = 0;

        for (int i = 0; i <= (text.length() - pattern.length()); i++){
            if(text.substring(i, i + pattern.length()).equals(pattern)){
                count = count + 1;
            }
        }

        return count;
    }

    // Place your FrequentWords() function here along with any subroutines that you need.

    /**
     *     Frequent Words Problem: Find the most frequent k-mers in a string.
     *
     *     Input: A string Text and an integer k.
     *     Output: All most frequent k-mers in Text.
     *
     *     Refer notes/FrequentWords.png
     */
    public static ArrayList<String> FrequentWords(String text, int k) {
        Set<String> freqPatterns = new HashSet<>();
        int[] count = new int[text.length() - k];
        ArrayList<String> list = new ArrayList<>();

        for (int i = 0; i < text.length() - k; i++){
            String pattern = text.substring(i, i+k);
            count[i] = PatternCount(text, pattern);
        }

        int max = -1;

        for (int i1 : count) max = max > i1 ? max : i1;

        for (int i = 0; i < count.length; i++) {
            if (count[i] == max){
                String pattern = text.substring(i, i+k);

                if(freqPatterns.add(pattern)) list.add(pattern);
            }
        }

        return list;
    }

    public static int PatternToNumber(String pattern) {
        int k = pattern.length();
        int[] patternNumbers = new int[k];

        for (int i = 0; i < k ; i++) {
            char c = pattern.charAt(i);
            int cnum = -1;

            switch (c){
                case 'A' :
                    cnum = 0;
                    break;
                case 'C' :
                    cnum = 1;
                    break;
                case 'G' :
                    cnum = 2;
                    break;
                case 'T' :
                    cnum = 3;
                    break;
            }

            patternNumbers[i] = cnum;
        }

        int index = 0;

        for (int i = 0; i < k ; i++) index = index + ((patternNumbers[i] + 1) * (int) (Math.pow(4, k - (i + 1))));

        return index - ((int)Math.pow(4, k)- 1)/3;
    }

    public static String NumberToPattern(int index, int k){
        char[] pattern = new char[k];

        for (int i = 0; i < k; i++) {
            int num = index % 4;
            char c = '-';

            switch (num){
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

            index = index/4;

            pattern[k - i - 1] = c;
        }

        return new String(pattern);
    }
    public static void main(String[] s){

    }



}
