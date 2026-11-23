# Psi from the shared finite strip: a conditional tail, with a finite gap

The shared finite zeta assertion, together with genuine global QRH, is sufficient on paper for

`|psiR(x)-x| < .0081*x/log(x) < .01*x/log(x)` for every `x >= exp(35)`.

This uses the source Gaussian explicit formula and its positive-smoothing sandwich, plus the multiplicity-aware translated xi mass estimate already reviewed for the principal major-arc route. It does **not** establish the requested envelope starting at `1e9`. The bound below first crosses `.01*x/log(x)` numerically at approximately `6.6696e14`; the deliberately rounded, uniformly checked threshold is `exp(35) = 1.586014e15`. That crossing belongs to this particular estimate and parameter choice, not to an optimal method or to actual prime errors.

The remaining interval for the sufficient Möbius input is therefore `[1e9, exp(35))`. The existing finite sieve evidence used in the prime chapter stops at strict `1e9` and does not fill this gap. The assertion about finite zeros and the global provider are themselves still validation obligations. No Lean was run, no canonical source was edited, and no finite zero or prime certificate was produced.

## Inputs and source contracts

Target source root: `work/ternary-goldbach/TernaryGoldbach`, campaign pin `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

Assume only for this research implication:

1. Every actual nontrivial zeta zero with `|Im rho| <= H`, where `H=60343058`, has `Re rho <= 111/200`. Reflection gives `89/200 <= Re rho <= 111/200` on the same closed height range. This is the principal component of the shared major-arc finite condition, not RH.
2. Every actual nontrivial zeta zero has `Re rho <= 7/8`. The genuine provider must be checked separately; this report supplies no substitute axiom.
3. The unconditional translated xi mass bridge is formalized with true multiplicities:

   `sum m_rho*(2-beta)/((2-beta)^2+(gamma-c)^2) <= 3 + .5*log(1+|c|/2)`

   for each finite subset of actual nontrivial zeros. This was independently paper-reviewed in `RESUME_PRINCIPAL_REVIEW_2026-11-11.md`. Its source entry is `Explicit/XiPartial.lean:776`, with the digamma estimate and divisor-multiplicity bridge still needing implementation. It is not an additional zero-distribution conjecture.

Unconditional source ingredients:

- `Explicit/GaussSmooth.lean:355`, `norm_intExp_le'`, bounds the Mellin integral by `(exp(a*beta)+exp(b*beta))/|rho|`; the Gaussian factor is exact. This also handles a possible real zero, without assuming a minimum zero height.
- `Explicit/ZetaZeroSums.lean:106`, `norm_Mg_strip_le`, retains Gaussian ordinate decay. Lines 526–530 define `EBg`, `rhoG`, and prove `tail_sum_gauss`.
- `Explicit/ZetaExplicit.lean:122,173`, `explicit_formula_zeta_seq` and `explicit_formula_zeta`, supply the common good-height limiting formula.
- `Explicit/PsiExplicit.lean:47,51` give `Vg` and `norm_integral_hZeta_gsm` on the line `Re s=-1/2`.
- `Explicit/PsiLarge.lean:296,326`, `psi_upper_of_err` and `psi_lower_of_err`, convert a smoothed error into ordinary psi bounds. Their underlying coarse bound is the unconditional `psiR(y)<=4*y`.

Do not call `SsumG_gsm_errH` at `PsiExplicit.lean:119`: it takes `RHBelow H`. Reuse its finite-rectangle triangle/limit proof with the bounds below. Likewise, the existing high-tail theorem has an `x` factor; proving its `x^(7/8)` variant requires replacing the single pointwise use of `beta<1` by the genuine upper strip. Neither substitution follows merely by changing the theorem arguments.

## Parameters and low zeros

Write `L=log x`. For `L>=35`, choose

