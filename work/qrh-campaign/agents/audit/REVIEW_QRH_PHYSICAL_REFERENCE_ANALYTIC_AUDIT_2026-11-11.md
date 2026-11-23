# Independent review: physical reference energy comparison

Date: 2026-11-11. Verdict: **PASS at the stated conditional, local source-mathematics scope.** No substantive correction is required. This is not a compiler result, an axiom-closure audit, or validation of the full QRH provider.

Reviewed author report: [QRH_PHYSICAL_REFERENCE_ANALYTIC_AUDIT_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/zero-sum/QRH_PHYSICAL_REFERENCE_ANALYTIC_AUDIT_2026-11-11.md), SHA-256 `BD8BAEEC4BB7225CCEBAF8EFC8C9B233E0B3C82E26A92B7020F2A2972073355C`. All 33 source-file hashes in its table were independently recomputed and matched. Provider source revision: `4eaee87548250b2682affda7d05d947c05554bae`.

## What the estimate actually proves

The entry theorem [InitialEnergyCallerReference.lean:23](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Inversion/InitialEnergyCallerReference.lean:23) compares an actual finite physical block with supplied normalized child-energy bounds. The reference windows are chosen before the order J, slot cap N, quotient cap U and positive loss pi. The comparison constant is then chosen before the prime pools, finite source, frequencies, scale and modulation data. Thus the source does not hide the size of the actual finite source in its constant.

The child-energy premise is substantial: it holds for every real modulation, ray, ordered pair of slot subsets and actual quotient ideal, for both actual minus/plus characters and the puncture j times the primary generator of that quotient. Its divisor weight is d(f)^(|J1|+|J2|+1). The theorem does not construct this premise or replace it with an arbitrary abstract energy. The nonzero-label, negation-closed-row, source-to-child containment and actual BlockSupport identities are also genuine inputs. In particular, BlockSupport requires cutoffs to equal one on the relevant live sets; mere support containment would not suffice.

The checked statement permits negative quotient exponent R and negative unclipped column exponent. Neither is silently strengthened to nonnegative. Empty/live cases in the proofs handle them.

## Independent reconstruction of the finite comparison

For a fixed child (t,f,k) with j assigned labels, a valid source tuple is encoded by a divisor e of f and its j assigned divisors of tf. Holding this code fixed recovers the common ideal as te, the residual by nonzero cancellation in e times residual=f, and the frequency by nonzero multiplication by the primary generator of e. Therefore

`fiber cardinality <= d(f) d(tf)^j <= d(f)^(j+1) d(t)^j`.

This is the actual injective coding in [InitialFibers.lean:47](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Inversion/InitialFibers.lean:47), not an assumption that children occur once. The assignment reindexing separately preserves the entire ordered assignment tuple through attachPair; it does not discard repeated contributions. Finite triangle and Cauchy–Schwarz then bound a coefficient-weighted pair by its coefficient cap times the square roots of the two divisor-weighted child energies.

[InitialClippedColumns.lean:199](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Inversion/InitialClippedColumns.lean:199) defines normalized energy using Z^(-F/2) inside each squared norm. Consequently raw energy is Z^F times normalized energy. Both square roots together contribute exactly Z^F, not Z^(F/2) and not Z^(2F). The right row -k is reindexed by the explicit finite involution; equality of row values at k and -k is never assumed.

For the finite quotient set, the divisor subpower and ideal-count estimates give

`H^(-1) sum_t d(t)^j <= C H^e`.

Taking H=Z^R and e=pi/(U+1), with R<=U and U>=0, gives R e<=pi and hence total mass <=C Z^(R+pi). If the set is nonempty, its nonzero ideal norms force H>=1; the empty case needs no such implication. The allocation, unit and ray summations pay respectively 4^N, six, and a finite sum of absolute ray coefficients. I found no unpaid source-cardinality or assignment-multiplicity factor.

## Actual Fourier profile and clipping

The radial density is an actual Fourier transform of `cutoff(s) * paperRadialFourier(Phi)(R0 exp(s))`. The fixed cutoff is one on every active linear combination of logarithmic coordinates. On its derivative support, exp(s)>=m0>0, where m0<=1. Thus

`1 + R0 exp(s) >= m0 (1 + R0)`.

