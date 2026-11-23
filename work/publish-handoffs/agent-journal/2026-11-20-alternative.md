# alternative — 2026-11-20

## 16:57:26 UTC · Final

The [alternatives report](../../../work/grh-goldbach-20261120/team/alternatives.md) identifies three routes to \(10^{27}\). The quickest to reuse is a previously kernel-checked ladder requiring binary Goldbach through \(3\times10^{17}\). A proposed denser ladder reduces that bound to \(10^{16}\) and avoids Schoenfeld, but needs about 100 billion new rung certificates. Dudek’s formalization reduces the bound to \(2.51\times10^{15}\) if its quantitative zeta zero-count hypothesis can be proved. I inspected the sources and historical logs. The denser ladder’s throughput still needs a kernel benchmark.

## 17:09:57 UTC · Final

Lean verified that at most 64 integer bases per exponent contribute in the Gaussian window and that their total weighted proper-power mass is at most 362,880 across \(10^{15}\le x\le10^{27}\). Both theorems use exactly the three standard Lean axioms. [Proof](../../../work/grh-goldbach-20261120/team/local-powers/LocalPowers.lean) · [Axiom audit](../../../work/grh-goldbach-20261120/team/local-powers/audit01.log)

## 18:12:31 UTC · Final

The main term, middle and high zero contributions, vertical contour, prime extraction, and finite ternary transfer all passed Lean’s kernel check using only `propext`, `Classical.choice`, and `Quot.sound`. The four successful assembly checks took **97.2 CPU seconds**. [Bounds and receipts](./work/grh-goldbach-20261120/team/local-assembly/README.md)

The checked transfer shows that **binary Goldbach through \(4\times10^{15}\)** and the proposed prime interval suffice for **ternary Goldbach through \(10^{27}\)**. The interval’s deduction from RH has been written. Its integrated kernel check is queued behind the shared upstream build. The binary certificate remains outstanding. [Prime interval and finite ternary theorem](./work/grh-goldbach-20261120/team/local-assembly/PrimeInterval.lean)

## 18:23:30 UTC · Final

The real 262,144-target arithmetic measurements raise the Saturday forecast from **51,541 to 60,285 useful core-hours**, or about **$4,420 for workers**. That still fits the $6,000 worker allocation within the $10,000 total budget, provided the proposed batching works.

The allocation permits **31.85 ms of recurring work per tile**, or **522 seconds per full block**, after the shared prime table. Holding the other modeled costs fixed leaves **13.19 ms per tile** for Lean coverage beyond arithmetic. The measured small-shard proof assembly and its share of the join take **143.81 ms**. At that rate, one assembly operation must cover at least 11 production tiles even before charging imports.

The receipts rule out the current per-shard workflow at production scale. A complete block benchmark is still needed to establish that proof assembly, source expansions, and prime certificates can be reused enough to meet the budget. [Independent audit](../../../work/grh-goldbach-20261120/team/finite-cost/pilot-sanity.md)
