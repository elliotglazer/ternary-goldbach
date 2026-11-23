# Independent elementary enclosure certificate at R=132900

2026-11-11. PASS at paper and external exact-scalar certificate scope. All nine consumed ghat upper bounds are independently regenerated and match the saved receipt. No discrepancy was found. No L-function, zero, prime, totient, floating-point or transcendental evaluator was run. No Lean build or source edit was made.

This closes the stated independent-regeneration gap for the selected R=132900 row. It does not certify the required finite RH data, validate a Lean proof, or recheck the other four candidate-cutoff rows.

## Scope and artifacts

The [existing mass-cutoff report](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/prime-estimates/EXACT_SOURCE_MASS_CUTOFF_2026-11-11.md) has SHA256 `429562CD92AF356BD84EED1C253D0A9E95D434262DF08CCCAC8EAF3D15CE234D`. Its [previous review](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/major-constants/REVIEW_EXACT_SOURCE_MASS_CUTOFF_2026-11-11.md), SHA256 `0B224BB58D88D63D9F787D88CA1CB33CA85C411DB8B733307064AE8D82EA84BD`, explicitly recomposed saved rational G bounds without regenerating the logarithm/root enclosures. That limitation was accurate.

The new independent [checker](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/review_r132900_elementary_enclosures_20261111.py) and [receipt](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/review_r132900_elementary_enclosures_20261111.json) use only integer arithmetic, `Fraction`, file parsing and hashing. There are no imports of the author program or mathematical evaluation libraries. The new script has SHA256 `F5F35B55B2C18C2FE15CBC01F13F152D3121395955D11B3B57136FC2192FD5CF`; its receipt has SHA256 `EE561452AFB3528AAC36AD9C353C28D7C034C97623A9F145393F3156B291B4EA`.

The completed replay verifies 34 distinct logarithm inputs, 30 root witnesses, all nine G upper bounds, their asymptotic reuse, the mass-independent supporting scalars, and 51 saved rational ceiling metadata fields. The Y list is independently bound to the nine `cell_bound` applications in the pinned `NumericsCells.lean` source. No new cutoff search was performed.

## 1. Independent rational logarithms

For 1<=w<=3/2 put z=(w-1)/(w+1), so 0<=z<=1/5. The finite geometric identity, integrated on [0,z], gives

    log w = 2*sum_(j=0..N-1) z^(2j+1)/(2j+1) + E,
    0 <= E <= 2*z^(2N+1)/((2N+1)*(1-z^2)).

Indeed the remainder integrand is 2*t^(2N)/(1-t^2), whose denominator is at least 1-z^2. This proves the lower and upper directions without calling a logarithm routine or assuming a floating-point error bound.

The independent implementation uses N=48 and reduces every x>=1 by the exact identity x=(3/2)^k*w, with 1<=w<3/2. It applies the same proved enclosure to log(3/2) and adds k times its interval. The author instead reduces by powers of 2 and uses 80 terms. The new implementation generates terms by a recurrence and uses a different reduction and truncation; it does not call or copy the author's log function.

Each independent interval is rounded outward to denominator 10^30. At every place where the recipe needs a 10^-7 upward or downward rounding, both independent interval endpoints give exactly the same rounded rational. Thus the chosen rounding is certified for the actual logarithm, not merely for one finite approximation. All arguments are positive; every nested logarithm used here has an inner value above 1. There is no extension of the source helper beyond its valid argument domain.

The original 80-term recipe is itself valid. Its z lies in [0,1/3], its remainder uses the same integrated-geometric inequality, its power-of-two decomposition has nonnegative integer exponent, and its rational floor/ceiling formulas have the correct signs. The independent computation supplies new evidence for its consumed outputs rather than relying only on that source inspection.

## 2. Root witnesses and directed substitutions

The independent root routine constructs decimal digits using only exact cross-products. For input a/b, positive integer scale S and degree d, the returned integer v satisfies

    v^d*b <= a*S^d < (v+1)^d*b.

Both differences are retained in the receipt. This is distinct from the author's integer square-root call and doubling/binary-search routine. It proves the root bracket directly; no root approximation needs to be trusted.