Euler-derivative bounds for the radial function, the exponential chain rule and Leibniz therefore bound the compact profile's required ordinary derivatives by a constant times `m0^(-A0) (1+R0)^(-A0)`. Derivatives through J plus the integrable-power order supply the weighted Fourier L1 estimate; the companion Fourier seminorm bound supplies pointwise decay. This is the local argument at [IdealQuotients.lean:305](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/QuadraticSieve/IdealQuotients.lean:305). It does not invert an uncut logarithmic radial function. The constants are uniform in R0, but depend on the fixed cutoff/window and the requested derivative orders.

The common density has two source Fourier factors, this radial factor and six coordinate factors. Its weighted absolute integral factors into their one-dimensional moments. The additional exp(-3L) is bounded by one because L=eta log Z>=0. Clipping translations have unit phase, so no missing power of a clipping parameter enters the L1 bound. Finite sum/integral interchange and the norm-of-integral step have explicit integrability inputs; they do not use the value of a default integral to assert convergence.

The actual row clipping is also an energy statement. A live column bounds the ratio Z^(max(0,n)-n) in [1,b]; if there is no live column the row is zero. Each row is represented by an integral of reference rows, and the finite vector includes sqrt(labelWeight) times Z^(-F/2). Weighted integral Cauchy–Schwarz produces the square of the Fourier moment. This accounts for the normalization and the nonnegative divisor weights together. The two modulation signs are retained, and both are bounded by the joint profile weight of order 4J.

Writing P=m-2D+B-theta and delta=max(0,D-B-v)-(D-B-v), the resulting exponent is exactly

`P+3eta+F+R+pi+(F+epsilon) = m+5eta+2delta+pi+epsilon <= m+11eta+pi+epsilon`.

The second F comes from the supplied energy bound itself. The last inequality uses delta<=3eta, not a stronger unstated assumption.

## Remaining analytic obligations

This comparison does not supply the canonical child-energy estimates. The subsequent retained-physical caller explicitly invokes canonical_marked_energy_exists. Its rank/induction proof remains outside this acceptance.

The following foundational estimates and identities also remain cuts rather than fully reconstructed proofs here: the ideal-divisor subpower and ideal-count bounds; the radial Euler continuous-linear-map/seminorm bounds; the general Fourier coefficient-moment, inversion, finite-vector integral and product-measure theorems; and the underlying first/second Poisson child normalization and Gauss-column norm bounds used to obtain the actual coefficient cap. Their invocation, actual-function semantics and local algebra were inspected. This is not a blanket approval of every file they import.

The separate global high-frequency theorem original_physical_tail_rapid remains open at the previous audit's cut. Local radial decay, especially its A0=0 use in the present comparison, does not establish the infinite tail summation. The earlier total-energy audit handles its limit only conditional on that tail input. No terminal-band construction, full global provider validation or finite spectral assertion follows from this review.

All existing final targets and premises remain unchanged: the intended large-range root is unconditional TernaryGoldbachFrom(10^27), and the full Statement retains only its original BinaryGoldbachInput. This report adds no permanent premise to either root; it identifies proof obligations still needed to reach them.

## Additional source pins and verification record

Paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL`. These supplement the author's 33 verified pins.

| Source | SHA-256 |
|---|---|
| Inversion/InitialClippedColumns.lean | `19424723657E5E55AC5648A7ED4922A83AF977AD9448C9F599E4B9F5DAFF2B94` |
| Inversion/InitialEnergyCallerWeights.lean | `E047A77618A056D2663D6C2F29FDFB19D3756AEDA97B2FEE5C01DD45438062C8` |
| Inversion/InitialEnergyCallerFamily.lean | `3A3C4F82F113BDB20D480998D8FCB55A1BEB6346887763735CA52035F8F73113` |
| Inversion/InitialEnergyCallerModes.lean | `6A86771A72BF91956D5BE3661BC41D030DF4E797B508EB5EB003DF2DB4053837` |
| Inversion/InitialRetainedPhysical.lean | `6825D15988244817C90F2C106494AB62C64E2967D20A1BB7DB0FD10927097E18` |
| Descent/TripleMass.lean | `46A20139596A3B3A9D004D859DF10C982151278CC9417E6F4226E63ED9CB6B08` |

Verification consisted of source reads, exact algebra and file hashing. No Lean/Lake invocation, numerical analytic evaluation, source mutation, or spectral scan was performed. The author report's displayed `quad` token in the Euler-bound formula is a cosmetic typesetting typo, with no mathematical ambiguity.
