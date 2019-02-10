package com.vaidhyamegha;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.*;
import java.util.stream.IntStream;

public class App {
    private static int THRESHOLD;
    private static BlockingQueue<StringWithLocation> bq = null;
    private static Trie st = null;
    private static int ml;
    private static Map<String, List<StringWithLocation>> map = new ConcurrentHashMap<>();
    private static boolean reading = true;

    private static class StringWithLocation {
        long location;
        String str;

        StringWithLocation(long l, String m){
            this.location = l;
            this.str = m;
        }

        public String toString(){
            return "StringWithLocation at location " + location + " for string " + str;
        }
    }

    public static void main(String[] args) throws InterruptedException, ExecutionException {
        String fileName = args[0];
        ml = Integer.parseInt(args[1]);
        THRESHOLD = args.length > 2 ? Integer.parseInt(args[2]) : 10;
        bq = args.length > 3 ? new LinkedBlockingQueue<>(Integer.parseInt(args[3])) : new LinkedBlockingQueue<>();
        int numConsumers =  args.length > 4 ? Integer.parseInt(args[4]) : 4;

        ExecutorService executor = Executors.newFixedThreadPool(numConsumers);
        CompletionService completion = new ExecutorCompletionService(executor);

        st = buildTrie();

        try (BufferedInputStream r = new BufferedInputStream(new FileInputStream(new File(fileName)))) {
            IntStream.range(0, numConsumers).forEach(j -> completion.submit(new Consumer()));

            readStream(r);
        } catch (IOException e) {
            e.printStackTrace();
        }

        reading = false;

        // wait for all tasks to complete.
        for (int i = 0; i < numConsumers; ++i)
            StdOut.println("****************" + completion.take().get() + " completed *****************"); // will block until the next sub task has completed.

        executor.shutdown();

        map.forEach((k,v) -> {
            StdOut.println("-----------------------");
            StdOut.println("Partial matches > threshold for (" + k + "):");

            v.forEach(m -> StdOut.println(m.toString()));
        });
    }

    private static void readStream(BufferedInputStream r) throws IOException {
        int rc = -1; long l = -1;
        StringBuilder sb = new StringBuilder();

        while ((rc = r.read()) !=  -1){
            l++;
            char c = Character.toUpperCase((char) rc);
            if(c == '\r' || c == '\n') continue;
            else if(c != 'A' && c != 'T' && c != 'C' && c != 'G') {
                if (sb.length() > 0) sb.delete(0, sb.length());
                continue;
            }

            sb.append(c);

            if(sb.length() < ml) continue;

            bq.add(new StringWithLocation(l, sb.toString()));

            sb.deleteCharAt(0);
        }
    }

    private static class Consumer implements Callable {

        @Override
        public Boolean call() {
            try {
                while(bq.size() > 0 || reading) {
                    StringWithLocation full = bq.take();

                    String partial = full.str.substring(0, ml - THRESHOLD);
                    Iterable<String> i = st.keysWithPrefix(partial);

                    long at = full.location;

                    i.forEach(s -> {
                        map.computeIfAbsent(full.str, k -> new ArrayList<>());
                        map.get(full.str).add(new StringWithLocation(at, s));
                    });
                }
                return true;
            } catch (InterruptedException e) {
                e.printStackTrace();
                return false;
            }
        }

    }

    private static Trie buildTrie() {
        // build symbol table from standard input
        Trie st = new Trie();
        for (int i = 0; !StdIn.isEmpty(); i++) {
            String key = StdIn.readString();
            st.put(key);
        }

        // print results
        if (st.size() < 100) {
            StdOut.println("keys(\"\"):");
            st.keys().forEach(StdOut::println);
        }
        return st;
    }
}