For each Y, the chosen u=floor(Y^(1/3)) satisfies u^3<=Y, and the sixth-root integer v satisfies v^6<=Y. Hence t=1/v is a valid upper bound for Y^(-1/6). All v are positive. The domain checks Y>=10^25, R>=670 and 6R<=u pass in every cell.

For square roots the scale is 10^7. The numerator root uses the upper endpoint and the denominator root uses the lower endpoint. In particular the independently reconstructed common scalars are

    a = 12.4904995,
    b = 13.8767938,
    logR lower = 11.7973522,
    logR upper = 11.7973523,
    c1 = 2.4678752,
    c2 = 2.4678751,
    sqrt(Fr-upper) upper = 2.3299470,
    sqrt(2R) lower = 515.5579501.

Here c1 is obtained by applying an upper log bound to the upper rounded logR, while c2 applies a lower log bound to the lower rounded logR. Monotonicity gives c2<=log(log R)<=c1. Since c2>0,

    Fr(R) <= 1.7882*c1 + 2.50637/c2.

Using c1 in both terms would not justify the reciprocal term; the actual recipe correctly uses c2 there.

For each Y, b2 is a positive lower bound for log(9u/(4.008R)). Replacing u by the lower cube-root witness makes that denominator smaller. Using b as an upper numerator and b2 as a lower denominator therefore bounds the logarithmic ratio upward. The independently certified rho is an upper bound for log(1+b/(2b2)). Finally ell bounds log Y upward and its square-root upper bound proves ell<=sq^2. All positivity and square inequalities are checked explicitly.

## 3. Exact match to the source numerical interface

The decisive source is [NumericsCore.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/NumericsCore.lean). `rpow_neg_sixth_le` at 16 and `le_rpow_third` at 25 supply the root substitutions. `hfun_le_num` at 31 uses ell, sq and t to bound

    hfun(Y) <= .276*t*ell*sq + 1234*t^2*ell.

`ghatY_le_num` at 54 requires precisely the bounds and signs reconstructed above. Its two final rational inequalities correspond to

    1.398*gx-upper + (17/3)*(670/R)^3 <= G,
    1.398*hfun-upper + (17/3)*(670/R)^3 <= G.

The checker verifies both before comparing G with the saved value. Taking a maximum after adding the common nonnegative tail and then rounding upward is correct. The underlying definitions are `Fr`, `Lg`, `gx` in `GBound.lean:25-35`, `hfun` in `LinftyLevels.lean:211`, and `ghatY` in `LinftyLevels.lean:351`. No factor of 1.398 or 17/3 is omitted or applied twice.

The complete selected list is:

| Cell | Y | Certified saved G |
|---:|---:|---:|
| 0 | 10^25 | .0635101 |
| 1 | 3*10^25 | .0630260 |
| 2 | 10^26 | .0625381 |
| 3 | 10^27 | .0617104 |
| 4 | 10^28 | .0609957 |
| 5 | 10^30 | .0598199 |
| 6 | 10^34 | .0581255 |
| 7 | 10^42 | .0560735 |
| 8 | 10^58 | .0540504 |

The asymptotic expression uses exactly the last G, not a tenth unstated evaluation. The receipt stores u, v, b2, rho, ell, square-root bound, each branch upper value and the final rounding slack for every row.

The uniform-in-y use remains the existing `ghatY_mono_y` at `NumericsCore.lean:130` and the already reviewed cell/asymptotic argument. This replay verifies their numerical inputs at Y; it does not numerically sample or replace their all-y proofs.

## 4. Mass-independent supporting pieces

The exponential constant 1.7882 is not silently treated as a new numerical oracle. `SecondNumerics.lean:66-85` bounds Euler's constant by H_128-log128 and then by .5812. The independent script sums H_128 rationally, uses its new log128 enclosure, and checks the strict .5812 bound. A separate 40-term positive exponential series with geometric tail gives exp(.5812)<1.7882. For exp x, after retaining terms 0 through N-1, the remaining terms are bounded by the first omitted term divided by 1-x/(N+1), when x<N+1. The standard Euler-constant sequence inequality itself remains the source theorem, not a finite computation performed here.

