# Finite RH from a count deficit below two

2026-11-11. Independent source/paper derivation and completed author comparison. **PASS at bounded mathematical/source scope, without corrections.** Bound to `major-constants/TURING_SPECTRAL_SURPLUS_REDUCTION_2026-11-11.md`, SHA256 `6E7CD152D57679AFBEF754D9A1C0060AAA3F28C6E2DB1F6EFB4BD24A6B15C401`. No Lean declaration, build, spectral evaluation or frozen-file edit. This note does not claim implementation of the analytic adapters or a successful numerical packet.

## Exact implication

Let S be the complete finite carrier of nontrivial zeros of an actual primitive L-function in an ordinate range invariant under J(rho)=1-conj(rho). Attach each point its true positive integer analytic multiplicity m(rho). Let C=sum_S m. Suppose a certificate accounts for K units of multiplicity supported entirely on Re(rho)=1/2: its represented points are distinct, and its assigned weights do not exceed their true orders. Ordinary disjoint strict sign intervals give one unit each; certified exact or lower central orders can contribute further units without duplication.

Suppose C<=U and U<K+2. If an off-line rho were in S, then J(rho) would be a distinct member, with the same ordinate and multiplicity. Both are outside the critical-line support of K. Hence C>=K+m(rho)+m(J(rho))>=K+2, a contradiction. Thus all zeros in S are critical. No simplicity, complete main list, parity of C-K, or zero-spacing hypothesis is used. Merely knowing an arbitrary lower count K is insufficient: the critical-only support premise is essential.

The strict inequality cannot be weakened to U<=K+2 on this reasoning. An abstract off-line pair of multiplicity one has exactly two missing units. Conversely, successful U<K+2 allows C=K+1 and an unrepresented critical zero. It does not determine C, exclude critical boundary zeros, or prove a complete list. Exact-count, reciprocal-zero-sum, complete weighted-list and corresponding existing head-certificate consumers must retain exact saturation or separately bound every residual contribution.

## Actual source reflection and order

For primitive nonprincipal chi, let f_chi be Mathlib's completedLFunction, whose conductor factor is not the fully symmetric normalization. The actual functional equation is

    f_chi(1-s)=N^(s-1/2) W_chi f_invchi(s).

It is `IsPrimitive.completedLFunction_one_sub`, DirichletContinuation:283. The inverse is conjugation on character values by MulChar/Lemmas:73–79. Absolute convergence gives L_invchi(conj s)=conj(L_chi(s)) on Re(s)>1; holomorphy and uniqueness continue the conjugate-holomorphic identity. Equal parity, Gammaℝ_conj and the completed/usual adapter give the same identity for f. This conjugation adapter is a paper construction from the source APIs, not a claimed existing single Lean theorem.

Combining them yields

    f_chi(w)=N^(1/2-w) W_chi conj(f_chi(1-conj w)).

The factor is holomorphic and nonzero: N>0 and norm W_chi=1. If f_chi(rho+z) has first nonzero term a_m z^m, then at J(rho)+z the conjugated part has first term conj(a_m)(-z)^m. Multiplication by the nonvanishing factor preserves m. This is an actual analytic-order argument; J itself is antiholomorphic and must not be passed to a holomorphic composition theorem as if it were holomorphic.

In 0<Re(s)<1 the parity-dependent Gamma factor is analytic and nonzero, so L and f have identical zeros and local orders. Nonprincipal f is entire and not identically zero, hence its zero set in a compact rectangle is finite. Thus the complete strict-strip/closed-height carrier has the required finite multiplicity interpretation. For conductor one, source `Explicit/ZeroFree.lean:102` already proves xiF_zero_one_sub_conj from xiF_one_sub and xiF_conj. The same local-factor proof preserves its orders; the source nonvanishing completion factors transfer orders back to zeta in the strict strip.

## Turing and endpoint interface

The accepted `integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md:96–113` uses C_chi(T), the closed count of all nontrivial zeros with |Im(rho)|<=T, including real zeros. Its count identity holds almost everywhere on the auxiliary interval. Monotonicity and certified auxiliary lower weights give the same valid upper bound U without requiring zero-free boundary ordinates. The new implication changes only the final strict test from U<K+1 to U<K+2. It does not alter the allowance, gamma integral, auxiliary weights, proof of realness, root-phase choices or any actual enclosure.

Reflection preserves both gamma=0 and |gamma|=T. Off-line real or top-boundary pairs are therefore excluded on relaxed success. Critical central or boundary mass can remain in the one-unit residual; the exact-saturation argument that excluded all unrepresented boundary zeros must not be copied over. If T>=the requested closed height, the result directly supplies the source GRHUpTo conclusion.

For nonreal chi, positive intervals of chi and invchi represent positive and negative zeros of chi, respectively. For a real character, double the positive contribution, not the central contribution. A central lower contribution zero is always permissible for this implication, even without a nonvanishing certificate. An interval containing zero does not prove a positive central order. All represented intervals must be disjoint in the corresponding actual carrier.

