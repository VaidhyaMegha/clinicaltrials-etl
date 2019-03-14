package  com.vaidhyamegha;
import info.debatty.java.lsh.LSHMinHash;

import java.util.Arrays;
import java.util.Random;
import java.util.stream.IntStream;

public class SimpleLSHMinHashExample {

    public static void main(String[] args) {
        // proportion of 0's in the vectors
        // if the vectors are dense (lots of 1's), the average jaccard similarity
        // will be very high (especially for large vectors), and LSH
        // won't be able to distinguish them
        // as a result, all vectors will be binned in the same bucket...
        double sparsity = 0.75;

        // Number of sets
        int count = 10000;

        // Size of vectors
        int n = 100;

        // LSH parameters
        // the number of stages is also sometimes called the number of bands
        int stages = 2;

        // Attention: to get relevant results, the number of elements per bucket
        // should be at least 100
        int buckets = 10;

        // Let's generate some random sets
        boolean[][] vectors = new boolean[count][n];
        Random rand = new Random();

        for (int i = 0; i < count; i++) for (int j = 0; j < n; j++) vectors[i][j] = rand.nextDouble() > sparsity;

        // Create and configure LSH algorithm
        LSHMinHash lsh = new LSHMinHash(stages, buckets, n);

        int[][] counts = new int[stages][buckets];

        // Perform hashing
        for (boolean[] vector : vectors) {
            int[] hash = lsh.hash(vector);

            IntStream.range(0, hash.length).forEach(i -> counts[i][hash[i]]++);

            print(vector);
            System.out.print(" : ");
            print(hash);
            System.out.print("\n");
        }

        System.out.println("Number of elements per bucket at each stage:");
        IntStream.range(0, stages).forEach(i -> {
            print(counts[i]);
            System.out.print("\n");
        });
    }

    static void print(int[] array) {
        System.out.print("[");
        Arrays.stream(array).mapToObj(v -> "" + v + " ").forEach(System.out::print);
        System.out.print("]");
    }

    static void print(boolean[] array) {
        System.out.print("[");
        for (boolean v : array) System.out.print(v ? "1" : "0");
        System.out.print("]");
    }
}
