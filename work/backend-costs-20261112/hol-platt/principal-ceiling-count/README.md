# Principal ζ completeness through 100,000,000

The selected ordinary-RH consumer requires every nontrivial ζ zero with closed |Im ρ| ≤ 100,000,000 to have Re ρ = 1/2. The same predicate restricts to smaller heights. Its source audit traces the real consumers through ZetaZeroSums, PsiExplicit, PsiPlateau1e8, and the Mertens / prime-gap chain. The centered reciprocal moment and the exact count through 1,500 belong to an alternative route. [Consumer audit](../../forecast-audit-20261113/PRINCIPAL_COMPLETENESS.md)

## Native benchmark

shards.py fixes ten right endpoints and an eight-unit window before evaluating any counts or signs. It starts each window with grid spacing 1/2, doubles the resolution when the witness count falls short, reuses every previous sign, and stops upon saturation or at 1/128. The ceiling was piloted with check.py before fixing this ten-window suite. FLINT supplies the global positive counts at both endpoints and the Hardy signs via the trivial character of conductor one. A strict result at both endpoints and opposite signs across a cell give distinct interior lower witnesses under the usual real Hardy/ζ correspondence. The count difference includes multiplicities.

| Right endpoint | Count increment | Accepted spacing | Proposed cells on final grid | Retained sign brackets | Sign wall s | Two counts wall s |
| ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 100 | 4 | 1/2 | 16 | 4 | .001626 | .000328 |
| 1,000 | 7 | 1/2 | 16 | 7 | .003785 | .000688 |
| 10,000 | 9 | 1/2 | 16 | 9 | .013870 | .001001 |
| 100,000 | 13 | 1/4 | 32 | 13 | .014063 | .000885 |
| 1,000,000 | 16 | 1/8 | 64 | 16 | .029389 | .000964 |
| 10,000,000 | 18 | 1/4 | 32 | 18 | .020047 | .013869 |
| 25,000,000 | 20 | 1/4 | 32 | 20 | .032495 | .020904 |
| 50,000,000 | 21 | 1/8 | 64 | 21 | .089497 | .021926 |
| 75,000,000 | 20 | 1/8 | 64 | 20 | .102573 | .035480 |
| 100,000,000 | 22 | 1/16 | 128 | 22 | .246171 | .050226 |

Timing columns are medians over three in-process, single-thread, 80-bit repetitions of the exact distinct sites and endpoint counts. timing.csv includes individual wall and CPU measurements and the additional 128-bit repetition. At the ceiling the positive counts were 248,008,003 and 248,008,025. The first grid found 10 of 22, the next two each found 20, and the last found all 22. All 474 distinct sign evaluations were strict, including every endpoint. Of the 464 final-grid cells, 150 supplied the disjoint accepted witnesses. Counting all grid stages gives 768 tested cells and 311 changes including repeated evidence at subsequent resolutions. The larger precision confirmed every sign and count.

These disjoint windows cover 80 units of height and account for 150 of the 248,008,025 positive zeros in the native global ceiling count. The other 248,007,875 require lower witnesses or another valid proof. The mixed-height sample is sparse, and the adaptive costs vary with local close zeros. Applying the slowest observed ceiling shard uniformly to all heights is a sensitivity calculation, not an estimated distribution. One global upper count may serve all shards when the lower witnesses are assembled and checked for disjointness. The two local counts per shard are diagnostics in this experiment.

## Stock HOL4 analytic primitive

ZetaEtaSignScript.sml proves that for s>0 the sum over m≥0 of (2m+1)^(-s) − (2m+2)^(-s) is summable and strictly positive. It defines the powers by real exp and ln. The proof bounds each partial paired sum plus the next positive tail term by the first term, then invokes stock monotone bounded summability. It also proves the strict negativity of that sum divided by 1−exp((1−s)ln 2) for 0<s<1. The theorem has no analytic input assumptions about ζ. Instantiating a real-axis ζ nonvanishing result requires the analytic-continuation identity with this eta quotient for the ζ definition used by the final consumer.

Holmake exported the theory in eta02. The precision checks above are native FLINT evaluations. Formal transfer of their heights needs a Hardy/ζ zero equivalence and continuity, rigorous point enclosures, a certified upper-count theorem, and its seam, multiplicity and closed-boundary conventions. The constant cost of the eta proof gives no throughput measurement for high-height HOL Hardy evaluations.

Reproduce with Python-FLINT 0.9.0 and a single thread using shards.py followed by timing.py. shard-plan.json, shards.csv, shard-signs.tsv and timing.csv retain the exact schedule, failed refinements and enclosures.
