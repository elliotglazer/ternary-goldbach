# Explicit natural index and radix result types

Tx01 stopped while defining tx_action. The source intentionally prefers signed integers for coordinate arithmetic, but the unconstrained result numerals in tx_slot had therefore acquired type int. tx_cache_row requires a natural index. tx_radix has the same unconstrained-result pattern and is consumed by natural dimension arithmetic.

The successor explicitly annotates the results of tx_slot and tx_radix as num. Their branch bodies, index choices and radix choices are unchanged. This implements the natural index/dimension meaning in the independent arithmetic/order review. No complex arithmetic, rounding, root guard, finite domain or theorem statement is weakened. The original source, manifest and complete failed receipts remain under history/tx01_natural_indices.

Successor source SHA256: `d369e0e10c0d51a8c8de73f828bb68c029f3409f9bde0ffff646decab12aabb6`.
Only its source entry changes in SOURCE_MANIFEST.sha256; runner, tests and audit remain unchanged.