For the lower ghat guard, `GMono.lean:58-72` proves exp(gamma)>=1.5 and Fr(R)>=3.8 when log R>1. The new log interval verifies that domain, log(2R)>12, and the exact comparisons 1.7^2<3.8 and 2R<548^2 pass. The ratio term in R(Y,2R) is nonnegative under the already checked domain, so R(Y,2R)>=.41415. Dropping the remaining nonnegative terms gives exactly the saved lower expression

    1.398*((.41415*12+.8764)*1.7+2.526)/548 > .03.

This justifies comparison with the base-gap upper bound, not merely equality with a saved rational expression.

For N0=989*10^24, the independent root search proves the saved floor(sqrt N0) by its two integer-square inequalities. A new log10 enclosure proves log10<2.303. Independently constructing the 25-term exponential lower polynomial also reproduces the saved polynomial and verifies that it exceeds 10. Thus both the direct log enclosure and the original positive-series argument support the same upper direction.

The resulting nonprime allowance is exactly

    20618162523/7784250095800 < .00265.

The integer comparisons for the inherited threshold alternatives, including (2.64)^64<N0 and (6.9)^32<N0, pass. The use for every N>=N0 still uses the source's decreasing log(N)/sqrt(N) bound; it is not a claim that log N<=27 log10 for arbitrary larger N. That upper logarithm is used at N0<10^27 after monotonicity.

The major-error rational expression, singular lower bound and base-gap expression were recomposed exactly. All 51 selected saved `ceil_1e9` metadata entries have the correct directed ceiling. These are additional consistency checks; they do not turn a rational receipt into spectral evidence.

## 5. Recomposition and remaining proof status

Using the independently regenerated G values and the previously reviewed source checkpoint at 132000, the checker reproduces all nine finite minor bounds and the asymptotic minor bound. Every coefficient multiplying an upper G is positive, so the substitution direction is valid. The selected base-gap bound is below .014, hence below the certified .03 lower ghat bound.

The exact smallest joint margin remains

    17454234627055702473150105611895106422794893597
    /12867056213564954145112500000000000000000000000000
    > .0013565.

The old source-cell chain coefficients and finite mass theorem are still the earlier reviewed inputs; this task did not re-evaluate their integrals or totients. It did bind their source bytes, check the selected checkpoint literal and Y list, and verify the composition using the newly certified elementary bounds.

The external certificate now covers the previously missing elementary enclosure work at R132900. Formal implementation of those finite rational witnesses, compatible source/kernel validation, localized original-RH consumers and the finite spectral data remain separate obligations. Other candidate cutoffs were not regenerated, no optimum is asserted, and the final theorem's assumptions or ranges are not changed by this review.

## Pins

The checker records and verifies all nine source/input pins below before computing. Its output also binds its own source hash.

| Artifact | SHA256 |
|---|---|
| `prime-estimates/source_mass_joint_cutoff_20261111.py` | `F243DD01285D8FA78F72A38AFFF1F2842436D4110F1E7B616B2111DB6712488A` |
| `prime-estimates/source_mass_joint_cutoff_20261111.json` | `67F6C3BAE93EDE7BD93C49A4EC8B442671A921D9E71B5AEC4925031261984FC9` |
| `MinorArcs/NumericsCore.lean` | `4E2D5351E5BFD0350FBD3B378B123CA1F7155943D467CB4788554800B657F6F8` |
| `MinorArcs/NumericsCells.lean` | `5192960AD541DCF981C630F538B35EC63FE966A61044AF31576AB83C93A41139` |
| `MinorArcs/GBound.lean` | `79070A7DD3B3B755A34C3C39690674193CBCF439238D763EB4982889E5B52491` |
| `MinorArcs/LinftyLevels.lean` | `12605A6C6B8E97BA5ABADEC4F761E322F8C04E8D4C6557AC5BE1084194EA6409` |
| `MinorArcs/SecondNumerics.lean` | `9EFE248D96FA776558A71D1420E9D22C97F431EAE70A91B83935A7B6C292717C` |
| `MinorArcs/GMono.lean` | `04C5EDB300E1F256C4B632B6CCA86D949E4E19D846776EB4B05757FC9B7227E1` |
| `Prelim/SmallMuPhi.lean` | `7ECE1D48D9679ECF529A5566C79D06FADB3CA70CCAF057ADAA020D6AA390BADF` |
