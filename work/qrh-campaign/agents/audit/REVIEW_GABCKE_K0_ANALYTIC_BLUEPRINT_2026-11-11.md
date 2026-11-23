# Independent review of the shorter Gabcke K0 blueprint

2026-11-11. **Conditional mathematical reduction PASS; one source-dependency correction is required.** The low-order estimates imply the proposed .45 bound for every real t>=1500, assuming the explicitly listed analytic identities and bounds. They do avoid the R10/C2–C10 route. This is a reviewed proof blueprint, not a completed analytic proof, approved Lean graph, or new theorem assumption. No Lean/build, sign scan, dependency mutation, or frozen-package edit occurred.

## Pins and correction

Reviewed `major-constants/GABCKE_K0_ANALYTIC_BLUEPRINT_2026-11-11.md`, SHA256 `8A65614DA19778FBA1CB08440183FCE49D52B9BCCD9F7B552EA535234C1DD713`, and scalar script `gabcke_k1_scalar_20261111.py`, SHA256 `CDCAF0DB9559A875C74E0DD8BB52E7E7F7E012CF40ECFBBE296ED713D7FB062C`. Primary PDF: Gabcke corrected thesis, SHA256 `A28AE7BE557F75997D1F9C48C9517247581F55AB89477181127F83E3DFFBBE53`, <https://d-nb.info/1072293277/34>.

**Concrete correction to section6:** the asserted list of needed Mordell parameters “1 and1/2” omits **2**. Printed p62, proof of Satz4.1.2, explicitly sets m=2,n=1 to identify the contour-defined Ftilde with its elementary quotient. Satz4.1.3 uses1/2 on p63; the Riemann–Siegel integral proof uses1 on p66. Therefore the cited proof route needs all three cases 1,2,1/2, unless a separate proved transformation derives the parameter2 identity from the others. “The two needed Mordell identities” should be updated accordingly. This omission affects the dependency ledger, not the checked scalar inequality. Author and parent were informed; this review does not modify the pinned note.

The primary theorem4.1.1 itself refers its proof to Chandrasekharan; the thesis does not prove that external leaf. This review has not reconstructed the external primary proof either. A theorem citation or correct quotient formula is not a substitute for those contour identities.

## Exact normalization and low-order identities

I compared the note against printed pp12,16–17,35–36,41–42,47–50,61–70,80–86, and visually inspected the full four-term formula on p48. The variables agree: a=sqrt(t/(2*pi)), N=floor a, z=1-2(a-N), q=sqrt(pi)*z, tau=(8t)^(-1/2)=1/(4*a*sqrt(pi)). For actual finite t, -1<z<=1. The uniform residual bound extends to the closed q-range as stated by Gabcke.

The exact saddle identity uses Re(U*S), U=exp(i*(theta0-theta)), and the correction factor (-1)^(N-1)/sqrt a. The S contour, its southwest-to-northeast orientation, the upward logarithmic cut, and the indentation retaining the endpoint pole on the left agree with Satz1.2.1. At integer a, z=1; the finite approximation need not be continuous across floor changes. The Rg numerator cancels the possible cosh pole in the residual integral, so the residual contour can then be straightened as in3.1.1. Those convergence/deformation arguments still need proof.

The differential recurrence gives P1=w^3/3-iw and P2=w^6/18-(5i/6)w^4-(3/2)w^2. Independently generating the recurrence gives coefficient rows (1), (1,2), (3,20,40). The definition RS1=S-B0-B1*tau is exact and needs no invalid exchange of an infinite asymptotic series with an integral.

Equation1.28 gives b1=Ftilde' and b3=Ftilde'''+3i*Ftilde'. Hence B1=b3/3-i*b1=Ftilde'''/3. Using Re Ftilde(q)=F(q/sqrt(pi)) gives Re B1=F'''(z)/(3*pi^(3/2)); the powers of pi and derivative factorials in the note are correct.

The source bounds used here are valid over the closed range: |B0|<=1, |b1|,|b3|<=2/sqrt(pi), hence |B1|<=8/(3*sqrt(pi))<8/5. The n=1 case of2.3.1 is |F'''|<=4*pi. Its proof uses the real Gaussian representation and the sinh/cosh ratio bound sqrt2 from4.4.1. The latter follows from nonnegative power-series coefficients and |cosh((1+i)x)|>=1. The constants are consistent, including the sqrt2 factor; no decimal coefficient table is needed.

I also checked the actual pinned Mathlib definitions of hardyZ, ofReal_hardyZ and Gammaℝ. The note's required adapter Gammaℝ/|Gammaℝ|=exp(i*theta) has the correct sign and normalization. That identity remains to be proved from the normalized analytic log-Gamma. Equality of zero sets or absolute values alone would not justify signs.

