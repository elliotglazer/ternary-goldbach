# Separate shape unfolding from arithmetic normalization

Traversal04 normalized SUC to addition before GENLIST_CONS could expose the two input heads. The pair proof now first performs the original shape rewrites, then normalizes the successor arithmetic on the resulting tails. This preserves the exact statement and function definitions. The failed source and receipts are archived under history/traversal04_pair_rewrite_order.
