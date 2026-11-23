# Independent review of combined odd/even height costs

2026-11-11. **PASS for conditional schedule metadata; no correction requested.** The combined profile, both baseline comparisons, all auxiliary rows and the unchanged-parameter P27 counts reproduce independently. The result is an operation inventory, not a combined analytic theorem, finite-RH certificate or runtime estimate.

## Pins and method

Reviewed author `../major-constants/COMBINED_ODD_EVEN_HEIGHT_CONDITIONAL_COST_2026-11-11.md`, SHA256 `6143FA8444ED97084998D769E114DCAB3DC2C12DCAF9649C32CFA1989658487C`.

Author script `../major-constants/combined_odd_even_height_inventory_20261111.py`, SHA256 `4C1B0FA0DA303A5EE475493A8CE66EB3723B3C9DFD9369DF9687069AF3F3E154`; same-stem JSON, SHA256 `BCBAA29AE9A963A46170C5B7B355C0399EE6A622EDBE355ECD24BFE92042C2EE`.

Independent script `review_combined_odd_even_cost_20261111.py`, SHA256 `744F4B013CE274B7AFCDEE745B1C6DE776F39B748150E6BFFA42372A506146A6`; same-stem receipt, SHA256 `D592BB5D548354242EB6B921CFDAC2CA4C79D645C923D4B7E2B667D6564B2E7B`.

I read the complete author note and script and the defining domains/formulas of its two component profiles. The independent reconstruction reuses only the pinned definitions and P27 ledger from my own `review_coupled_plus_cost_20261111.py`, SHA256 `9AA5978290D0B42541C4E1160BF002D712A5457D0CC362153D2E85E6DFC6E8F9`. It does not import or execute author code. That earlier independent code supplies the arithmetic sieve, stagewise radix-two counts, divisor-based special-twiddle counts and fixed-order retained-output circuit. The new code derives all three height profiles by exact integer ceilings and checks every displayed comparison against the frozen receipts.

It passed 251068 checks. No root, transform, L-function, zero, prime candidate or elementary-function value was evaluated. No build or frozen-file modification occurred.

## Exact profile and domain

The priced family remains odd `10000<c<=132900` or `4|c` with `10000<c<=265800`. The new profile uses

    odd:  200+ceil(max(240,19.2*3.1416*531600/c)),
    4|c:  200+ceil(max(255,19.1*3.1416*1063200/c)).

These are exactly the large-conductor branches in the pinned odd profile `C4EE2B2F674F6376D987C778FC7886A03A93BC81E61C0BC56D0B1C25E2E4A14D` and even profile `D3408AA27763D7E3C475E7B27DB124FDE9C16EDC916CEE061563B31D9A2DD88B`. Adding the integer 200 before or after the ceiling is equivalent. The separate second ceiling `J=ceil(64H/5)+1` is retained.

For every priced conductor, I checked that the explicit maximum with the reduced base-gap and star heights leaves H unchanged and that `Hcombined<=H4<=HTplus`. The same inequalities hold for grid prefixes. This checks the metadata domain; it does not replace the separate analytic consumer join. In particular the even Gauss-support argument belongs to the source proof, not to the fact that this inventory has fewer nodes.

The family still has 125400 conductors, 4333246843 primitive labels and 7133015232 unit-residue inputs per common height. The excluded small and principal branches are identical to the prior inventory. Their costs are neither erased nor included in the reported savings.

The two baselines are H4 and the earlier current Tplus profile. Neither is the original Platt-height schedule. The reconstruction matches both full main inventories and all four baseline P27 scenarios before comparing the candidate.

## Circuit, extensions and ratios

Every conductor retains the same ordered unit-group axes, primitive-output restrictions and mixed-radix circuit. Bluestein leaves retain their full padded inverse transforms. No different ordering, precision, kernel, or pruning assumption enters the new count.

The new main inventory is:

| Category | Count |
|---|---:|
| Conductor-height nodes | 1522865397 |
| Residue inputs | 59962061953248 |
| Primitive outputs | 36290898519503 |
| General complex products | 1004103686197888 |
| Complex additions | 2079886046397995 |
| Quarter turns | 92117812144056 |
| Negations | 19872754128 |
| Dyadic scalings | 88576420247296 |

All values agree with the frozen receipt. Extensions 167, 320 and 640 add that many copies of the unchanged per-height inventory. The code verifies the exact ratios and directed millionth brackets against both equally extended baselines. The main general-product ratio lies in `[.988148,.988149]` against H4 and `[.895780,.895781]` against current Tplus. At +640 these intervals become `[.988999,.989000]` and `[.902611,.902612]`.

Candidate+d need not be a prefix of an unextended baseline. The counts exceeding H4 main are 88193, 109037 and 121093; those exceeding Tplus main are 16002, 39520 and 51450. These match independently. Candidate+d remains a prefix of each baseline+d. The report correctly distinguishes those statements.

The main grid can overshoot its integer H by at most 1/16. Extensions measure length from that grid endpoint, not silently from H. Their lengths `835/64`, 25 and 50 are exact. None is certified sufficient for an actual sign/Turing outcome by this inventory.

Nineteen P20 Horner stages per residue are retained. I checked all three reported real-product/addition alternatives from their exact complex counts. The alternatives preserve their distinct cached-coefficient, width, rounding and preparation obligations. Their arithmetic categories are not equal-duration operations.

## Old seed parameters are retained

The maximum main height is 6578 at conductor 10004, with J=84200. The four global prefix lengths are 84200, 84367, 84520 and 84840. Their final heights are respectively `420995/64`, `210915/32`, `422595/64` and `424195/64`. Since every conductor grid starts at zero, each seed request is exactly the corresponding common prefix.

Every row retains the old final band `(V,D,N)=(10000,8192,3387)`. The first four bands contain 6401, 6400, 12800 and 38400 heights; the final band contains 20199, 20366, 20519 or 20839. The fact that the largest actual height is below 7000 is not used to reduce N here. The separate V7000 retune is excluded both in the report and in the receipt's explicit flag.

I compared every reconstructed band record and total, including twenty coefficients at the final coarse endpoint. At main height the source coefficient count is 9689335840, reciprocal scales are 22183711078363, head additions are 23036970463732, and fine-state updates are 853442953959. The complete receipt verifies all four scenarios for source slots, head operations, E recurrence, both Bernoulli categories, midpoint shifts, deliveries, shared R stages, anchor instances, initialization and conversion categories. The main head-addition ratio is in `[.947550,.947551]` against H4 and `[.631466,.631467]` against current Tplus.

Initialization is still paid once for all 27754497 arguments, not once per height and not zero times. Every height/argument pair still pays a separate state-to-EM conversion; the lower-precision copy does not replace the fine recurrence state. All scenarios reach the original fifth band's entire argument set, so the original log setup, endpoint 3389, precisions and raw state-capacity requirements remain.

## Setup and the remaining cost boundary

I verified exact equality of setup and exclusions with the earlier pinned inventory. The prior independent setup reconstruction remains applicable because the family and all circuit choices are unchanged. It has 12496 top axes, 32942 active nodes, 6004 Bluestein kernels, 337702368 kernel entries, 140276846 chirp entries and maximum padding 262144. Forward-kernel construction still costs 2244782056 general products and 5502647200 additions; the CT root-table upper count is 1116142487. Shared seed setup still includes 582822471 nonanchor log stages and the separate anchor and elementary witnesses. Zero *additional* setup at unchanged precision does not mean zero setup.

The counts support a conditional comparison of this combined large-branch schedule. The complete odd/even/base-gap/star analytic assembly, actual finite spectra, sign and zero-count certificates, interpolation, failures and repairs, small/principal branches, ordinary-axiom implementations, serialization and finite Goldbach coverage remain separate obligations. No wall-time reduction or complete computational optimum follows from this review.
