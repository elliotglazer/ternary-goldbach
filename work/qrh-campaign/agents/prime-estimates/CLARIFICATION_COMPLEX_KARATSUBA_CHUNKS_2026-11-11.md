# Chunk-schedule accounting clarification

This clarifies `EFFICIENCY_COMPLEX_KARATSUBA_2026-11-11.md`, SHA256 86D8A9435A9962CFF95194642E590D65C76B334E5AD24377959006E7AB17BEFF, without editing it. Independent reviewer statement_audit identified an ambiguity in section 2's phrase “sufficient product schedules.”

The chunk expression r*(G(b)+A(2b)) counts the block product and carry-addition skeleton only. Its excluded term D_chunk must also include the ordinary-PA initial, row-invariant/algebra and final applications, the zero-short-factor case, the checked low/high extraction, and final reassembly, not merely representation handling. It is not a complete event count for a product proof. The carry<short_factor argument establishes mathematical sufficiency once these omitted proofs are supplied, and does not make their applications free.

Accordingly the minimum R compares displayed skeletons with schedule-dependent omitted terms. A selected skeleton is not automatically the smallest complete proof. All signed and rounding exclusions remain. This clarification changes no recurrence, numerical output or claimed runtime conclusion. No value evaluation or build was performed.