`K=sqrt L`, `delta=1/(1000*L^(3/2))`, `a=+/-K*delta=+/-1/(1000L)`, `y0=10000`, `b=log(y0/x)`.

Both sandwich domains hold: `b<=-K*delta`, `y0*exp(K*delta)<=x`, `0<delta<=1`, and `delta<=K`. Varying K is necessary: a fixed K would leave a constant Gaussian leakage which could not stay below `.01/log x` for arbitrarily large x.

For any interval of ordinate length 3 intersecting `[-H,H]`, put its center at c. Then `|c|<=H+3`, so `log(1+|c|/2)<18` and the mass bound is `<12`. On that interval, `|gamma-c|<=3/2`. For the selected low zeros, `2-beta` lies within `[9/8,15/8]` (in fact a smaller interval), and

`(2-beta)/((2-beta)^2+(gamma-c)^2) >= 8/25 = .32`.

The quadratic endpoint test proves this bound. Therefore each such interval contains total multiplicity less than `37.5`, and the safe bound 38 suffices. Partition each ordinate sign into half-open intervals `[3k,3(k+1))`; endpoint overlap can alternatively be retained since it only enlarges the upper bound. The count is for multiplicities, not distinct zeros.

In the first two sign bins use `|rho|>=beta>=89/200`, rather than an unproved minimum ordinate. In the remaining bins use `|rho|>=|gamma|>=3k`. Thus

`sum_low m*exp(-delta^2*gamma^2/2)/|rho|`

` <= 76/(89/200) + (76/3)*[2+log(2/(3delta))] = C(L)`,

where

`C(L)=76/.445+(76/3)*(2+log(2000/3)+(3/2)*log L)`.

For completeness, the Gaussian harmonic estimate follows by taking `J=ceil(1/(3delta))`: the first J terms are at most `1+log J`; for the tail, integral comparison and `u>=1` give

`integral_1^infinity exp(-u^2/2)/u du <= integral_1^infinity u*exp(-u^2/2) du < 1`.

Also `J<=2/(3delta)`. This bounds every finite low-zero subset uniformly, including when the outer explicit-formula rectangle cuts through a bin.

Since `2*exp(delta^2/2+|a|)<2.001` and `x^(beta-1)<=x^(-89/200)`, the normalized low-zero error is bounded by

`E_low(L)=2.001*C(L)*exp(-.445L)`.

At L=35, `L*E_low < .006285`; the simpler allocation `.007/L` is valid for all L>=35. Indeed `L*C(L)*exp(-.445L)` decreases there: `C'(L)=38/L`, and `1/L+38/(L*C(L))<.445`.

## High QRH tail

The source polynomial `BPz2` and definitions of `Z3g`, `c3g` give, at this H,

`Z3g(BPz2,H)<180`, `c3g(10,H)<1e-6`.

The script certifies these using exact rational comparisons (`BPz2(H)/.355<2^300`, `log2<.7`, `log(10/3)>1.2`). Set

`A=H^2/(2*10^6)`, `B=4.4*H/10^6`, `Q(L)=1+L^3/B`.

Because `1/(1-exp(-t))<=1+1/t`, the Gaussian tail, with the global `x^(7/8)` factor, is at most

`E_high(L)=(2.001/H)*exp(-L/8-A/L^3)*(360*Q(L)+2e-6*Q(L)^2)`.

This expression includes both ordinate signs exactly as the source tail-window theorem does; no extra factor two is needed. It controls the finite high-zero portion uniformly in the outer rectangle height.

The uniform estimate `L*E_high(L)<2e-9` is easy despite delta tending to zero. On `35<=L<=200`, drop `exp(-L/8)`, replace L and Q by their upper endpoint, and retain `exp(-A/200^3)`; the resulting bound is `<1.05e-97`. For L>=200, discard the Gaussian, use `Q(L)<=(1/200^3+1/B)*L^3`, and maximize each `L^j*exp(-L/8)` at 200 for j=4,7. The resulting bound is `<1e-9`. Thus there is no unexamined large-x transition between Gaussian suppression and the QRH power saving.

