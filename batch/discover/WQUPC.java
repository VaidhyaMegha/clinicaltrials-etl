import java.util.Locale;
import java.util.NoSuchElementException;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
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

    public boolean isEmpty() {
        return !scanner.hasNext();
    }

    public static void main(String[] args) {

        int n = WQUPC.readInt();
        WQUPC uf = new WQUPC(n);
        while (!uf.isEmpty()) {
            int p = uf.readInt();
            int q = uf.readInt();
            if (uf.connected(p, q)) continue;
            uf.union(p, q);
//            System.out.println(p + " " + q);
        }
        System.out.println(uf.count() + " components");

        Map<Integer, ArrayList<Integer>> result = new HashMap<>();
        for (int i = 0; i < uf.parent.length ; i++) {
            if(uf.size[uf.parent[i]] > 1) {
                if(result.get(uf.parent[i]) == null) result.put(uf.parent[i], new ArrayList<Integer>());
                result.get(uf.parent[i]).add(i);
            }
        }

        System.out.println(result.toString());

    }

}