## First-order residual bound

Satz3.1.3 requires t0>(3K+4)/.44 and vartheta>sqrt(2*(3K+4)/t0), with K a nonnegative integer. K=1,t0=1500,vartheta=1/4 satisfies both strictly. The displayed w is correct, and arctan(1/9)<=1/9 implies w>=17/36>0. All inverse-power substitutions therefore have the correct direction.

Substitution of (3,20,40) into the source's four Y terms gives precisely the note's middle formulas. Gamma(1+k)=k! is used there; no half-integer factor is lost. The first and last tail polynomial is `9/4+(25/12)*x+(7/36)*x^2`, with x=vartheta^2*t0 and x=t0 respectively.

The discarded sinh denominators are indeed greater than one. For example sqrt(2*pi*1500)>16; the first sinh argument exceeds1 and sqrt(pi)>1. The last sinh argument exceeds4, while .44*sqrt(2*pi)>.88. The exponential comparisons follow from positive Taylor terms: e>8/3, exp(1500/64)>exp20>(8/3)^20>300000000 and exp330>2^40. The resulting bounds .001,1.82,2.31,.001 sum below4.2. Thus |RS1|<4.2*tau^2 is a valid specialization of the stated analytic theorem.

Precision on the incomplete-Gamma leaf: Satz4.4.3 requires **a>=1 and x>a**, not merely a>0. The actual a values3/2,5/2,7/2 satisfy the stronger condition, and both tail thresholds exceed7/2. This is a clarification of its formal contract, not a defect in the specialization.

## Phase and final assembly

The present proof of |U-1|<tau^2/5 still imports **Gabcke4.2.3(d)**. Dividing its three correction terms and remainder by tau^2 gives exactly

```
1/6 + (28/45)*tau^4 + (3968/315)*tau^8 + (8^7/3322)*tau^12.
```

For t>=1500, tau<=1/40, and the source-based upper value is below1/5. Thus |U|=1 and the real exponential Lipschitz estimate gives the required bound. This review does not presume that the separately developing lower-order phase proof has removed the complex Stirling/Gamma leaf.

The expansion US=B0+B1*tau+E1 then gives |E1|<4.41*tau^2. Taking real parts and using |F'''|<=4*pi yields

```
|Z-Z0| < t^(-3/4) *
 [(2*pi)^(3/4)/(3*pi) + 4.41*(2*pi)^(1/4)/(8*sqrt t)].
```

The exact bound obtained from (2*pi)^(1/4)<198/125, pi>157/50 and sqrt t>38 is

`3317717799/7457500000 = approximately .444883379014415 < .45 < .47`.

This is uniform for every real t>=1500, including floor transitions, conditional on the source analytic identities. It is not claimed for200<=t<1500. On the finite evaluator range t<=10^6, replacing actual theta by the reviewed three-term approximation adds at most80/(3322*t^7). That error can be kept separately or absorbed in the .02*t^(-3/4) gap: since t>=1500, `80/(3322*t^(25/4))<=80/(3322*1500)<.02`. Thus the published .47 budget remains safe after that particular phase substitution on the stated finite evaluator range.

## Independent arithmetic and remaining gates

I reran the author's print-only scalar script with output redirected to `gabcke_k1_scalar_replay_20261111.log`. I also wrote `gabcke_k0_independent_scalar_20261111.py`, which reconstructs the recurrence, generates the substituted Y terms from factorials, checks tail side conditions and phase coefficients, and verifies the final rational assembly. It exits zero; no floating comparison decides acceptance.

Independent script SHA256 `C567EB09585824DBF25DC054254B56294F4F5C3261CE1538A0BA1B16EDCFCE16`; JSON SHA256 `068194198282A3C43FAEA4AED8AD11C06CF12D6CB53B2A4CC261785880D9B596`. Its output explicitly says the analytic lemmas are unproved.

The reduction genuinely removes R10, the high C_n tables and their Cauchy truncation. It does **not** remove the external Mordell identities, exact RS contour representation, contour orientation/branch/endpoint proofs, dominated differentiation, the four-range exponent estimates, the normalized Gamma-phase estimate, or the actual-HardyZ adapter. The blanket source/API table was not independently revalidated declaration by declaration here; the actual Hardy/Gamma definitions and the mathematical source contracts needed for this reduction were checked.

Once the omitted Mordell parameter2 is added to the ledger, this is a sound shorter blueprint for the K0 analytic theorem. Its present status must remain conditional paper derivation with exact scalar verification. It supplies neither a kernel theorem nor evidence that a full sign search succeeds.