## Vertical line and desmoothing

The exact source Vg, divided by `2*pi*x^(3/2)`, is bounded for both signs of a by

`E_vert(L)=301/delta*(exp(-3L/2)+.01*exp(-L))`.

Here `exp(-b/2)=sqrt(x/y0)`, so the second term has order `1/(delta*x*sqrt(y0))`, not `x^(-3/2)` alone. The constant 301 has slack over the source factor `(2/log2+4.8)*82.6/sqrt(2*pi)` and its tiny exponential multipliers. Existing specialized `Vg_le_gen` has incompatible delta restrictions; the direct Vg bound is required. At L=35, `L*E_vert<1.4e-8`, and both terms decrease thereafter.

Let `E=E_low+E_high+E_vert`, `r=exp(-L/2)`, and `a0=.001/L`. The exact source sandwiches give normalized upper/lower errors

`U(L)=40000*exp(a0-L) + (exp(delta^2/2+a0)-1+E+2r)/(1-2r)`,

`D(L)=1-exp(-a0)+20000*exp(-L)+E+4r`.

Both are bounds for ordinary psi; this is the step a strip-only argument cannot omit. For all L>=35, the following allocations are sufficient:

| Contribution, multiplied by L | Bound |
|---|---:|
| Low zeros | .007 |
| High zeros | 2e-9 |
| Vertical line | 2e-8 |
| Main-term shift | .001001 |
| Gaussian leakage (larger lower-side value) | 4e-6 |
| Low cutoff (larger upper-side value) | 1e-9 |
| Upper denominator multiplier | 1.000001 |

Their total is less than `.008005032`, hence less than `.0081`. For the uniform passage, `L^j exp(-cL)` is decreasing beyond `j/c`; the shift bound follows by expanding the exponential into its positive power series. These monotonicity arguments, rather than a sample grid, cover every L>=35.

## Numerical gap and what would close it

`resume_psi_finite_strip_20261111.py` passed with exact Fraction/Taylor comparisons for all endpoint allocations above. Its JSON also reports floating diagnostics, explicitly not certificates:

| x | This bound on `log(x)*|psi(x)-x|/x` | Required |
|---:|---:|---:|
| 1e9 | 2.06517 | .01 |
| 1e14 | .0206943 | .01 |
| 1e15 | .00861125 | .01 |
| exp(35) | .00728773 | .01 |

The high tail underflows in the floating diagnostics; its actual positive upper bound is handled by the rational uniform estimate above. At 1e9 the low-zero term alone is approximately `.09917*x`, while the desired envelope is `.00048255*x`. Increasing H would scarcely help this specific low-zero estimate: it already retains Gaussian suppression and is dominated well below H. Sharper zero-location/count information, cancellation, a different positive kernel, or a finite prime-error certificate is needed to reach the requested starting point. This is a failure of the displayed upper bound, not a proof that the finite strip mathematically cannot imply a better result.

In particular, the shared finite spectral certificate plus the existing finite sieve is **not yet a complete route to the sufficient Möbius profile**. A new verified finite estimate covering every integer from 1e9 through the rounded threshold would complete this particular reduction. The endpoint at 1e9 must be included: the currently reviewed sieve range is strict below 1e9. Alternatively the Möbius induction could be replayed with a larger intermediate rho envelope, but the present computation does not claim that such a replay closes `.10`.

Future Lean order: true-multiplicity translated mass; finite-strip/reflection application; Gaussian reciprocal low-sum lemma; QRH-strengthened high-tail lemma; Vg bound; finite-rectangle explicit-formula limit; both source psi sandwiches; monotone scalar allocations; conversion to `psiN(n)` at integers. The finite spectral certificate, global provider closure, and remaining finite prime interval must stay separate from those analytic bridge lemmas.
