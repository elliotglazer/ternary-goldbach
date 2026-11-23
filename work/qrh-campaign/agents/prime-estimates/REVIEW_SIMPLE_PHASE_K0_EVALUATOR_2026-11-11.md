# Independent review of the simple-phase K0 evaluator

2026-11-11. **PASS as a conditional paper derivation with exact scalar evidence.** No blocking correction was found. The combined plan replaces both uses of the sharp Gamma phase and preserves a `.47*t^(-3/4)` evaluator allowance uniformly for every real t>=1500. The remaining contour, analytic-identity and arithmetic-checker proofs are still required. This review supplies no Lean theorem or sign certificate.

## Frozen versions and independent checks

All paths below are relative to `work/qrh-campaign/agents/`.

| Reviewed input | SHA256 |
| --- | --- |
| `major-constants/SIMPLE_PHASE_K0_EVALUATOR_2026-11-11.md` | `130CFDB71B26FA5E8E072E0B42A2241F41F0366AF077BED1589EAB6E019BAEEB` |
| `major-constants/simple_phase_k0_scalar_20261111.py` | `E7E29201C1F5A502AE6C7B0D6D93ADBA1499392151E18C71978FA86967FB58C4` |
| `major-constants/simple_phase_k0_scalar_20261111.json` | `480D649AFC574C8420ACA1DE4A51F46A598E93DBC447621184AE133081A85CB5` |

The independent preparation read the low-order K0 blueprint `8A65614D...1DD713` and its source audit `7B40483351FFAFAEF7039BC89E02C89A4F292A13BAB3281C1CF7482D9D4F51D1`. It also uses the coarse-phase note `C7B701CF...1FC6E79` and its independent review `DE019E48942C1999785FA8F14BC4CD65CAD7C4423038965FA0DEF96DD8BC75D0`. Those are precisely the versions in the new note's input table.

The author's scalar program was executed with its output path redirected into this reviewer's directory. Its JSON replay was byte-identical to the frozen receipt, and its source and receipt hashes remained unchanged. The replay is `prime-estimates/review_simple_phase_k0_author_replay_20261111.json`, with the same hash `480D649A...A85CB5`; the captured log is saved alongside it.

A separate exact `Fraction` calculation imports no author code and uses no special functions, native interval library or spectral data. It passed 15 assertions with exit 0:

| Independent artifact | SHA256 |
| --- | --- |
| `prime-estimates/review_simple_phase_k0_scalar_20261111.py` | `F7A31D9140745364C0E335CA09BD4DDA784FFA923C5B14C163AE4CFE7FFEFA08` |
| `prime-estimates/review_simple_phase_k0_scalar_20261111.json` | `5A04F9B72ACD3AC56580A0DB47AB14D5A7E29C709F75C34D5F53DE5332897907` |

These executions check rational composition only. The analytic steps below were checked mathematically against the cited source contracts.

## 1. The exact real function and floor domains

The evaluator uses the actual normalized theta approximation

`thetahat(t)=t/2*log(t/(2*pi))-t/2-pi/8+1/(48*t)`.

The source target remains Mathlib's real `hardyZ`. I reread the pinned `NumberTheory/LSeries/HardyZ.lean:76,79` and `Analysis/SpecialFunctions/Gamma/Deligne.lean:46`. They define HardyZ using completed zeta divided by the modulus of Gammaℝ, and Gammaℝ using `pi^(-s/2)*Gamma(s/2)`. The required normalized-Gamma adapter therefore has the stated positive sign. Equality of absolute values alone would not suffice, and the note correctly retains the adapter as a proof obligation.

For a=sqrt(t/(2*pi)), N=floor a and z=1-2(a-N), the geometry gives N>=1 and -1<z<=1 at t>=1500. The original integer-a branch is N=a,z=1. The finite approximation need not be continuous there; actual HardyZ supplies continuity for subsequent zero-existence arguments. No endpoint is omitted from the proposed pointwise estimate.

F means the continued quotient, not Lean's raw division at a zero denominator. At either z=1/2 or z=-1/2, the numerator and denominator vanish and the derivative ratio is 1/2. Those removable values match the stated source function. An interval spanning either point still needs the nonsingular evaluator or analytic continuation proof. The note explicitly includes that requirement.

## 2. Coarse phase suffices for U

The accepted phase construction gives the genuine analytic logarithm L of Gamma, real on positive reals, normalized at 1. Its H(1) subtraction is real and cannot change theta. The new note uses this normalization without a principal-log-of-Gamma substitution.

The independently reviewed polynomial-integral argument yields

`|theta-thetahat| <= 1/(4*t^2)+23/(384*t^3) < 13/(50*t^2)`.

Thus

`|theta-theta0| < (1/48+13/(50*t))/t < 1/(40*t)`

for t>=1500, since the last inequality requires only t>312/5. Dividing by `tau^2=1/(8*t)` at the worst endpoint gives the exact coefficient `3151/18750 < 1/5`. This establishes the precise weak phase premise consumed by the low-order remainder.

For `U=exp(i*(theta0-theta))`, real phase gives |U|=1 and |U-1|<=|theta0-theta|. I directly inspected `Real.norm_exp_I_mul_ofReal_sub_one_le` in pinned `Analysis/SpecialFunctions/Trigonometric/Bounds.lean:286`; it has exactly this meaning after the harmless order of complex scalar multiplication is normalized. Therefore `|U-1|<tau^2/5` follows without Gabcke's three-term phase theorem.

