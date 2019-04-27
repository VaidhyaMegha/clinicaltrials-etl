package com.vaidhyamegha.bioinformatics;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface IBIAlgorithms extends IBIStatistics, IBIAlphabet {
    int patternCount(String text, String pattern);

    long patternToNumber(String pattern);

    String numberToPattern(int index, int k);

    List<Integer> patternMatching(String pattern, String genome);

    int[] frequencyArray(String text, int k);

    List<String> frequentWords(String text, int k);

    List<String> fasterFrequentWords(String text, int k);

    List<String> fasterFrequentWordsBySorting(String text, int k);

    List<String> frequentWordsWithMismatches(String text, int k, int d);

    List<String> frequentWordsWithMismatchesAndReverseComplement(String text, int k, int d);

    Map<String, Integer> frequentWordsWithMismatchesAndRCMap(String text, int k, int d);

    List<String> clumpFinding(String text, int k, int L, int t);

    List<String> betterClumpFinding(String text, int k, int L, int t);

    Map<String, Integer> clumpFindingWithSkewMismatchesAndRC(String text, int k, int L, int d);

    List<Integer> skew(String genome);

    List<Integer> minimumSkew(List<Integer> skewarray);

    int HammingDistance(String p, String q);

    List<Integer> approximatePatternMatching(String text, String pattern, int match);

    int approximatePatternCount(String text, String pattern, int match);

    Set<String> neighbors(String pattern, int d);

    double probabilityOfOccurrrence(int numOfStrings, int len, int k, double alphabetProbability);

    Set<String> motifEnumeration(List<String> dnas, int k, int d);

    int score(List<String> motifs);

    Map<Character, Integer>[] count(List<String> motifs);

    Map<Character, Double>[] profile(List<String> motifs);

    Map<Character, List<Double>> profileMap(List<String> motifs);

    Map<Character, List<Double>> profileWithPseudoCount(List<String> motifs);

    void buildProfile(Map<Character, List<Double>> profiles, Double[] d, int i, Map<Character, Integer> chars);

    String consensus(List<String> motifs);

    String FindLeastScoreMotif(List<String> dnas, int k);

    String MedianString(List<String> dnas, int k);

    int DistanceBetweenPatternAndStrings(List<String> dnas, String p);

    List<String> greedyMotifSearch(List<String> dna, int k, int t);

    List<String> greedyMotifSearchWithPseudoCount(List<String> dna, int k, int t);

    String ProfileMostProbablekmer(String text, int k, Map<Character, List<Double>> profile);

    double ProbabilityOfPatternInAProfile(Map<Character, List<Double>> profile, String pattern);

    double ProbabilityOfPatternInAProfile(double[][] profile, String pattern);

    List<String> randomizedMotifSearch(List<String> dna, int k, int t);

    List<String> randomizedMotifSearch(List<String> dna, List<String> bestMotifs, int k, int t);

    double computeProbability1();

    double computeProbability2();

    List<String> GibbsSampler(List<String> dna, int k, int t, int N);
}
