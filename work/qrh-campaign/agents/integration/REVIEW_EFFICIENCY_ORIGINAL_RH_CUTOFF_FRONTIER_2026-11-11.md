# Original-RH cutoff frontier: independent review

2026-11-11. **PASS at the bounded source/paper and exact rational-composition scope.** No correction is required to `major-constants/EFFICIENCY_ORIGINAL_RH_CUTOFF_FRONTIER_2026-11-11.md`, SHA256 `92D9973CE90C99748317A4D029057B7D3A2522BC1DE30A5EA300F4A3EA61FEE6`. This extends the accepted R140000 argument to R138000 with the same final constants and N0. It does not certify an implemented Lean dependency reduction or new spectral evidence.

## What was checked

I read the complete frontier note and script against the accepted V2 note and my full consumer review. The four frontier artifact pins match. The seven elementary scalar recipe functions (`unitlog`, `logb`, directed lower/upper rounding, integer root, square-root bracket, and `ghat`) have identical syntax trees to V2. The bounded cell parser retains the corrected complete scientific literal and theorem-boundary rules. All nine serialized source-cell records exactly equal V2, and the full NumericsCells source hash matches.

A separate read-only calculation using Python integer/Fraction arithmetic, without importing either producer, reconstructed the recorded rational compositions. It checked:

- The exact five-row sequence 140000,139000,138000,137000,137900 and the pass sequence true,true,true,false,false.
- All 45 finite-cell and five asymptotic expressions, including `1.0005` and `2001*22.75*8e-11`, their diagnostic margins, and all ten named guards for each row.
- Positive mass, J, I and singular lower bounds; positive finite and asymptotic base coefficients; base-gap comparisons; and `(6R)^3<=Y` for every finite cell.
- Both exact target reserves, every R138000 display bound, and the unchanged N0 arithmetic.
- Exact agreement of the R140000 overlap with V2 for mass, J, I, singular/major bounds, gap, all cells and asymptotic results.

This independently checks composition of the recorded rational envelope values. It does not independently regenerate the new logarithm/root enclosures or execute the author's elementary evaluator. Their unchanged mathematical recipe remains covered by the prior source review. No analytic function, zero or prime evaluation, build, declaration or source modification was performed.

## Exact result and limits of the search

At R138000 the worst of the ten minor bounds is cell 0, and

    1.0376 - worst_minor
      = 118403703823830928586557 / 4000040000000000000000000000
      > .0000296.

The independent rational check also gives

    major_lower - 1.049
      = 1107777376393857101 / 4290937500000000000000
      > .000258.

The bounds I_R/x>8.53683, major_lower>1.049258, basegap<.013036 and asymptotic_minor<.766953 hold. All nine published finite-cell upper displays are safe upward bounds. Cell 0 controls every tested row, not merely R138000.

At R137000 and R137900 the only false named guard is `finite_minor`. Other positivity, major, asymptotic and gap tests still pass. This establishes failure of this sufficient envelope to prove the unchanged minor target, not failure of the actual integral inequality. R138000 is the smallest demonstrated cutoff among the recorded finite tests. The source loop stops at the first coarse failure and at the first refinement failure; no statement about untested smaller cutoffs or global optimality follows.

## Why the source joins still apply

The prior review reconstructed the actual original-RH consumer chain, rather than invoking `major_total` or `minor_total` as unchanged black boxes. Its relevant hypotheses hold throughout the five tested even cutoffs, all in [100000,150000]. In particular:

1. The arcs retain q-tilde<=2R. At R138000 this yields odd primitive c<=138000 and primitive even c divisible by4 with c<=276000. For odd c dividing even q, q/c is a positive even integer, giving c<=q/2. Inverse characters and conductor one remain included. The original inclusive heights stay 1e8/c and max(1e8/c,200+7.5e7/c); neither is reduced.
2. The original per-modulus geometry has wx>=4 and 2w<=8R/x<=1200000/x, using q-tilde>=2. The Thm714/Cor713 twist and conductor bounds therefore remain valid. The generalized base-gap witness must still retain q-tilde, rather than only q<=2R. Its fresh upper bound is below .014, while the same positive lower estimate on ghat is above .03.
3. The odd-centered mass comparison applies since R is even. The recomputed J and I replace the old rounded lower constants. The Rankin error is still 22.1/R. The positive product upper comparison is legitimate; no monotonicity of the signed singular sum or complex major integral is assumed. Positive singular and base-expression coefficients were checked explicitly.
4. The generic large-sieve base condition R>=100000 remains true. New levels R<n<=150000 satisfy the old higher-level domains and telescope exactly into cL(150000); n=150000 is included once and the old chain begins at150001. No omitted conductor is used to bound the newly exposed minor annulus.
5. The original energy remains `(.640208+366.91/sqrt(x))*log(x)-.021095`. The nine lower Y values and all closed scale joins are unchanged, as is the asymptotic branch. No .65 energy replacement, .555 strip, global7/8 bound or QRH provider enters.

The scalar denominator guards do not acquire an edge case at the smaller R. From floor(cuberoot(Y))>=6R the argument `9u/(4.008R)` exceeds 13, so its positive logarithm stays positive after the stated 1e-7 downward rounding. For R>=100000, log R>10 follows from e<3 and 3^10<100000; the nested logarithm denominator likewise has ample positive margin after the two directed roundings. Square-root denominators involve 2R>0. These facts supplement the explicit assertions in the unchanged scalar recipe without requiring new function values.

## N0, final roots and remaining work

The same bound `0<c0<989/490` and exact identity `(989/490)*4.9e26=989*10^24` imply x>4.9e26 and y=x/49>1e25 at every N>=N0, including equality N=N0. The exact comparisons `(6.9)^32<N0` and `(2.64)^64<N0` are unchanged. Thus the prior original nonprime proof and its strict .0114 normalized bound still combine with 1.049-1.0376=.0114. The optional .00271 diagnostic does not replace this acceptance condition or authorize weaker final constants.

The large-N result requires no binary premise. The full Statement retains the original inclusive BinaryGoldbachInput through4e18 and its separate checked prime-chain input. The refinement changes neither N0 nor that finite-range task.

As in V2, actual formalization must localize the finite-RH inputs, parameterize the arcs and decomposition, reprove the new J/I/singular/base-gap bounds, and replace the numerical goal while reusing the old chains. Principal-only prime estimates remain required, including the original conductor-one RH inputs. Keeping blanket PlattGRH arguments in the final dependency path would not realize the claimed family reduction. This review does not mark those source changes, spectral certificates or kernel checks complete.

## Frozen evidence

Paths are relative to the workspace root. V2 and the prior review contain the inherited source ledger and declaration locations.

| Artifact | SHA256 |
|---|---|
| `work/qrh-campaign/agents/major-constants/EFFICIENCY_ORIGINAL_RH_CUTOFF_FRONTIER_2026-11-11.md` | `92D9973CE90C99748317A4D029057B7D3A2522BC1DE30A5EA300F4A3EA61FEE6` |
| `work/qrh-campaign/agents/major-constants/original_rh_cutoff_frontier_20261111.py` | `7CBAD3B4F0FF7CCA678EE364860F243EE9FB4F548F6517CF5E67A6F325FE7001` |
| `work/qrh-campaign/agents/major-constants/original_rh_cutoff_frontier_20261111.json` | `A573B8409CEFBE8E21614FB305B1C57A9D71B16FD8DDA94ABA132C9ACB41CB7C` |
| `work/qrh-campaign/agents/major-constants/EFFICIENCY_ORIGINAL_RH_MODEST_CUTOFF_V2_2026-11-11.md` | `33A3D9645BD9A8F856DD13A40028FF314A2769E8938FA90050A194C048C84517` |
| `work/qrh-campaign/agents/integration/REVIEW_EFFICIENCY_ORIGINAL_RH_MODEST_CUTOFF_2026-11-11.md` | `3DDA3A1073AD671AA418816D96966D07B0AA0B08D686C67E701B2B81302DC3A2` |