The first use of the sharp phase is now genuinely removed. The coarse sign-proxy estimate below .347 would not suffice for this argument, but the new O(1/t) bound does.

## 3. The .45 analytic reduction remains valid

The separate source audit established the low-order reduction conditionally on its stated analytic ingredients. The new note reuses exactly those ingredients, replacing only the weak U estimate just checked.

In particular,

`S=B0+B1*tau+RS1`, `|RS1|<4.2*tau^2`,

`|B0|<=1`, `|B1|<8/5`, `Re B1=F'''/(3*pi^(3/2))`,

and `|F'''|<=4*pi` have unchanged domains. Since tau<1/40,

```
US = B0+B1*tau+E1,
E1 = (U-1)(B0+B1*tau)+U*RS1,
|E1| < [4.2+(1/5)(1+(8/5)/40)]*tau^2
     = (551/125)*tau^2 < 4.41*tau^2.
```

Taking real parts and including the original a^(-1/2) prefactor gives the same coefficient bound

`3317717799/7457500000 < .45`.

The independent script reconstructed that exact rational number using `(2*pi)^(1/4)<198/125`, pi>157/50 and sqrt(t)>38. The prefactor has already been included; multiplying by it again would be incorrect. No change to the P1/P2 correction indices, RS1 definition, or derivative normalization occurs.

This argument does not claim that the printed primary source states `.45` directly. It remains a new mathematical consequence of the audited low-order source inequalities. Their analytic proofs are not supplied by the scalar script or by this composition review.

## 4. Global phase sensitivity and final allowance

For N>=1, monotonicity of x^(-1/2) on [1,infinity) gives

```
sum_(n=1..N) n^(-1/2) <= 1+integral_1^N x^(-1/2) dx
                     = 2*sqrt(N)-1.
```

This includes N=1. Since N<=a,

`2*sum n^(-1/2) <= 4*sqrt(N)-2 < 4*sqrt(a)=4*(t/(2*pi))^(1/4)`.

Pinned `Real.abs_cos_sub_cos_le`, `Trigonometric/Bounds.lean:283`, bounds each cosine difference by the common real phase difference. The F correction contains no theta, so it cancels exactly when comparing Z0 and Zhat0. Consequently

```
|Z0-Zhat0|
 < 4*(t/(2*pi))^(1/4) * 13/(50*t^2)
 = [26/(25*(2*pi)^(1/4)*t)] * t^(-3/4)
 < [26/(25*t)] * t^(-3/4).
```

Every power manipulation has a positive base. The last step needs only 2*pi>1. For all t>=1500 the relative coefficient is at most `13/18750`, so

```
|Z-Zhat0| < (16901/37500)*t^(-3/4)
         < .451*t^(-3/4) < .47*t^(-3/4).
```

The author's `33802/75000` is the same rational coefficient. This is a uniform argument using monotonicity of 1/t, not an endpoint experiment. There is no upper height restriction. In particular the proof does not apply the older fixed amplitude 80 above one million.

The two phase effects are distinct. The weak U estimate controls the analytic correction when deriving actual-phase Z0. The finite-sum Lipschitz estimate then controls replacing theta by thetahat in the main sum. Bounding both is conservative and does not omit a phase contribution.

## 5. Numerical checker interface and arithmetic room

The proposed `[l-e,u+e]` enclosure is valid if `[l,u]` is a proved enclosure of Zhat0 and e bounds `.451*t^(-3/4)` from above. The interval arithmetic error is already in `[l,u]`; it must not be discarded.

The alternative point-value formulation is also sound: if its arithmetic error is at most `.019*t^(-3/4)`, then the strict analytic bound below `.451*t^(-3/4)` keeps the total strictly below `.47*t^(-3/4)`. The endpoint arithmetic is exactly `.47-.451=.019`. This is a requirement on a future implementation, not an assertion that existing pilot calculations meet that error target.

The note retains all necessary floor, removable-point, interval-input and strict-sign checks. No sign chain or success probability follows from this pointwise error bound. Completeness still requires a separately certified total zero count and the actual-HardyZ continuity and multiplicity arguments.

## 6. Dependency removal and remaining scope

The combined route removes the sharp phase expansion, its `1/(3322*t^7)` remainder, RU and order-10 U approximation from both the weak-U input and the runtime phase formula. It does not remove normalized Gamma, the HardyZ adapter, rotated Gamma moments elsewhere in the contour derivation, or the Riemann–Siegel integral itself.

The new note correctly carries the earlier source correction: the cited Mordell route needs parameters 1, 2 and 1/2. It does not silently reuse the original blueprint's incomplete list. It also restores the incomplete-Gamma domain `a>=1,x>a`; the selected 3/2,5/2,7/2 parameters and tail thresholds satisfy it.

The pending special-Mordell reconstruction is labeled as awaiting independent review at assembly time. This composition review does not certify that separate proof. Other remaining analytic tasks are the contour orientations and closing-edge limits, integer-a indentation, exact saddle identity, Rg1 integrating-factor and pole cancellation, four-range Gaussian estimates, Ftilde moment/derivative bounds, and the source HardyZ equality. Primitive interval soundness and actual witness checking remain separate work.

The version-bound verdict is therefore a sound simplified paper evaluator plan, with exact arithmetic evidence and no new final-theorem assumption. It is not a compiled theorem, a complete spectral certificate, or a final Goldbach result. No producer file, canonical source, dependency, or frozen report was edited during this review.
