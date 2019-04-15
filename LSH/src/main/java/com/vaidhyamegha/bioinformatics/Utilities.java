package com.vaidhyamegha.bioinformatics;

import java.util.*;
import java.util.stream.IntStream;

public class Utilities {

    // fill in your PatternCount() function here.

    /**
     *
     * Code Challenge: Implement PatternCount (reproduced below).
     *      Input: Strings Text and Pattern.
     *      Output: Count(Text, Pattern).
     *
     * Sample Input:
     *
     * GCGCG
     * GCG
     *
     * Sample Output:
     *
     * 2
     *
     * Count(Text, Pattern), our plan is to “slide a window” down Text, checking whether each k-mer substring of Text
     * matches Pattern. We will therefore refer to the k-mer starting at position i of Text as Text(i, k).
     * Throughout this book, we will often use 0-based indexing, meaning that we count starting at 0 instead of 1.
     * In this case, Text begins at position 0 and ends at position |Text| − 1 (|Text| denotes the number of symbols
     * in Text). For example, if Text = GACCATACTG, then Text(4, 3) = ATA. Note that the last k-mer of Text begins at
     * position |Text| − k, e.g., the last 3-mer of GACCATACTG starts at position 10 − 3 = 7.
     */
    public static int PatternCount(String text, String pattern) {
        int count = 0;
        int tlen = text.length();
        int plen = pattern.length();

        for (int i = 0; i <= (tlen - plen); i++) {
            if (text.substring(i, i + plen).equals(pattern)) {
                count = count + 1;
            }
        }

        return count;
    }

    // Place your FrequentWords() function here along with any subroutines that you need.

    /**
     * Frequent Words Problem: Find the most frequent k-mers in a string.
     * <p>
     * Input: A string Text and an integer k.
     * Output: All most frequent k-mers in Text.
     * <p>
     * Refer notes/FrequentWords.png
     */
    public static ArrayList<String> FrequentWords(String text, int k) {
        Set<String> freqPatterns = new HashSet<>();
        int[] count = new int[text.length() - k];
        ArrayList<String> list = new ArrayList<>();

        for (int i = 0; i < text.length() - k; i++) {
            String pattern = text.substring(i, i + k);
            count[i] = PatternCount(text, pattern);
        }

        int max = -1;

        for (int i1 : count) max = max > i1 ? max : i1;

        for (int i = 0; i < count.length; i++) {
            if (count[i] == max) {
                String pattern = text.substring(i, i + k);

                if (freqPatterns.add(pattern)) list.add(pattern);
            }
        }

        return list;
    }

    public static long PatternToNumber(String pattern) {
        int k = pattern.length();
        int[] patternNumbers = new int[k];

        for (int i = 0; i < k; i++) patternNumbers[i] = charToIndex(pattern.charAt(i));

        long index = 0;

        for (int i = 0; i < k; i++) index = index + (patternNumbers[k - i - 1] + 1) * (long) (Math.pow(4, i));

        return index - ((long) Math.pow(4, k) - 1) / 3;
    }

    public static String NumberToPattern(int index, int k) {
        char[] pattern = new char[k];

        for (int i = 0; i < k; i++) {
            pattern[k - i - 1] = indexToChar(index % 4);
            index = index / 4;
        }

        return new String(pattern);
    }

    public static int[] FrequencyArray(String text, int k) {
        int[] freq = new int[(int) (Math.pow(4, k))];
        int len = text.length();

        for (int i = 0; i <= (len - k); i++) {
            String pattern = text.substring(i, i + k);
            freq[(int) PatternToNumber(pattern)]++;
        }

        return freq;
    }

    public static ArrayList<String> FasterFrequentWords(String text, int k) {
        int[] freq = FrequencyArray(text, k);
        ArrayList<String> list = new ArrayList<>();

        OptionalInt maxInt = Arrays.stream(freq).max();

        if (maxInt.isPresent()) {
            int max = Arrays.stream(freq).max().getAsInt();

            for (int i = 0; i < freq.length; i++) if (freq[i] == max) list.add(NumberToPattern(i, k));
        }

        return list;
    }

