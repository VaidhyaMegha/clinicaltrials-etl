import java.util.Locale;
import java.util.NoSuchElementException;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.Arrays;
import java.util.regex.Pattern;
import java.util.InputMismatchException;

public class WQUPC {
    private static final String CHARSET_NAME = "UTF-8";
    private static Scanner scanner = new Scanner(new java.io.BufferedInputStream(System.in), CHARSET_NAME);
    private int[] parent; 
    private int[] size;   
   
    private int count;    

    public WQUPC(int n) {
        count = n;
        parent = new int[n];
        size = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
            size[i] = 1;
        }
    }


    public int count() {
        return count;
    }

    public int find(int p) {
        validate(p);
        int root = p;
        while (root != parent[root])
            root = parent[root];
        while (p != root) {
            int newp = parent[p];
            parent[p] = root;
            p = newp;
        }
        return root;
    }

    public boolean connected(int p, int q) {
        return find(p) == find(q);
    }

   
    private void validate(int p) {
        int n = parent.length;
        if (p < 0 || p >= n) {
            throw new IllegalArgumentException("index " + p + " is not between 0 and " + (n-1));
        }
    }

    public void union(int p, int q) {
        int rootP = find(p);
        int rootQ = find(q);
        if (rootP == rootQ) return;

       
        if (size[rootP] < size[rootQ]) {
            parent[rootP] = rootQ;
            size[rootQ] += size[rootP];
        }
        else {
            parent[rootQ] = rootP;
            size[rootP] += size[rootQ];
        }
        count--;
    }

    public static int readInt() {
        try {
            return scanner.nextInt();
        }
        catch (InputMismatchException e) {
            String token = scanner.next();
            throw new InputMismatchException("attempts to read an 'int' value from standard input, "
                    + "but the next token is \"" + token + "\"");
        }
        catch (NoSuchElementException e) {
            throw new NoSuchElementException("attemps to read an 'int' value from standard input, "
                    + "but no more tokens are available");
        }

    }

    public static String readString() {
        try {
            return scanner.next();
        }
        catch (NoSuchElementException e) {
            throw new NoSuchElementException("attempts to read a 'String' value from standard input, "
                    + "but no more tokens are available");
        }
    }

    public static String readLine() {
        try {
            return scanner.nextLine();
        }
        catch (NoSuchElementException e) {
            throw new NoSuchElementException("attempts to read a 'String' value from standard input, "
                    + "but no more tokens are available");
        }
    }

    public boolean isEmpty() {
        return !scanner.hasNext();
    }

    public static void main(String[] args) {
        Map<String, Integer> idsMap = new HashMap<>();
        Map<Integer, String> mapIds = new HashMap<>();

        WQUPC uf = new WQUPC(250000);

        int i = 1;

        while (!uf.isEmpty()) {
            String line = WQUPC.readLine();
//            System.out.println(line);
            String[] ids = line.split(Pattern.quote("|"));

//            System.out.println(ids.length + Arrays.toString(ids));

            ids[0] = ids[0].replaceAll("\"", "");
            ids[1] = ids[1].replaceAll("\"", "");

            int id1, id2;

            if(idsMap.get(ids[0]) == null){
                idsMap.put(ids[0], i);
                mapIds.put(i, ids[0]);
                i++;
            }

            id1 = idsMap.get(ids[0]);

            if(idsMap.get(ids[1]) == null){
                idsMap.put(ids[1], i);
                mapIds.put(i, ids[1]);
                i++;
            }

            id2 = idsMap.get(ids[1]);

            if (uf.connected(id1, id2)) continue;
            uf.union(id1, id2);
        }


        System.out.println(uf.count() + " components");

        Map<String, ArrayList<String>> result = new HashMap<>();
        for (i = 0; i < uf.parent.length ; i++) {
            if(uf.size[uf.parent[i]] > 1) {
                if(result.get(uf.parent[i]) == null) result.put(mapIds.get(uf.parent[i]), new ArrayList<String>());
                result.get(mapIds.get(uf.parent[i])).add(mapIds.get(i));
            }
        }

        System.out.println(result.toString());

    }

}
