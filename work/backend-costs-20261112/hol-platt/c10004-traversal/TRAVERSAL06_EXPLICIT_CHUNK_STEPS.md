# Separate chunk lengths, structure and index arithmetic

Traversal05 passed the adjacent-pair theorem, then the chunk proof exhausted the runtime stack. It recorded an Interrupt and exit 1 after 125.68 CPU seconds, with peak RSS 2100572 KiB. Root observed the container live at about 2 GiB, but it terminated before the attempted owned-container stop, which returned no such container. The preserved receipts therefore record natural proof-runtime failure, not a successful stop or proof result.

The successor adds chunk progress markers, proves the two length facts separately, uses MIN_EQ_LE instead of branching on MIN_DEF, performs structural rewrites with bool_ss, and normalizes indices in a separate final step. Explicit ADD_ASSOC is also removed from the unattempted concat proof to avoid competing with arithmetic normalization. The exact cause within the former combined simplifier is not established. All program definitions and theorem conclusions are unchanged.
