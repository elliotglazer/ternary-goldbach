# Keep finite-map consequences symbolic

Map12 constructed the fuel-sort theorem, translated the full finite predicate and evaluated it to true with the source's exact conclusion and empty-hypothesis gate. Its inner log records finite_map_checked, map_sorted_units and map_permutation. It then remained in expected_units_distinct and did not export a complete theory or reach the reload audit.

The original proof invoked the general simplifier on the literal GENLIST I 10004 before applying the symbolic distinctness lemma. The standard list theory marks GENLIST_NUMERALS as a simplification rule, allowing a large literal list expansion. The root stopped the verified owned container after locating this avoidable proof path; its partial logs and original source remain under history/map12_list_simplification. No full map acceptance or throughput claim is inferred from the partial run.

The successor uses REWRITE_TAC and bool_ss to apply FILTER_ALL_DISTINCT and ALL_DISTINCT_GENLIST symbolically. The analogous final membership simplification also uses bool_ss and the explicit identity equation. Only these two proof bodies change. Definitions, finite predicate, checked domain and all theorem statements remain unchanged.

Successor SHA256: `b9d0bd0903395f611f7c001597c599077db93a733396c7eccdca5b1759523a32`.
