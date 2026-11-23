# Independent review of the selected-profile production frontier

2026-11-11. PASS for the metadata comparison and the stated evaluator parameter restriction. This is not acceptance of a production algorithm, finite spectrum, runtime estimate, or Lean theorem.

Reviewed [report](../qrh-campaign/agents/prime-estimates/SELECTED_PROFILE_PRODUCTION_FRONTIER_2026-11-11.md), SHA256 `E633476F456ECF58135F944EC07AEDC50AB6B20058148AD1A018FD1AD69D2A46`. I read the complete report and its complete metadata script. The script has hash `F75847A1C0AE51455B277232810A5A6B8614DCD774658801D40AC23BA2F5A3BB`; its receipt has hash `7311301D07977142BD4FC953D8F352C44929DD8E2E8F8B04964D3CDCC44E0388`. I checked the reused artifact pins and inspected the actual selected profile, uniform finite-U allocation, finite-EM tensor composition, auxiliary Fourier parameters and Turing margin convention.

## Independent arithmetic

My separate [metadata script](profile_volume_independent_20261111.py), hash `C6466F904C4C524346B9BCDF24EE7F558EFC50C7D22A67F000D4F9FFF095CC4D`, uses a smallest-prime-factor sieve and multiplicative formulas. In particular the primitive count at a prime power is `p-2` for exponent one and `(p-1)^2*p^(k-2)` for exponent k>=2. The author instead uses two divisor inversions. Neither script imports the other or evaluates an L-function, zero, theta function or prime sum.

Both constructions give 150000 active conductors and 5543640188 primitive-character labels. The three groups have 1847865075 unchanged labels, 2053236314 changed odd labels and 1642538799 changed four-divisible labels. The principal contribution is exactly60343058 in both profiles.

I round each height outward before multiplying by its character count; the author rounds each weighted height outward. With denominator10^8 my enclosing totals are

```
old: [538919941175367688153,538919941179770212426] / 10^8
new: [455969184402525518630,455969184406927446391] / 10^8.
```

The author's narrower intervals lie inside both independent enclosures. I also checked its exact ratio endpoints against the displayed decimal rationals. They give

`.846079629950 < new/old < .846079629951`.

Thus the full positive-height proxy falls about15.392037 percent. Its unchanged contribution already exceeds half the old total. The high-only ratio is not a full-family saving. None of these statements counts zeros, panels, function evaluations, proof bytes or CPU time.

The separate multiplicative totient calculation also reproduces the literal one-top-center finite-EM base counts exactly: old8500555507588 and new7467072337142. Their formula is `sum_{active c>1} phi(c)*(ceil(H(c))+36)`. The actual uniform allocation specifies `N=ceil(T)+36`, and the tensor composition specifies `N*phi(c)` base terms before additional jet/moment work. This count excludes conductor one, counts only one center per conductor, and is not a lower bound for an optimized evaluator or a complete scan.

## Auxiliary height and acceptance

The uniform finite-U allocation explicitly assumes `c*T<=100000000`; this is not a premise of the desired spectral theorem. For auxiliary end `U=T+h`, its reuse requires `c*(T+h)<=100000000`. At the selected exact main height this leaves `50000000/c` for high odd conductors and `1000000/c` for high four-divisible conductors. At c=300000 these latter margins are10/3 for T=330 and7/3 for T=331. Unchanged rows whose required height saturates the product cap leave no positive auxiliary interval under that same specialization.

The inspected arbitrary-height Fourier plan expressly removes the product cap by choosing parameters from the actual auxiliary end. That is a conditional paper construction, not a completed producer. The report correctly makes no claim that all possible evaluators or Turing methods have this restriction. The measured count discrepancy in the Turing acceptance test remains a separate data-dependent quantity; choosing a long auxiliary interval alone cannot prove saturation.

For precision, the report's reference to a simple-root result from ordinary sign saturation applies to the ordinary disjoint sign-change brackets. A separately certified central multiplicity remains whatever its exact certificate establishes. No global simplicity premise is introduced. Direct-strip and cluster modes remain permitted, and the selected profile itself asserts only the required zero location with true multiplicities.

All actual character labels, real-axis and inclusive-height coverage, correction terms, source-function identities, and final standard-axiom acceptance obligations remain required. No production implementation, timing, spectral data, Lean source, declaration, or frozen amendment was changed during this review.
