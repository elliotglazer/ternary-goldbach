# Independent review: coefficient-11 zero-free region above 88 million

Date: 2026-11-11. Verdict: PASS as a bounded source-faithful paper adaptation. No mathematical correction is required. This is not an implemented theorem, an independent validation of the entire analytic foundation, or a reduction of the complete principal RH target.

## Frozen objects and verification scope

The reviewed author note is `integration/PRINCIPAL_ZERO_FREE_88M_CANDIDATE_2026-11-11.md`, SHA-256 `C2B2BEDA22F72218AA4977368F5CA77D504DA4F58EF7881B3087EA9ECC9B7045`. Its scalar script is `09FF3DCE0E4F6415D748A6E0FA0EFFBA8535909B284CCDBA660CF77E1422B53B`; its JSON is `66A18E1631BDEB7D6DDD60480B45C121F1DF59473C0D918EEE98BE9906BC020A`.

I read the note, the actual Stechkin wrappers and final source proof, the convergent-series positivity argument, and the immediate `PsiLarge` consumers. I independently reconstructed the rational bounds without importing or executing the author script: 20 rational comparisons passed, all nine stored rational values agreed, and all six source pins and three packet pins matched. No special-function values, zero data, builds, or source edits were used. The source API and constants are checked at the cut described below; their deeper proofs are retained inputs.

## Actual source and domains

Paths here are relative to `work/ternary-goldbach/TernaryGoldbach/`. In `Explicit/ZeroFreeRegion.lean`, the relevant declarations are `vM_positivity:158`, `vM_real_le:286`, `vM_term_le:306`, `stech_wrap:384`, `stech_wrap_rho:393`, `zero_free_pos:421`, and `zero_free:546`. The author gives 308, 379 and 388 for three of these; the correct declaration lines are 306, 384 and 393. These are locator corrections only; frozen author bytes remain unchanged.

The wrappers impose no 100-million threshold: the real-axis estimate needs sigma>1; the nonzero-ordinate estimate needs 1<sigma<=1.02 and tau>=10. The distinguished-zero wrapper consumes an actual zero of `xiF` with real part different from 1/2. Under the contradiction hypothesis and L>=18.29, beta>0.95, so this last condition follows rather than being assumed. `xiF_zero_re` supplies 0<beta<1. The chosen comparison real part 1.6181 exceeds sigma, the ordinates agree, and the Stechkin quadratic domain holds since (sigma-1/2)^2+1.1181^2>3/2.

`vM_positivity` concerns the actual absolutely convergent von Mangoldt Dirichlet series at sigma>1. Its weights 18,30,17,6,1 arise from the pointwise identity

    18+30 cos(theta)+17 cos(2 theta)+6 cos(3 theta)+cos(4 theta)
      =8(1/2+(3/2)cos(theta)+cos(theta)^2)^2.

There is no replacement by a formal positivity premise or a sampled inequality. The zero-extraction and Stechkin pairing retain the source's actual multiplicity machinery; this adaptation does not assume simple zeros.

## Retuned constants and the contradiction

For H0=88000000, the positive exponential-series remainder at u=29/100 is bounded by

    U10=sum(n=0..10) u^n/n! + (u^11/11!)/(1-u/12).

After the first omitted term, successive ratios are at most u/12. The exact inequality `(2.7182818286)^18 U10 < H0`, together with `Real.exp_one_lt_d9`, proves log(H0)>18.29. The latter source declaration is at Mathlib `Analysis/Complex/ExponentialBounds.lean:38`, whose file hash is `81912243C4328F7B626BAE92A660BEACDDA14DC8E6E1E014F054E59294F4F773`.

Set L=log(t), sigma=1+0.31/L and kappa=(sigma-1/2)/1.1181. For every t>=H0, the checked bounds are sigma<=1.01695, 0.4471<=kappa<=0.46235, 1/sigma>=0.9833 and 1/(sigma/2+1)>=0.6629. All reciprocals used have positive denominators. The source logarithmic bound applies because sigma/2+2<=2.5085.

The distinguished pole satisfies sigma-beta<0.40091/L and 2.4943*0.40091<1. Thus its first reciprocal exceeds 2.4943L; its second is at least 0.9833. The comparison-pole subtraction costs at most

    0.46235(1/0.6181+1/1.5681)<1.043.

