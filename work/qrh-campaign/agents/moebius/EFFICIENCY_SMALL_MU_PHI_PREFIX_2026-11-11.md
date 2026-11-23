# SmallMuPhi prefix reuse and finite-arithmetic cost

Source-only research, 2026-11-11. No build, arithmetic evaluator, prime computation, or source modification was performed. This note distinguishes the existing proof bodies from a proposed module split and from a new ordinary-MM0 implementation. It is not an elaborated axiom-closure audit.

## Result

A lower mass bound at `R = 1000*m`, with `m <= 150`, mathematically needs only `c_0`, the first `m` walk certificates, their prefix joins, and the lower half of `S_approx`. It does **not** need `c_150`. However, importing the present `SmallMuPhi` module still requires compiling its entire source when its compiled artifact is unavailable. More subtly, cutting its text at `c_m` would retain **all 150 numerical walk proofs**, because all `w_i` precede all `c_i`.

The original major-arc route still uses the 150,000 bound. `L2Major:339` consumes both sides, and `MajorTotal:1025` independently consumes its upper side. A smaller new lower cutoff therefore does not by itself eliminate the last blocks from the complete existing build. `LSQuot8` has a different avoidable dependency: it needs only `phiTD` and its correctness theorem, but imports the full numerical module.

## What the source actually computes

Paths below are relative to `work/ternary-goldbach/`.

`TernaryGoldbach/Prelim/SmallMuPhi.lean:17–100` defines trial division `phiTD` and proves `phiTD_spec`. Its three outcomes distinguish exhausted fuel, a nonsquarefree input, and a squarefree input with its totient. The invariant says every prime divisor of the remaining odd integer is at least the current odd trial divisor `d`. The recursion tests all successive odd `d`, not merely a supplied prime list. A repeated divisor proves nonsquarefreeness. A single divisor is proved prime from the invariant and minimum-prime-factor facts; the proof then uses coprimality, squarefree multiplication and totient multiplication. The terminal inequality `m < d*d` proves the remaining `m > 1` prime. The `m = 1` case returns totient one.

`Lt`, at line 102, is the exact natural-number sum

`sum_{1 <= q <= K, q odd and squarefree} floor(10^18 / phi(q))`.

It is **not** the exact rational sum `S(K)`. `walkS`, lines 110–119, processes every integer in its interval, skips evens, applies `phiTD` to odd integers, and adds the natural quotient on success. It checks `L <= 10^20` before each nonterminal step. `walkS_spec:128` links a successful walk starting at `Lt(q)` to `Lt(q+len)`. Fuel failure or a failed guard cannot certify a block.

`S:160` is the real sum of `1/phi(q)` over odd squarefree `q <= K`. `S_approx:163` proves

`Lt(K) <= 10^18*S(K) <= Lt(K)+K`.

The proof uses positive totients and the two elementary floor-division inequalities term by term. The upper slack charges at most one per integer, including integers that contribute zero.

`w_0` through `w_149`, lines 201–350, each prove a literal length-1000 walk by `decide +kernel`. They contain literal starting and ending states. Each numerical proof is independent of preceding `w_i` declarations. The `c_i`, lines 352–503, subsequently establish the starting-state meanings by a linear chain of `walkS_spec`, `c_(i-1)`, and `w_(i-1)`. `sum_bounds:506` uses `c_150` and both halves of `S_approx` to obtain `6.798779 <= S(150000) <= 6.79878`.

This source uses kernel reduction, not `native_decide`, for those block facts. Reading that syntax does not replace compiling it or checking the elaborated dependency closure.

## Which finite facts a changed cutoff needs

For `R=1000*m`, the literal in `c_m` supplies an integer `L_m`; the lower conclusion is `S(R) >= L_m/10^18`. `SumMuPhi:49–66` proves the odd/even squarefree-totient pairing. Its finite-sum assembly at lines 69–106 specializes the resulting identity to 150,000. A new general-cutoff assembly would give twice the odd sum for the same `Qset` convention. It must be proved for that convention, not inferred by changing a numeral in a theorem type.

For a nongrid cutoff, positivity gives the weaker lower bound from the preceding complete grid point. Obtaining the exact new `Lt` value additionally needs a successful partial walk. Neither choice requires the subsequent complete blocks. No new value is calculated here.

The remaining existing consumers are concrete:

| Consumer | Actual requirement |
| --- | --- |
| `MajorArcs/SumMuPhi:32–47,108–112` | Both 150,000 bounds, via `SmallMuPhi.sum_bounds` |
| `MajorArcs/L2Major:309–348` | Both bounds in `l2_major_bounds`, with `r0 = 150000` |
| `MajorArcs/MajorTotal:1020–1044` | The L2 upper bound and, separately, `sum_Qset_mPhi_bounds.2` |
| `MinorArcs/PartIICited:64–67` | Both L2 sides through `l2_major_14_7` |
| `MinorArcs/LSQuot8:19,206–234` | Only `phiTD` and `phiTD_spec`; its own `phiAll` handles even inputs by removing one factor two or rejecting a factor four |

`Helfgott/Inputs:7,91` imports and applies the original `MajorTotal`. These observations concern the existing source route. They do not assert that a future rewritten root must retain its original 150,000 mass theorem. If that upper bound is retained by monotonicity for a smaller cutoff, its computation is still retained too.

## A split that would realize the narrower dependency

This is a proposed future change, not an implemented or approved declaration set.

