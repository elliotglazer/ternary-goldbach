# Complete finite interval comparison in HOL4

The concrete HOL theorem proves that every even natural number in
`[3999999997356537860, 3999999997356539908)` is the sum of two primes.
Its exact conclusion is checked against those literal endpoints before
export. It has no hypotheses. This is the same 1,024-target interval as the
stock-Lean proof in `../finite-lean/REPORT.md`.

The HOL implementation proves all 393 source and anchor primes from the
same 1,537-node Lucas certificate graph. A balanced tree collects the proved
primes. The coverage checker verifies an explicit pair for each target,
including both tree lookups and the exact sum. `FiniteCoverScript.sml` proves
that acceptance implies the full interval statement, with its length,
parity and endpoints. Tree ordering is not a soundness assumption: a successful
lookup always reaches the exact matching value, and a failed lookup rejects.

Three fresh runs of the balanced implementation pass. Each passes the usual
four-axiom HOL ancestry audit, the empty-hypothesis and exact-conclusion
checks, four corrupted-coverage controls and export. All three exported
theory files are identical. The separate matching-primality benchmark also
passes its three corrupted-certificate controls in three fresh runs.

## Costs and the representation change

| Phase | Balanced layout, median CPU seconds |
|---|---:|
| Construct and accept all prime certificates | 8.849970 |
| Assemble the prime tree | 0.003273 |
| Translate the tree and witness data | 1.447863 |
| Check all 1,024 target witnesses | 0.021964 |
| Assemble the exact interval theorem | 0.012931 |
| Export the completed theory | 0.850922 |

The median sum of the measured phases is 11.075 CPU seconds. The median whole
process takes 18.27 CPU seconds, including startup, imports, data construction,
controls and export. Phase medians need not sum to the median whole-run phase
total. Peak resident memory across the balanced runs is about 530 MiB.

The corrected flat-list baseline also proves the complete theorem and passes
all controls. Its data translation costs 130.737 CPU seconds and the whole
process costs 148.52 CPU seconds, with 4,172,900 KiB peak resident memory.
The first flat-list attempt had measured 58.374 CPU seconds for the same
translation phase, then encountered an unrelated infinite repetition in
the final normalization code. That process was stopped. Explicit checked
endpoint equalities replace the faulty normalization in both successful
implementations.

Splitting the witness data into small definitions joined by a balanced append
tree preserves the acceptance predicate and final theorem. It reduces the
measured translation phase from tens to hundreds of seconds to about 1.45
seconds. The completed flat run is about 90 times slower in that phase; the
earlier partial run suggests about 40 times. The baseline variation prevents
claiming a precise universal multiplier. Coverage itself is cheap in both
layouts, about 15–26 milliseconds.

## What the comparison establishes

This closes the semantic gap between merely checking prime certificates and
proving the entire bounded Goldbach statement. It also demonstrates a large
input-representation cost that a complete cost estimate must include.

Lean's bitmap equality takes about 3.5 milliseconds, while this HOL witness
check takes about 22 milliseconds. Primality still dominates both small
complete certificates. HOL's earlier high-precision arithmetic advantage
cannot be applied uniformly to this workload. The Lean measurement replays
already constructed expressions, whereas the HOL phases include ordinary
proof reconstruction and evaluator acceptance. Their process totals also
use different timing protocols; they are not a universal speed ranking.

The next experiment is a proved checker for the whole prime-certificate graph
inside one evaluator call. `BATCH_PLAN.md` records its exact obligations.
No saving from that unmeasured design is included here.

## Trust, scope and reproduction

The context uses HOL4's infinity, choice, eta and Boolean-cases axioms. This
is a standard HOL result, not a three-axiom Lean theorem or an ordinary PA
MM0 certificate. All candidate data are untrusted; the final HOL theorem
depends on the checked prime certificates and coverage computation.

`COVER_RESULTS.json` retains all samples, source hashes, phase/process costs
and output identities. `summarize_cover.py` validates completed logs, exact
endpoints and controls before writing it. `generate_cover.py` uses the Lean
fixture to propose witnesses. `generate_balanced.py` changes only their
definition layout. `build_cover_benchmark.sh` and `run_cover_samples.sh` retain
the exact bounded commands and outputs. The successful flat baseline is
`cover_run2`; balanced runs are `cover_runb1`, `cover_runb2`, `cover_runb3`.

Library and executable builds are separately recorded in their `.time` files.
They are outside the runtime phase totals. These results cover one small
interval near 4e18. Full binary coverage, the dense prime ladder, spectral
certificates, cross-system acceptance and end-to-end TG forecasts remain
separate obligations.
