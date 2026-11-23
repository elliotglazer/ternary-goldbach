# Bind separately parsed lengths to the concrete row type

Rectdiag01 exposed the transpose failure: Q.SPECL parsed LENGTH rows separately from the later function argument. The former rows retained a fresh polymorphic element type, while the latter rows had the concrete integer-pair matrix type. Their printed names looked identical, but typed first-order reconstruction correctly rejected the equality transport.

Rectdiag02 annotates that length's rows as (int # int) list list and closes the exact original transpose theorem with no hypotheses. The same annotation is now present in both separately quoted LENGTH rows arguments in the refinement source, including concatenation. No function or public theorem statement changes. The full source build and six-root audit remain required. Prior source, receipts, diagnostic sources and the saved state are archived under history/refinement02_typed_length and history/rectdiag01_sources.
