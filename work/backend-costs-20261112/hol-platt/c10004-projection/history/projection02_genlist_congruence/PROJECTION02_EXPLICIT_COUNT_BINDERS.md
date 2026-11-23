# Bind the flatten dimensions explicitly

Projection01 proved the first six lookup and local-projection helpers, then failed while parsing txp_flatten_at. The unbound name count resolves in this imported context as a function-valued constant rather than the intended natural dimension.

The successor explicitly universally binds k, count and width as natural numbers and f as the row generator. This states the intended general dimension lemma, without a new restriction or assumption. Its mathematical formula and proof are unchanged. All public projection targets remain unchanged. The failed source and receipts are preserved under history/projection01_count_binder.

Successor source SHA256: `7e994d0bd12e8282597f53b90d0b859173e30b2c3b3ade6291fdc7f474525ab2`.
