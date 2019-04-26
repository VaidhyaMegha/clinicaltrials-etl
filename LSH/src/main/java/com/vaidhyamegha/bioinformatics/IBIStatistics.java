package com.vaidhyamegha.bioinformatics;

import java.util.List;

public interface IBIStatistics {
    double entropy(List<String> strings);

    double[] entropyOfColumns(List<String> strings);

    double entropy(double[] distribution);
}
