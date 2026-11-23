# Normalize the generated row before extensionality

Refinement04 passed both generic flatten lookup lemmas, then stopped while reconstructing a rectangular list. Flatdiag01 showed that the outer GENLIST_EL step left a lambda application around the generated inner row. Flatdiag02 beta-reduces that application before matching the inner GENLIST_EL rule and closes the exact full ft_concat/tx_flatten theorem with no hypotheses.

That ordinary beta conversion is now in the source. The original functions, theorem statements and shape premises are unchanged. Previous source, failed receipts, saved state and diagnostic sources are preserved under history/refinement04_row_beta and the diagnostic archives. Complete construction and the six-root reload audit remain necessary.
