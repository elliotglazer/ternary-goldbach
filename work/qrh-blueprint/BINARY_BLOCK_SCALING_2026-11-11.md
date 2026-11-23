# Binary block size is independent of the ternary ladder spacing

2026-11-11. Exact size calculations and a research decision, not a new prime table, checker or runtime forecast.

After choosing a smaller binary cutoff B, optimize its internal block length L separately. L is a number of even targets per binary-certificate block. It is not the ternary prime-ladder gap, and increasing L does not require increasing B.

The existing sparse-anchor design uses a shared source-prime bitmap for odd numbers 2j+1, with 0<=j<L+D, and selected certified anchor primes

    q_(r,i)=2*r*L-(2*s_(r,i)+1),  0<=s_(r,i)<=D.

For target n=2(rL+t), the source bit j=t+s supplies the prime p=2(t+s)+1, giving n=p+q exactly. A block proof checks a union of shifted source masks. Every positive source bit and anchor still needs a genuine prime proof; no completeness claim for the source prime set is needed if coverage succeeds.

Let E=B/2 and assume B even and E>=L. There are R=floor(E/L) outer blocks, r=1,...,R. Their widths are min(L,E-rL+1). The first range 4<=n<2L has L-2 even targets and needs a separate recursive or direct proof. If E is a multiple of L, the final block has width one, not zero. The exact count is

    (L-2) + (R-1)*L + (E-R*L+1) = E-1.

This identity prevents a larger L from appearing to save work merely by omitting its larger initial range.

## Concrete memory/certificate frontier at B=1e16

Use D=2^19 as a permitted offset bound and reserve A=512 anchors per full or partial block for planning only. No theorem guarantees 512 suffice. The local coverage tile width in the last column is W=2^18. Counts were calculated by exact integer arithmetic; the interval-count identity above passed for every row.

| L | Source bitmap bytes | Outer blocks | Nominal anchor records | Top-level coverage tiles |
|---:|---:|---:|---:|---:|
| 2^32 | 536,936,448 | 1,164,153 | 596,046,336 | 19,073,469,945 |
| 2^34 | 2,147,549,184 | 291,038 | 149,011,456 | 19,073,420,793 |
| 2^36 | 8,590,000,128 | 72,759 | 37,252,608 | 19,073,224,185 |
| 2^38 | 34,359,803,904 | 18,189 | 9,312,768 | 19,072,437,753 |
| 2^40 | 137,439,019,008 | 4,547 | 2,328,064 | 19,069,292,025 |

The source bitmap represents odd numbers through 2L+2D-1. Its byte count excludes proof metadata, anchors, coverage accumulators and arithmetic temporaries. The tile counts exclude the initial recursive proof, which remains an obligation. The small apparent tile reduction is that shifted obligation, not a genuine deletion of targets.

Moving from L=2^32 to 2^36 reduces the nominal anchor count by about a factor of 16 and increases source bitmap storage by about the same factor. It scarcely changes the number of targets whose coverage must be checked. Larger source numbers may need more masks to cover a tile, so coverage time cannot be held fixed without evidence.

## Implementation and cost implications

For measured total costs, compare

    C(L) = C_source(L+D) + C_initial(2L)
         + sum over outer blocks C_anchor_pool(block)
         + sum over coverage tiles C_cover(tile)
         + C_provenance_and_assembly.

The anchor-pool term includes unsuccessful candidate searches, successful certificates and any extra anchors needed for exceptional targets. The coverage term includes actual source extraction and interpretation, rather than timing an arithmetic equality against unexplained literals. Both costs depend on L. The permitted D bound and the actual largest chosen offset are different quantities; packed multiplication must price the actual halo/polynomial size rather than assume the small offsets of earlier fixtures.

A larger table can be streamed in tiles with a D-wide halo. To keep this useful, reuse each certified source segment across the selected outer blocks before discarding it. Re-sieving the complete source for every outer block would destroy the intended saving. Independently retain the certified factor-prime cache needed by anchor certificates; a discarded source segment is not a future free prime lookup.

The roughly 19 billion top-level coverage tiles also rule out treating a fresh global Lean declaration per tile as an innocuous default. A generic block-checker soundness theorem should consume internal tile checks and expose a bounded number of range theorems. The concrete checks still cost computation. Similarly, MM0 sharing or compressed proof templates must retain checked source indices, prime provenance and final interval coverage; a short manifest cannot stand in for those proofs.

This is a proof architecture requirement, not a claim that either current implementation already supports the complete scale. A reflective Lean checker and an MM0 implementation may need different chunk sizes. A foundation-preserving specialized verifier is a separate acceptance implementation and must be identified and costed as such.

## Research priority

Compare complete blocks at L=2^32,2^34,2^36 first, for each promising B from the mixed-ladder work. These choices expose a 16-fold anchor-certificate tradeoff without immediately requiring a table larger than ordinary workstation memory. Include source-table certification and a boundary/base-case proof in the design. Keep L=2^38 and 2^40 as streamed alternatives if anchor work dominates after optimizing its primality certificates.

Do not transplant the old full Lucas-Pratt per-root time to optimized partial-Pocklington certificates. The earlier native partial-Pocklington results and the Lean full-root results describe different implementations and acceptance boundaries. The purpose of this frontier is to compare complete costs on the same basis, not combine the fastest component from each incompatible model.

Supporting prior work: [sparse-anchor and streaming design](../mm0-efficient/SCOPE.md), [formal certificate architecture](../formal-goldbach-bench/architecture.md), [component measurements and their limitations](../formal-goldbach-bench/FORECAST.md), and [mixed ternary-ladder frontier](HYBRID_LADDER_COST_FRONTIER_2026-11-11.md). No new build, prime computation or timing measurement was performed here.