The real-axis comparison expression E1 is bounded above by 1.2857. Multiplying this inequality first by nonnegative kappa, then using the positive upper bound 1.2857, gives kappa E1<0.5945 without needing to prove E1>=0. The complete inverse-square contribution is bounded by 7.5/H0^2<10^-15, uniformly for every real j>=1; it includes both terms in `vM_term_le`.

For the real-axis term, 1/sigma cancels exactly with half of 2/sigma. Hence F0<=(100/31)L+c0, where c0=-0.44395. In the other four terms, the multiplier of 1-kappa is nonnegative, using L>=18.29 and log(pi)<=1.2; only then may 1-kappa be replaced by 0.5529. Using the lower bound log(pi)>=1.1447 afterwards gives the author's constant c and coefficient 0.27645.

The resulting upper bound on the nonnegative weighted series is mL+C. Independent exact arithmetic gives

    m=-569217/310000 < 0,
    -(m*(1829/100)+C)=2992690310999973/500000000000000 > 0.

Therefore mL+C<0 for every L>=18.29, not just at a finite set of heights. This contradicts the actual series positivity. All four positive-ordinate calls have tau=j*t>=10, and the coefficient 11 is unchanged.

## Closed endpoints, conjugation and consumers

The argument includes t=H0 because log(H0)>18.29 and the final margin is strict. Conjugation in `zero_free:546` preserves the real part and the actual zero relation, giving the same result for all |Im rho|>=H0. The logarithm is positive throughout this domain. Thus both endpoints of the newly relevant closed annulus [88000000,100000000] are covered, without an additional RH hypothesis, a boundary nonvanishing claim, or a finite sampled-contour inference. Zeros on the claimed zero-free-region boundary are permitted by the non-strict conclusion.

For x>1 and H0<=|Im rho|<=Gamma, monotonicity with positive logarithms gives

    x^(Re rho)<=x exp(-log(x)/(11 log(Gamma))).

This is the argument in `Explicit/PsiLarge.lean:42` with its lower-height premise replaced by the new paper lemma. The immediate `mid_sum_le:80` uses an analytic zero-count bound and retains its shape; its height-dependent numerical specialization is not automatically unchanged. In a future split at H0, the low closed RH carrier and high analytic estimate have compatible endpoints. Disjoint sum conventions must still be retained when adding their contributions.

The adaptation does not certify the changed numerical mid-zero estimates in `PsiRange1` or `PsiAsymp`, the finite cB tables, or Mertens/E1. Nor does it convert the separate 88-million plateau candidate into a complete replacement target. Those remain distinct source and numerical joins. This verdict supplies only the universal coefficient-11 zero-free paper theorem and its immediate monotone consumer interface.

## Source ledger and retained foundations

| Source file | SHA-256 |
|---|---|
| `Explicit/ZeroFreeRegion.lean` | `AC367CDA6777165DF4AF22BA1BA1530B8A280B77CA55F1918562376DE69C0EAB` |
| `Explicit/ZeroFree.lean` | `E8096BB9CACE76603D8B14429596279046D0E9F99DFDBD6E4BDCF8368A89084A` |
| `Explicit/XiPartial.lean` | `8F47E96329BF7F1CC69F82C3AB5A422087F692BECB74EF70A7908BC323623770` |
| `Explicit/PsiLarge.lean` | `D370555A164DA01E37E5BDB14EFA774DC79FE43682EED21D42C90BA2D1B165F2` |
| `Explicit/PsiRange1.lean` | `F474C24F28ED3D14774A170F19EF312AE132124D727ABD438478C4AF89BBE026` |
| `Explicit/PsiAsymp.lean` | `2EEE8AAAC78360010044AB5964058ADB5998FB30EFAC3000352ED6D2114D047D` |

The retained analytic cut includes the actual xi partial-fraction approximation, Stechkin pairing, actual zero strip/conjugation, digamma estimates, and Dirichlet-series identities used by the inspected wrappers. This review reconstructs the changed argument above those inputs; it makes no elaborated-axiom-closure or full-foundation claim. Implementing the new threshold lemma and re-certifying its downstream numerical consumers are still required.