The principal conventional count N_+(T) has a different normalization. J preserves positive ordinate, so the same +2 implication applies to that positive carrier. To obtain full |gamma|<=T RH, separately settle the real axis and use conjugation for negative ordinates. One may instead use a correctly normalized full symmetric count, but must not combine a positive-count upper bound with doubled K. A previously established head certificate can settle the real axis; it cannot be assumed from the very full-height result being proved.

## Author comparison and exact conditional guards

The author's symmetric completion includes the conductor factor absent from Mathlib's `completedLFunction`. With this normalization the reflection multiplier is the constant root number; it agrees with the variable nonvanishing multiplier derived above for Mathlib's completion. The author's minimal proof correctly requires only reflection membership and two distinct positive-order zeros, not an already formalized equality-of-orders lemma. Its treatment of real characters, central mass, closed boundaries and principal/exact-list exclusions agrees with the independent derivation.

The one-sided refinement in author section 5 also follows from the accepted horizontal bounds. Subtracting the lower bound for I(T) from the upper bound for I(H) gives

    pi * integral_T^H S < 65717/500 + (3/4) Z_H + 21 Z_T.

This is an upper allowance, which is the direction the count bound needs. It is not a new absolute-value bound or a reason to drop one of the two character-channel allowances. Directed enclosures of both logarithms and pi remain necessary. The four scalar examples use the old absolute allowance and do not depend on implementing this refinement.

An independent exact-arithmetic check passed 235 assertions: seven support hashes; the conductor-height cap; all four conditional guard rows, dense-grid increments and output products; the unadopted Rumely comparison; the horizontal constant addition; and 192 elementary missing-pair inequalities. For h=200,250,375,500 and respective future D upper bounds 1/4,1/2,1,5/4, the strict reserves are exactly 413/5000, 519/3125, 346/3125 and 519/6250. The proof of log(cH/(2pi))<18 uses only the cross-multiplied rational witness based on pi>3 and exp(1)>8/3, not logarithm evaluation. The h=1000 output count is only a grid-count comparison: this review does not extend the log<18 witness to it.

No row proves its required D, predicts a sign change, or validates a seed/evaluator extension beyond the previously proved height window. Changing h requires recomputing Abar and all H-v weights. The h=6 Rumely reserve is correct algebraically but retains its unproved analytic-input status. Thus the comparisons provide conditional decisions, not guaranteed guard reductions or runtime estimates.

Owned evidence, relative to this review's directory:

| Artifact | SHA256 |
|---|---|
| review_pair_deficit_scalars_20261111.py | 041929F77798335F22AC313D280D4C33AEB9240A1106A4283113C93C890C460E |
| review_pair_deficit_scalars_20261111.json | F82B70E9EECAE4BE4AD4DB92834B4C38BCCD4FA81916969E5E38E7D9AE1442F0 |

The script reads, but does not import or execute, the author's scalar packet. Its support pins bind the author script `9D834E4AAF2490211CC8635A20FE44BE5076653A1C60C16AFCB934EB9519E1D5` and receipt `31097AAF676A81004A79D2E564EE3318DEA6ACDBF1C275E9E99AED38CC05073D`.

## Source pins and limits

Mathlib paths below are relative to `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib`. Goldbach paths are relative to `work/ternary-goldbach/TernaryGoldbach`.

| Source | Relevant lines | SHA256 |
|---|---|---|
| NumberTheory/LSeries/DirichletContinuation.lean | 74,97,206–215,249,258,283 | ECF79F2A64EF2E7215729EBB2E7D5ADAA03468B18BBDA0040680AA925D4673F1 |
| NumberTheory/MulChar/Lemmas.lean | 73–79 | 8B72DD4496B40E0E4F5B9ED09E47FCC1777B597960F70FF14B6C43E8B5E0FF81 |
| Analysis/SpecialFunctions/Gamma/Deligne.lean | 69,80 | C49C714067E797E8DD0F40CCBF39593C754C1DF3AD5A54C7A6F17188F97C7F45 |
| Analysis/Analytic/Order.lean | 92–111 | 2426AEF2574C3DF5758D40D81DD33A6A62E07235F2B7B3F980512D4E80FDF46C |
| MajorArcs/GRH.lean | 32–38 | 89C6DF8490955EEA8F4141498BCA6D163355C2E7765C9ECD09F8CEE5B257A070 |
| Explicit/LGrowthLeft.lean | 221–233 | 59B0B227CC2D9472C6389231E8CC3998698F1F3E59139A8D110F32FF64F2F3D4 |
| Explicit/ZeroFree.lean | 96–104 | E8096BB9CACE76603D8B14429596279046D0E9F99DFDBD6E4BDCF8368A89084A |
| integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md (agent path) | closed-count section | 72275B5CBA95FDD4F933C2150399C214B2509D9EF91D08A494104466DC8D597C |

Actual same-character conjugation/order adapters, finite carrier completeness, critical support of K and the closed Turing upper bound must be formalized and supplied by a concrete checker. The paper implication introduces no RH assumption. It can relax acceptance by one count unit; it supplies no quantified speedup, sign-discovery guarantee or permission to weaken exact-list consumers. Old reports and numerical packets remain unchanged.
