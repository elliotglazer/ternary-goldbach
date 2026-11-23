# SourceStateBounds accepted with corrected integer initializer

boundsint01 rebuilt the theory against SourceArithmetic sourceint01, whose initializer now returns (int # int) option. This module's source and fixed audit are byte-identical to their archived pre-correction versions. No theorem or definition in this module changed.

The actual raw state has error below 2^-96 through 90000 updates, conditional on the specified initial and step accuracy and exact target contracts. The finite-prefix bootstrap retains the multiplicative error term.

All 3 original exact audit roots passed their conclusion, hypothesis, import-tag and standard HOL ancestry checks. The corrected producer's independently recorded output bindings were also rehashed. The manifests checked in this review contain 11 expected-source entries, 6 run-source entries, 49 dependency/tool entries and 3 output entries; all match. The construction log confirms an actual theory rebuild. All three phases and the container exited zero.

Successful phases consumed 31.84 CPU seconds; container wall time was 123.0586378 seconds. These are construction and reload costs, not source throughput. This is a recorded-result/reload review, not an independent whole-kernel replay.

The earlier accepted report, source, audit and compiled theory objects are preserved under history/before_integer_initializer. That report's old bindings are historical. This record supersedes the temporary pending-revalidation notice.

The SourceInitial complex initializer connection, logarithm/exponential step, actual analytic sources and complete source/sign/count blocks remain separate obligations. No aggregate forecast credit is assigned. The full goal stays active. No process remains running for boundsint01.

## Accepted bindings

- SourceStateBoundsScript.sml: 2f61ad317295da157d033b194af670319b39e469beb86b28304ba8b081db5e49
- state_bounds_audit.sml: c46255ff3a70135e98b9de1d614465360ab18aab8ca2a177eca39b98309710ac
- source_expected.sha256: 3a409de0da7746811d6cba616242f4ef9218da9548f509de9de7f6bb30f9f498
- .hol/objs/SourceStateBoundsTheory.uo: 75606397c24864ecfd1759fcf9b2b32c68f48b9cf8af9380fb6ceaf8ab68e000
- .hol/objs/SourceStateBoundsTheory.dat: 58cdbb3935cbf56970504d15dbf4c6b7cddf4138c516a3c80dc6eba729478608
- boundsint01_audit.log: a943f2e54e7a4171f0099a6e1aa115e42216ac97950b27ea4da15a7517d144fe