1. Put `phiTD` and its elementary correctness lemmas in a small shared core. `LSQuot8` can consume that core without the mass certificates.
2. Put `Lt`, `walkS`, `walkS_spec`, `S` and `S_approx` in a sum core above it.
3. Put numerical walk blocks in bounded chunks importing the sum core. Assemble the required prefix separately. Keep the original full-150 assembly available for consumers that still need it.
4. Separate the generic `Qset` pairing and mass algebra from the numerical 150,000 instantiation. Route an alternative root only through the prefix it actually uses.

Do not create 150 files automatically: chunk size trades numerical parallelism against module loading and metadata overhead. All block proofs have independent literal inputs, while the simple prefix joins have a linear dependency. Sharing the core avoids recomputing or duplicating its proof in each chunk. Narrowing the current `import Mathlib` is a separate dependency-audit task, with no savings claimed here.

For a clean targeted build, write its cost as `C_core + sum_{i < m} C_walk(i) + C_join(m) + C_mass`. The current monolithic import instead pays the walk sum through 149. For `m=138`, twelve blocks disappear only after a real dependency split and only if no selected consumer requires them. That is 8% of block **count**, not 8% of runtime, proof bytes, or total project work. Later inputs have different trial-division costs. With an already valid compiled module, an importing consumer does not rerun all its `decide` proofs; it loads the module artifact. A broad build that also targets the retained full-150 module still pays for the tail somewhere. No build timing or artifact-size reduction is established.

## Ordinary-MM0 obligations and a lower-only alternative

An ordinary-MM0 proof cannot import the truth of a Lean numeral equality for free. Reusing its literal states is candidate reuse. Acceptance must reconstruct the needed arithmetic implication in the selected arithmetic library.

An exact reproduction can prove a finite checker corresponding to `phiTD` and `walkS`, then check every branch, division, product, state transition, interval endpoint and final literal. Division witnesses need nonnegative remainders less than the positive divisor. Trial-division rejection and the terminal-prime argument need the same completeness invariant as the Lean proof. Finite blocks must cover the whole claimed interval without gaps or duplication. The shared number-theoretic checker and the integer-to-rational floor sandwich are proof costs, not uncharged host code. A factorization-based replacement may be cheaper, but every used prime factor needs an accepted primality proof or a genuinely established shared prime table.

For the **lower bound alone**, a different sound certificate can omit the classification of unused integers. Supply a distinct finite set `A` of odd integers in `[1,R]`, prove each squarefree with exact totient `t_q > 0`, and check nonnegative integers `a_q` with `a_q*t_q <= 10^18`. Then

`sum_A a_q / 10^18 <= sum_A 1/t_q <= S(R)`.

A sorted list or an equivalent checked set representation must establish distinctness and range. Omitted terms are nonnegative; they need no nonsquarefreeness proof. One may also underapproximate some reciprocals deliberately. This certifies a lower bound, not `Lt(R)` equality, and it cannot supply the original upper bound. Its adequacy for a particular cutoff requires checking its actual total against that cutoff's required mass; no such new certificate or total was generated here.

Compare implementations with all terms charged:

`C_exact = C_checker + C_all-branches + C_division + C_accumulation + C_mass-transfer`,

`C_subset = C_subset-distinct/range + C_factor-and-prime-proofs + C_totients + C_product-inequalities + C_accumulation + C_mass-transfer`.

Shared factor proofs reduce the second term only if those proofs are actually available and their import or recheck is counted. The present trial routine has an elementary worst-case odd-divisor traversal of order `sqrt(q)` per odd input; its real branch count was not measured. There is no justified winner in MM0 without a bounded checker/certificate benchmark. The immediate safe architectural gain is removing the numerical mass module from `LSQuot8`'s core dependency, not treating the existing Lean proof as a free cross-system certificate.

## Source pins

SHA256, relative to `work/ternary-goldbach/`:

| File | SHA256 |
| --- | --- |
| `TernaryGoldbach/Prelim/SmallMuPhi.lean` | `7ECE1D48D9679ECF529A5566C79D06FADB3CA70CCAF057ADAA020D6AA390BADF` |
| `TernaryGoldbach/MajorArcs/SumMuPhi.lean` | `7AC4662598355DDA40720B43956223BD3C5456D503B206A77D48E4569ADE18A4` |
| `TernaryGoldbach/MajorArcs/L2Major.lean` | `8C9424D92074ABB35DF00273D598F5A3F95C49A34F07F4146DD83FD2B6F3A5FC` |
| `TernaryGoldbach/MajorArcs/MajorTotal.lean` | `106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A` |
| `TernaryGoldbach/MinorArcs/LSQuot8.lean` | `2719F2806473079FA6FD1E30C4E1D4FB35CDB8463906D3BE111A67BF2FCAD8A3` |
| `TernaryGoldbach/MinorArcs/PartIICited.lean` | `0447F5A3D00DBB6B11CEA1A729FA4CCA2FEF993A8242574D2241A33195B14D30` |
| `TernaryGoldbach/Helfgott/Inputs.lean` | `5680D400F0A1795B984BBDFFA863DBF4F721576B3BE673155E0883F0C5D64B83` |
| `lakefile.lean` | `34BA27A0D5F124639C732F2BA2A02AED15717210EA1E3029EE919EC1FC0D52E4` |

The Lake file declares the default `TernaryGoldbach` library and Mathlib v4.35.0. This report does not claim a particular unexecuted Lake command builds only a prefix, nor validate the whole imported source closure. Inspection used file reads, hashes and source-reference searches only.
