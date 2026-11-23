# Complete channel and produced-head accounting

The channel-3 count uses 17,883 retained slots in 1,331 rows. The cinv06 stock HOL replay extracted the original tile index, presence mask, witness mask, sign bits, count and raw words from 1,331 closed DiskThms propositions in sparse-stream/tiles. It matched the label and index of every proposition and used its exact terms to define source_3. ChannelInvariant.channel_3_all_lookups proves that loading the original HeadPairEven.raw_3 succeeds and every populated lookup encloses its source_code. The theorem channel_3_retained specializes the same result to any true-value function vs satisfying the two-unit bound at every populated source lookup. Earlier tile records carry coarse sign information. The concrete enclosure check recomputed the enclosure relation on all selected lookups, so its cost overlaps the distinct streamed project_ok experiment.

| cinv06 task | CPU seconds |
|---|---:|
| Reload archived tile terms | 7.630694 |
| Define source and encode original count input | 16.719722 |
| Convert the source with shared proofs | 0.152236 |
| Verify joins and save the conclusions | 2.189175 |
| Total worker | 26.691836 |
| Complete Holmake process | 77.82 |

RetainedTransfer.compressed_analytic_sign applies to the same sparse count table without a window scan. It additionally requires the actual interpolant bound and two-unit channel premise. For true values the raw error and true interpolation estimates must have compatible score scaling and indices. RadiusBudget.radius_real supplies the numeric slack from the original radius_ok.

For the generated-head route, produced04 proves ProducedHead.twoval_encloses for arbitrary signed two-stream inputs. Write z for the first rounded integer, s=floor(z/2) for its raw witness, and B=2^w. If s≥−2^255, the output digit d minus 2^(w−1) encloses s on the 2^e mesh. A conventional 256-bit stored raw code additionally requires s<2^255. PackedLoad.packed_row proves that natural digits d<B packed least significant first and listed in increasing set-bit order are decoded by the ordinary sparse loader at their original indices. The producer must demonstrate digit range, match its twosweep word to that order, and establish the two-unit analytic sample bound for its generated s. A pilot verifier compared all 71,325 generated witnesses with a 336-bit Arb direct finite DFT and found errors below .753 raw units. Its input semantics differ from the archived original raw code.

When the generated output packet is used directly, packed-head generation belongs to the upstream measured consumer, and row loading belongs to sparse-count checking. For the three-conductor stratum model the latter accounts for 26,731–27,387 core-hours. The distinct archived raw projection row amounts to 16,669–17,109 core-hours; a new deployment that supplies complete producer proofs and uses the shared packet need not replay this row. A data handoff that serializes and reloads proved intermediate objects must price its boundary. No incremental I/O rate for that deployment was measured here.