    public static ArrayList<String> FasterFrequentWordsBySorting(String text, int k) {
        int len = text.length();
        int[] patternIndexes;
        ArrayList<String> freqPatterns = new ArrayList<>();

        patternIndexes = IntStream.rangeClosed(0, len - k).map(i -> (int) PatternToNumber(text.substring(i, i + k))).toArray();

        Arrays.sort(patternIndexes);

        Map<Integer, Integer> patternCount = new HashMap<>();

        for (int patternIndex : patternIndexes) {
            if (patternCount.containsKey(patternIndex)) {
                patternCount.put(patternIndex, patternCount.get(patternIndex) + 1);
            } else {
                patternCount.put(patternIndex, 1);
            }
        }

        Collection<Integer> counts = patternCount.values();
        int max = Collections.max(counts);

        Set<Integer> distinctPatternIndexes = patternCount.keySet();

        for (int patternIndex : distinctPatternIndexes) {
            if (patternCount.get(patternIndex) == max)
                freqPatterns.add(NumberToPattern(patternIndex, k));
        }

        return freqPatterns;
    }

    //Fill in your ReverseComplement() function here, along with any necessary subroutines.
    public static String ReverseComplement(String pattern) {
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

    // Fill in your PatternMatching() function here along with any subroutines you need.
    public static ArrayList<Integer> PatternMatching(String pattern, String genome) {
        ArrayList<Integer> positions = new ArrayList<>();
        int len = genome.length();
        int k = pattern.length();
        long patternIndex = PatternToNumber(pattern);

        for (int i = 0; i <= (len - k); i++) {
            String kmer = genome.substring(i, i + k);
            long kmerIndex = PatternToNumber(kmer);

            if (patternIndex == kmerIndex) positions.add(i);
        }

        return positions;
    }

    //Place your ClumpFinding() function here along with any subroutines you need.
    public static List<String> ClumpFinding(String text, int k, int L, int t) {
        int len = text.length();
        Set<String> patterns = new HashSet<>();

        for (int i = 0; i <= (len - L); i++) {
            String window = text.substring(i, i + L);

            int[] freqArray = FrequencyArray(window, k);

            for (int j = 0; j < freqArray.length; j++) {
                if (freqArray[j] >= t) patterns.add(NumberToPattern(j, k));
            }

        }

        return new ArrayList<>(patterns);
    }

    public static List<String> BetterClumpFinding(String text, int k, int L, int t) {
        int len = text.length();
        Set<String> patterns = new HashSet<>();

        int[] freqArray = FrequencyArray(text.substring(0, L), k);

        for (int i = 0; i <= (len - L); i++) {
            String firstPattern = text.substring(i, i + k);
            int index1 = (int) PatternToNumber(firstPattern);
            freqArray[index1]--;

            String lastPattern = text.substring(i + L - k, i + L);
            int index2 = (int) PatternToNumber(lastPattern);
            freqArray[index2]++;

            for (int j = 0; j < freqArray.length; j++) {
                if (freqArray[j] >= t) patterns.add(NumberToPattern(j, k));
            }
        }

        return new ArrayList<>(patterns);
    }

    // Fill in your MinimumSkew() function along with any subroutines you need.
    public static List<Integer> skew(String genome) {
        List<Integer> list = new ArrayList<>();
        int len = genome.length();
        int runningSkew = 0;

        list.add(0);
        for (int i = 0; i < len; i++) {
            char c = genome.charAt(i);

            switch (c) {
                case 'G':
                    runningSkew++;
                    break;
                case 'C':
                    runningSkew--;
                    break;
            }

            list.add(runningSkew);
        }

        return list;
    }

    public static List<Integer> MinimumSkew(List<Integer> skewarray) {
        int len = skewarray.size();
        OptionalInt min = IntStream.range(0, len).map(skewarray::get).min();
        List<Integer> list = new ArrayList<>();

        if (min.isPresent())
            for (int i = 0; i < len; i++)
                if (skewarray.get(i) == min.getAsInt()) list.add(i);

        return list;
    }


    // Fill in your HammingDistance() function here.
    public static int HammingDistance(String p, String q) {
        int len1 = p.length();
        int len2 = q.length();
        int distance = 0;

        if (len1 != len2) return -1;

        for (int i = 0; i < len1; i++) {
            if (p.charAt(i) != q.charAt(i)) distance++;
        }

        return distance;
    }


    //fill in your ApproximatePatternMatching() function here with any subroutines you need.
    public static List<Integer> ApproximatePatternMatching(String text, String pattern, int match) {
        List<Integer> list = new ArrayList<>();
        int tlen = text.length();
        int plen = pattern.length();

        for (int i = 0; i <= tlen - plen; i++)
            if (Math.abs(HammingDistance(text.substring(i, i + plen), pattern)) <= match)
                list.add(i);

        return list;
    }

    //fill in your ApproximatePatternCount() function here with any subroutines you need.
    public static int ApproximatePatternCount(String text, String pattern, int match) {
        int count = 0;
        int tlen = text.length();
        int plen = pattern.length();

        for (int i = 0; i <= (tlen - plen); i++)
            if (Math.abs(HammingDistance(text.substring(i, i + plen), pattern)) <= match)
                count++;

        return count;
    }

    /**
     * Code Challenge: Implement Neighbors to find the d-neighborhood of a string.
     * <p>
     * Input: A string Pattern and an integer d.
     * Output: The collection of strings Neighbors(Pattern, d). (You may return the strings in any order, but each line should contain only one string.)
     */
    public static Set<String> Neighbors(String pattern, int d) {
        Set<String> neighbors = new HashSet<>();
        if (d == 0) {
            neighbors.add(pattern);
        } else {
            int len = pattern.length();
            String[] alphabet = new String[]{"A", "C", "G", "T"};

            if (len > 1) {
                Set<String> suffixNeighbors = Neighbors(pattern.substring(1, len), d);
                for (String s : suffixNeighbors) {
                    for (String al : alphabet) {
                        String neighbor = al + s;

                        if (HammingDistance(pattern, neighbor) <= d)
                            neighbors.add(neighbor);
                    }
                }
            } else
                Collections.addAll(neighbors, alphabet);

        }

        return neighbors;
    }

    // place your FrequentWordsWithMismatches() function here along with any needed subroutines
    public static List<String> FrequentWordsWithMismatches(String text, int k, int d) {
        int len = text.length();

        ArrayList<String> freqPatterns = new ArrayList<>();
        Map<String, Integer> patternCount = new HashMap<>();

        for (int i = 0; i <= (len - k); i++) {
            String kmer = text.substring(i, i + k);
            Set<String> neighbors = Neighbors(kmer, d);

            for (String s : neighbors) {
                if (patternCount.containsKey(s)) {
                    patternCount.put(s, patternCount.get(s) + 1);
                } else {
                    patternCount.put(s, 1);
                }
            }
        }

        Optional<Integer> max = patternCount.values().stream().max(Comparator.comparingInt(i -> i));

        if (max.isPresent()) {
            int maximum = max.get();

            for (String s : patternCount.keySet()) {
                if (patternCount.get(s) == maximum)
                    freqPatterns.add(s);
            }
        }

        return freqPatterns;
    }

    public static List<String> FrequentWordsWithMismatchesAndReverseComplement(String text, int k, int d) {

        Map<String, Integer> freqPatterns = frequentWordsWithMismatchesAndRCMap(text, k, d);

        return new ArrayList<>(freqPatterns.keySet());
    }

    public static Map<String, Integer> ClumpFindingWithSkewMismatchesAndRC(String text, int k, int L, int d) {
        Map<String, Integer> patterns = new HashMap<>();

        List<Integer> minimumSkew = MinimumSkew(skew(text));

        System.out.println(minimumSkew.toString());

        for (int index : minimumSkew) {
            Map<String, Integer> freqPatterns = frequentWordsWithMismatchesAndRCMap(text.substring(index -1 , index + L), k, d);

            patterns.putAll(freqPatterns);

            if (index > L - 1) {
                freqPatterns = frequentWordsWithMismatchesAndRCMap(text.substring(index - L - 1, index), k, d);
                patterns.putAll(freqPatterns);
            }
        }


        return patterns;
    }

    /**
     * Exercise Break: What is the expected number of occurrences of a 9-mer in 500 random DNA strings, each of length
     * 1000? Assume that the sequences are formed by selecting each nucleotide (A, C, G, T) with the same probability (0.25).
     *
     * Note: Express your answer as a decimal; allowable error = 0.0001.
     * @param numOfStrings
     * @param len
     * @param k
     * @param alphabetProbability
     * @return
     */
    public static double ProbabilityOfOccurrrence(int numOfStrings, int len, int k, double alphabetProbability) {
        return ((len - k + 1) * (Math.pow(alphabetProbability, k)) * numOfStrings) ;
    }

    /**
     * A brute force algorithm for motif finding
     * Given a collection of strings Dna and an integer d, a k-mer is a (k,d)-motif if it appears in every string from
     * Dna with at most d mismatches. For example, the implanted 15-mer in the strings above represents a (15,4)-motif.
     *
     * 1 "atgaccgggatactgatAgAAgAAAGGttGGGggcgtacacattagataaacgtatgaagtacgttagactcggcgccgccg"
     * 2 "acccctattttttgagcagatttagtgacctggaaaaaaaatttgagtacaaaacttttccgaatacAAtAAAAcGGcGGGa"
     * 3 "tgagtatccctgggatgacttAAAAtAAtGGaGtGGtgctctcccgatttttgaatatgtaggatcattcgccagggtccga"
     * 4 "gctgagaattggatgcAAAAAAAGGGattGtccacgcaatcgcgaaccaacgcggacccaaaggcaagaccgataaaggaga"
     * 5 "tcccttttgcggtaatgtgccgggaggctggttacgtagggaagccctaacggacttaatAtAAtAAAGGaaGGGcttatag"
     * 6 "gtcaatcatgttcttgtgaatggatttAAcAAtAAGGGctGGgaccgcttggcgcacccaaattcagtgtgggcgagcgcaa"
     * 7 "cggttttggcccttgttagaggcccccgtAtAAAcAAGGaGGGccaattatgagagagctaatctatcgcgtgcgtgttcat"
     * 8 "aacttgagttAAAAAAtAGGGaGccctggggcacatacaagaggagtcttccttatcagttaatgctgtatgacactatgta"
     * 9 "ttggcccattggctaaaagcccaacttgacaaatggaagatagaatccttgcatActAAAAAGGaGcGGaccgaaagggaag"
     * 10 "ctggtgagcaacgacagattcttacgtgcattagctcgcttccggggatctaatagcacgaagcttActAAAAAGGaGcGGa"
     *
     *  --- AAAAAAAAGGGGGGG ---
     *
     * Implanted Motif Problem: Find all (k, d)-motifs in a collection of strings.
     *
     * Input: A collection of strings Dna, and integers k and d.
     * Output: All (k, d)-motifs in Dna.
     * Brute force (also known as exhaustive search) is a general problem-solving technique that explores all possible
     * solution candidates and checks whether each candidate solves the problem. Such algorithms require little effort
     * to design and are guaranteed to produce a correct solution, but they may take an enormous amount of time, and
     * the number of candidates may be too large to check.
     *
     * A brute force approach for solving the Implanted Motif Problem is based on the observation that any (k, d)-motif
     * must be at most d mismatches apart from some k-mer appearing in the first string in Dna. Therefore, we can
     * generate all such k-mers and then check which of them are (k, d)-motifs.
     */
    public static Set<String> MotifEnumeration(List<String> dnas, int k, int d) {
        String first = dnas.get(0);
        int len = first.length();
        int n = dnas.size();
        Set<String> motifs = new HashSet<>();

        for (int i = 0; i <= (len - k) ; i++) {
            String pattern = first.substring(i, i + k);
            Set<String> neighbors = Neighbors(pattern, d);

            Loop1 : for (String s : neighbors) {
               Loop2 : for (int j = 1; j < n; j++) {
                   String text = dnas.get(j);
                   int tlen = text.length();

                   for (int m = 0; m <= (tlen - k); m++)
                       if (HammingDistance(text.substring(m, m + k), s) <= d)
                           continue Loop2;

                   continue Loop1;
               }

               motifs.add(s);
           }
        }

        return motifs;
    }

    public static int Score(List<String> motifs){
        int len = motifs.get(0).length();
        int num = motifs.size();
        int score = 0;

        for(int i = 0 ; i < len; i++){
            Map<Character, Integer> chars = countAlphabets(motifs, i);

            OptionalInt max = chars.values().stream().mapToInt(Integer::intValue).max();

            if(max.isPresent()) score += num - max.getAsInt();
        }

        return score;
    }
    public static Map<Character, Integer>[] Count(List<String> motifs){
        int len = motifs.get(0).length();
        Map[] counts = new Map[len];

        for(int i = 0 ; i < len; i++)
            counts[i] =  countAlphabets(motifs, i);

        return counts;
    }

    public static Map<Character, Double>[] Profile(List<String> motifs){
        int len = motifs.get(0).length();
        Map[] profiles = new Map[len];

        for(int i = 0 ; i < len; i++){
            Map<Character, Integer> chars = countAlphabets(motifs, i);
            Map<Character, Double> profileChars = new TreeMap<>();

            int sum = chars.values().stream().mapToInt(Integer::intValue).sum();

            for(char c : chars.keySet())
                profileChars.put(c, (double)chars.get(c)/sum);

            profiles[i] = profileChars;
        }

        return profiles;
    }

    public static Map<Character, List<Double>> ProfileMap(List<String> motifs){
        int len = motifs.get(0).length();
        Map<Character, List<Double>> profiles = new TreeMap<>();
        Double[] d = new Double[len];

        for(int i = 0 ; i < len; i++){
            Map<Character, Integer> chars = countAlphabets(motifs, i);

            int sum = chars.values().stream().mapToInt(Integer::intValue).sum();

            for(char c : chars.keySet()) {
                profiles.computeIfAbsent(c, k -> new ArrayList<>(Arrays.asList(d)));
                profiles.get(c).add(i, (double) chars.get(c) / sum);
            }
        }

        return profiles;
    }

    public static Map<Character, List<Double>> ProfileWithPseudoCount(List<String> motifs){
        int len = motifs.get(0).length();
        Map<Character, List<Double>> profiles = new TreeMap<>();
        Double[] d = new Double[len];

        for(int i = 0 ; i < len; i++){
            Map<Character, Integer> chars = countAlphabetsWithPseudoCount(motifs, i);

            int sum = chars.values().stream().mapToInt(Integer::intValue).sum();

            for(char c : chars.keySet()) {
                profiles.computeIfAbsent(c, k -> new ArrayList<>(Arrays.asList(d)));
                profiles.get(c).add(i, (double) chars.get(c) / sum);
            }
        }

        return profiles;
    }

    public static String Consensus(List<String> motifs){
        int len = motifs.get(0).length();
        StringBuilder consensus = new StringBuilder();

        for(int i = 0 ; i < len; i++){
            Map<Character, Integer> chars = countAlphabets(motifs, i);
            Map.Entry<Character, Integer> maxEntry = null;

            for(Map.Entry<Character, Integer> entry : chars.entrySet())
                if (maxEntry == null || entry.getValue().compareTo(maxEntry.getValue()) > 0) {
                    maxEntry = entry;
                }

            consensus.append(maxEntry.getKey());
        }

        return consensus.toString();
    }

    public static double Entropy(List<String> motifs){
        double[] entropies = EntropyOfColumns(motifs);

        return Arrays.stream(entropies).sum();
    }


    /**
     * Motif Finding Problem: Given a collection of strings, find a set of k-mers, one from each string, that minimizes
     * the score of the resulting motif.
     *
     * Input: A collection of strings Dna and an integer k.
     * Output: A collection Motifs of k-mers, one from each string in Dna, minimizing Score(Motifs) among all possible
     * choices of k-mers.
     *
     * A brute force algorithm for the Motif Finding Problem (referred to as BruteForceMotifSearch) considers every
     * possible choice of k-mers Motifs from Dna (one k-mer from each string of n nucleotides) and returns the
     * collection Motifs having minimum score. Because there are n - k + 1 choices of k-mers in each of t sequences,
     * there are (n - k + 1)t different ways to form Motifs. For each choice of Motifs, the algorithm calculates
     * Score(Motifs), which requires k · t steps. Thus, assuming that k is smaller than n, the overall running
     * time of the algorithm is O(nt · k · t). We need to come up with a faster algorithm!
     *
     */
    public static String FindLeastScoreMotif(List<String> dnas, int k){
        return  MedianString(dnas, k);
    }

    /**
     * Code Challenge: Implement MedianString.
     *
     * Input: An integer k, followed by a collection of strings Dna.
     * Output: A k-mer Pattern that minimizes d(Pattern, Dna) among all possible choices of k-mers. (If there are multiple such strings Pattern, then you may return any one.)
     *
     * Sample Input:
     *
     * 3
     * AAATTGACGCAT
     * GACGACCACGTT
     * CGTCAGCGCCTG
     * GCTGAGCACCGG
     * AGTTCGGGACAG
     *
     *
     * Sample Output:
     *
     * GAC
     *
     * We now give the pseudocode for a brute force solution to the Median String Problem.
     *
     *     MedianString(Dna, k)
     *         distance ← ∞
     *         for each k-mer Pattern from AA…AA to TT…TT
     *             if distance > d(Pattern, Dna)
     *                  distance ← d(Pattern, Dna)
     *                  Median ← Pattern
     *         return Median
     *
     * Although this pseudocode is short, it is not without potential pitfalls. Check out Charging Station: Solving the Median String Problem if you fall into one of them.
     *
     * STOP and Think: Instead of making a time-consuming search through all possible k-mers in MedianString, can you only search through all k-mers that appear in Dna?
     *
     * @param dnas
     * @param k
     * @return
     */
    public static String MedianString(List<String> dnas, int k){
        //brute force
        // find all k-mers - 4^k possibilities
        // loop through each kmer
        // loop through each dna

        // Alternative suggested is to use just the kmers found in dna... not quite sure if that is sufficient.
//        Map<String, Integer> pDistances = new HashMap<>();
//
//        for (String dna : dnas) {
//            int dnaLen = dna.length();
//
//            for (int l = 0; l <= (dnaLen - k); l++) {
//                pDistances.put(dna.substring(l, l + k), Integer.MAX_VALUE);
//            }
//        }

        Map<String, Integer> pDistances = new HashMap<>();

        for(int i=0 ; i < ((int)Math.pow(4,k) - 1); i++){
            String p = NumberToPattern(i, k);
            int sumOfDistances = 0;

            sumOfDistances = DistanceBetweenPatternAndStrings(dnas, p);

            pDistances.put(p, sumOfDistances);
        }

        int minSumOfDistances = Integer.MAX_VALUE;
        String median = "";

        for (Map.Entry<String, Integer> entry : pDistances.entrySet()){
            int d = entry.getValue();
            if (d < minSumOfDistances){
           // if (d <= minSumOfDistances){ // Stepik needs this for this coding challenge : https://stepik.org/lesson/10965/step/2?discussion=120926&reply=826143&unit
               median = entry.getKey();
               minSumOfDistances = d;
            }
        }

        return median;
    }

    public static int DistanceBetweenPatternAndStrings(List<String> dnas, String p) {
        int sumOfDistances = 0;
        int k = p.length();

        for (String dna : dnas) {
            int distance = Integer.MAX_VALUE;
            int dnaLen = dna.length();

            for (int l = 0; l <= (dnaLen - k); l++) {
                String ssCandidate = dna.substring(l, l + k);
                int d = HammingDistance(p, ssCandidate);
                if (d < distance) distance = d;
            }

            sumOfDistances += distance;
        }
        return sumOfDistances;
    }

    /**
     *
     * GreedyMotifSearch, starts by forming a motif matrix from arbitrarily selected k-mers in each string from Dna
     * (whicammh in our specific implementation is the first k-mer in each string). It then attempts to improve this
     * initial motif matrix by trying each of the k-mers in Dna1 as the first motif. For a given choice of k-mer
     * Motif1 in Dna1, it builds a profile matrix Profile for this lone k-mer, and sets Motif2 equal to the
     * Profile-most probable k-mer in Dna2. It then iterates by updating Profile as the profile matrix formed
     * from Motif1 and Motif2, and sets Motif3 equal to the Profile-most probable k-mer in Dna3. In general,
     * after finding i − 1 k-mers Motifs in the first i − 1 strings of Dna, GreedyMotifSearch constructs
     * Profile(Motifs) and selects the Profile-most probable k-mer from Dnai based on this profile matrix.
     *
     * After obtaining a k-mer from each string to obtain a collection Motifs, GreedyMotifSearch tests to see whether
     * Motifs outscores the current best scoring collection of motifs and then moves Motif1 one symbol over in Dna1,
     * beginning the entire process of generating Motifs again.
     *
     *     GreedyMotifSearch(Dna, k, t)
     *         BestMotifs ← motif matrix formed by first k-mers in each string from Dna
     *         for each k-mer Motif in the first string from Dna
     *             Motif1 ← Motif
     *             for i = 2 to t
     *                 form Profile from motifs Motif1, …, Motifi - 1
     *                 Motifi ← Profile-most probable k-mer in the i-th string in Dna
     *             Motifs ← (Motif1, …, Motift)
     *             if Score(Motifs) < Score(BestMotifs)
     *                 BestMotifs ← Motifs
     *         return BestMotifs
     *
     */
    public static List<String> GreedyMotifSearch(List<String> dna, int k, int t){
        int len = dna.get(0).length();
        List<String> f = new ArrayList<>();
        int score = Integer.MAX_VALUE;

        List<String> motifs = new ArrayList<>();

        for (String d : dna) motifs.add(d.substring(0, k));

        L1: for (int j = 0; j <= (len - k); j++) {
            motifs.set(0, dna.get(0).substring(j, j + k));

            for (int i = 1; i < t; i++) motifs.set(i, ProfileMostProbablekmer(dna.get(i), k, ProfileMap(motifs.subList(0, i))));


            int s = Score(motifs);

            if (s < score) {
                f = new ArrayList<>(motifs);
                score = s;
            }
        }

        return f;
    }

    public static List<String> GreedyMotifSearchWithPseudoCount(List<String> dna, int k, int t){
        int len = dna.get(0).length();
        List<String> f = new ArrayList<>();
        int score = Integer.MAX_VALUE;

        List<String> motifs = new ArrayList<>();

        for (String d : dna) motifs.add(d.substring(0, k));

        L1: for (int j = 0; j <= (len - k); j++) {
            motifs.set(0, dna.get(0).substring(j, j + k));

            for (int i = 1; i < t; i++) motifs.set(i, ProfileMostProbablekmer(dna.get(i), k, ProfileWithPseudoCount(motifs.subList(0, i))));


            int s = Score(motifs);

            if (s < score) {
                f = new ArrayList<>(motifs);
                score = s;
            }
        }

        return f;
    }


    public static String ProfileMostProbablekmer(String text, int k, Map<Character, List <Double>> profile) {
        double max = 0.0;
        String mostProbable = text.substring(0, k);
        int len = text.length();

        for(int i=0 ; i <= (len - k); i++) {
            String p = text.substring(i, i + k);
            double prob = ProbabilityOfPatternInAProfile(profile, p);

            if(prob > max) {
                max = prob;
                mostProbable = p;
            }
        }

        return mostProbable;
    }

    public static double ProbabilityOfPatternInAProfile(Map<Character, List <Double>> profile, String pattern) {
        double prob = 1;

        char[] charArray = pattern.toCharArray();

        for (int i = 0; i < charArray.length; i++) {
            char c = charArray[i];

            if(profile.get(c) == null || profile.get(c).size() <= i || profile.get(c).get(i) == null)
                return 0;

            prob *= profile.get(c).get(i);
        }

        return prob;
    }

    public static double ProbabilityOfPatternInAProfile(double[][] profile, String pattern) {
        int len  = pattern.length();
        double prob = 1;

        for (int j = 0; j < len ; j++) prob *= profile[charToIndex(pattern.charAt(j))][j];

        return prob;
    }

    private static int charToIndex(char c) {
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

    private static char indexToChar(int num) {
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

    private static double[] EntropyOfColumns(List<String> motifs){
        Map<Character, Double>[] profile = Profile(motifs);
        int len = profile.length;
        double[] entropies = new double[len];

        for(int i = 0; i < len ; i++) {
            Map<Character, Double> map = profile[i];
            double entropy = 0;
            for (Map.Entry<Character, Double> entry : map.entrySet()){
                double p = entry.getValue();
                entropy += (p == 0)? 0 : p * (Math.log(p)/Math.log(2));
            }

            entropies[i] = (-1) * entropy;
        }

        return entropies;
    }

    private static Map<Character, Integer> countAlphabets(List<String> motifs, int i) {
        Map<Character, Integer> chars = new TreeMap<>();

        for (String s : motifs) {
            char c = s.charAt(i);
            Integer k = chars.get(c);
            chars.put(c, (k == null) ? 1 : k + 1);
        }

        return chars;
    }


    private static Map<Character, Integer> countAlphabetsWithPseudoCount(List<String> motifs, int i) {
        Map<Character, Integer> chars = new TreeMap<>();
        chars.put('A', 1);
        chars.put('C', 1);
        chars.put('T', 1);
        chars.put('G', 1);

        for (String s : motifs) {
            char c = s.charAt(i);
            Integer k = chars.get(c);
            chars.put(c, (k == null) ? 1 : k + 1);
        }

        return chars;
    }

    private static Map<String, Integer> frequentWordsWithMismatchesAndRCMap(String text, int k, int d) {
        int len = text.length();

        Map<String, Integer> freqPatterns = new HashMap<>();
        Map<String, Integer> patternCount = new HashMap<>();

        for (int i = 0; i <= (len - k); i++) {
            String kmer = text.substring(i, i + k);
            Set<String> neighbors = Neighbors(kmer, d);

            for (String s : neighbors) {
                if (patternCount.containsKey(s)) {
                    patternCount.put(s, patternCount.get(s) + 1);
                } else {
                    patternCount.put(s, 1);
                }

                String rc = ReverseComplement(s);
                if (patternCount.containsKey(rc)) {
                    patternCount.put(rc, patternCount.get(rc) + 1);
                } else {
                    patternCount.put(rc, 1);
                }

            }
        }

        int maximum = -1;

        for (String s : patternCount.keySet()) {
            Integer i = patternCount.get(ReverseComplement(s));
            int count = patternCount.get(s) + ((i == null) ? 0 : i);

            if (count > maximum)
                maximum = count;
        }

        for (String s : patternCount.keySet()) {
            Integer i = patternCount.get(s);
            Integer j = patternCount.get(ReverseComplement(s));
            int j1 = ((j == null) ? 0 : j);

            if ((i + j1) == maximum)
                freqPatterns.put(s, maximum);
        }

        return freqPatterns;
    }


    public static double entropy(double[] distribution){
        return (-1) * Arrays.stream(distribution).map(d -> d == 0 ? 0 : d * Math.log(d) / Math.log(2)).sum();
    }
}
