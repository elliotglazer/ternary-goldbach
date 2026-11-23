# Independent review: finite rational elementary budget

2026-11-11. **PASS at paper/source and exact-scalar scope.** The specified finite truncations and named-rounding schedule pay the fixed small-EM phase, moment, normalized FFT, contraction, full correction and coefficient-assembly allowances. This is stronger than a convergence-only accuracy assertion. It is not a computation of any elementary center, coefficient, transform or panel, and it does not accept the immutable earlier receipt. No author file was changed; no evaluator was imported; no Lean/Lake command or function evaluation was run.

## Frozen inputs and independent evidence

All paths in this table are relative to `work/qrh-campaign/agents`.

| Artifact | SHA256 |
|---|---|
| `major-constants/FINITE_EM_RATIONAL_ELEMENTARY_BUDGET_2026-11-11.md` | `50D1FFB0385A0F2FCE3BA9EF3BBB4FFD3BAC5A0103E95A8329E79A25D524A541` |
| `major-constants/finite_em_rational_elementary_budget_20261111.py` | `34CEDFEA0AED31B17BCA3BAE4BE9B244CAFD0A0B4E19D9A197546623E598D9C2` |
| Its JSON | `75989A56D3D376CDDF2573B7938B2B5133ABBC1A3E11B14FFBCA4D9772A017C1` |
| `major-constants/EM_SMALL_BATCH_FULL_BUDGET_2026-11-11.md` | `47256C6265C63BF1851B0FD7347F57BC18849AA7B629FFA72442EF9D05A22D23` |
| `prime-estimates/review_finite_em_rational_elementary_budget_20261111.py` | `654D481908A97BC1C374421D8A78F1C7E2F458A98804E21783186D1C72715BD3` |
| Its JSON | `F4A7B7CA6072C01CEBA5578F5026450C7889A4F06CC3FF1CCD1E2BFA7E7922D2` |

The independent program exits 0 with **422 checks**. It imports only standard-library integer/rational/file utilities. It checks the three author pins, reconstructs all bound families, checks the 384 separate `(h,m)` moment perturbations with their actual factorials, and compares the reconstructed recorded quantities or stronger bounds with the frozen scalar JSON. It uses a sharper two-term Machin tail and the exact squaring error recurrence as independent cross-checks. It does not run or import the author program. Its finite operation counts are structural counts, not runtime measurements.

## Elementary source and finite lengths

I inspected the actual pinned Mathlib source at commit `56a005855ea17e0b0958f73ec801ae140b0a1679`:

* `Mathlib/Analysis/Complex/Exponential.lean:377,407`: `Complex.exp_bound` and `Complex.exp_bound'`. The latter has exactly the premise `norm(z)/(n+1)<=1/2` and remainder `2*norm(z)^n/n!`; file SHA `564992EF54C295F97D4E00CA0D07A396C068F331D09EFD29B85E4863511986F0`.
* `Mathlib/Analysis/SpecialFunctions/Trigonometric/Arctan.lean:336`: Machin's identity is stated as `4*atan(1/5)-atan(1/239)=pi/4`, so multiplying by four gives the formula used here; file SHA `D254AD003E12CF734BD536A23060D93E262B3577AFC977CC631FF1C7BB23A6EC`.
* `Mathlib/Analysis/SpecificLimits/Normed.lean:1041`: `alternating_series_error_bound`, with antitone and summable hypotheses; file SHA `29AA06CCC31F1BFD454DBF888C108F4C3FBE8AA5A9AEDE4F95D3D7473C03EE70`. Both arctangent inputs are strictly inside the convergence domain. `Real.hasSum_arctan` is in `Analysis/SpecialFunctions/Complex/Arctan.lean:144`.
* `TernaryGoldbach/Prelim/RamareHarm.lean:31`: `RamPf.log_one_add_inv_bounds` has the stated geometric atanh remainder; file SHA `C3B8A2152965C022E8D2D1C7AC6871742D71E6954FE8B891EB6F50A291BBA688` at target pin `23b2d68ca344203d4384e0aff7affa4ec034bef9`.
* `Mathlib/Analysis/Complex/ExponentialBounds.lean:44`: `Real.exp_one_lt_three` supplies the coarse exponential bound used in the propagation proof.

With `eta=2^-1024`, the 512-term log series has remainder bounded by `11*2*3^-1025/(1025*(1-1/9))`. The factor 11 includes the at most ten copies of log 2 and the scaled mantissa. The `u=1` boundary uses `log 1=0`, rather than substituting into the wrapper's strictly positive `1/(u-1)` parameter. Log 1 is exact. The 256-term Machin sums have total error at most `16/(513*5^513)+4/(513*239^513)`, strictly below the author's coarse `20/(513*5^513)`. Both finite tails leave the stated rounding margin.

The signed real-exp argument divided by 16 lies in `[-1/2,0]`. Four squarings of a rational approximation are controlled by `e_next<=e*(2+e)`, since every true intermediate value is at most one. The independent replay checks each small-error premise and domination by `3^4*d0`. For the cis factor, nearest reduction uses the rational pihat, but periodicity uses true pi: the argument error is explicitly `2*|k|*|pihat-pi|`. The bounds `|k|<2^12`, `|r|<4` and `4/514<1/2` verify the complete 513-term remainder. The unit-speed Lipschitz estimate on the imaginary exponential follows by integrating its derivative on a real interval. The resulting complex primitive error is below epsilon=`2^-512`.

These primitives are for exact rational arguments. Errors in the actual log arguments are propagated separately. No branch choice or midpoint-to-interval substitution is being concealed in the primitive contract.

## Phase, bins, moments and FFT

The actual eight centers have norm below 2001; their rational imports and sigma are exact. Log centers are required to lie in `[0,8]`, so every needed exponential has real part in `[-8,0]` and imaginary part of magnitude below `2^14`. The line-segment exponential perturbation gives phase error `(3*2001+1)*epsilon<2^13*epsilon` including elementary evaluation. The norm of an approximate phase is below two.

For bins, the explicit ratio perturbation is at most `(2/3+16/9)*epsilon<3*epsilon`. Nearest rounding is applied only to the rational xhat. The integer q has absolute value at most six. Retaining this signed q in the residual gives error at most `(1+6/2)*epsilon=4*epsilon`; reducing q modulo 32 there would be wrong. All zero-power, h=0, m=0 and n=1 cases are covered. A new q need not match an old receipt's q; accepting that old receipt would require a separate identity/containment check.

For every `0<=h<16,0<=m<24`, I independently bounded the powers by `8^h/h!` and `2^m/m!` and their perturbations by `8^(h-1)/(h-1)!*epsilon` and `2^(m-1)/(m-1)!*4*epsilon`, with zero derivatives at exponent zero. The full telescoping product bound is below `2^82*epsilon` in all 384 cases. Summing at most 1024 terms and rounding once yields the claimed bucket allowance. The norm bound `2^80` concerns the newly serialized rational centers themselves, so it is suitable for the FFT recurrence.

Each positive normalized butterfly computes exact rational `(u+/-w*v)/2` before its one declared output rounding. Twiddle error below `4*epsilon` gives exactly

`E_(l+1)<=(1+2*epsilon)*E_l+2*epsilon*2^80+epsilon`.

Five stages fit `2^-110`. Bucket uncertainty is transported by the normalized transform with operator norm one. It is separate from the transform arithmetic error. The negative output index `-j mod32` and final scale 32 are retained. Up to 24 Horner roundings, then scaling and a final rounding, cost at most `769*epsilon`. The resulting main-jet error fits `2^-98`. Correlation between reused approximations does not affect these triangle-inequality bounds.

## Correction, assembly and panel scope

In section 5 of the author note, **b_m must be read as the normalized coefficient `B_(2m)/(2m)!` from the pinned finite-EM formula**, not the raw Bernoulli number. This is the source-consistent interpretation of its `|b_m|<=1` statement. The inherited bound `|B_(2m)|/(2m)!<=4/6^(2m)` implies it for all sixteen terms.

After scaling every rising affine factor by B=1025, its coefficient l1 norm is less than `2048/1025<2`. Therefore the polynomial C has l1 norm below `1/2+16*2^31`; multiplying by `c_j-1+z` and adding B gives Q norm below `2^48`. The `+B` is essential: it includes `H=B^(1-s)` in the same exponential factor. Exact old-array polynomial recurrence and truncation above degree 15 preserve the retained coefficients. The exponential coefficient array's l1 norm and its log-parameter derivative norm are both bounded by exp(8)<2^13. Combining this with the separately evaluated constant phase and one final correction rounding gives the complete, already multiplied correction error below `2^-80`.

The new schedule evaluates eight constant correction phases directly. It does not rely on the earlier native producer's height-step phase recurrence. That change preserves the finite expression and removes, rather than silently ignores, that recurrence's rounding error.

Final assembly includes both `(c_j-1)*S_h` and `S_(h-1)`, with the latter zero when h=0. Its combined main-error multiplier is below 2002. The p=24 analytic batching remainder is included once. The resulting coefficient midpoint error is below `2^-53`, so coordinate halfwidth `2^-52` is sufficient.

The inherited quotient ledger concerns the **actual vertical panels**, where offsets are purely imaginary and powers act by real scaling and quarter-turns. It must not be exported unchanged to arbitrary complex offsets without the appropriate coefficient-square norm conversion. The ledger already includes conversion by 3/2, division by `|s-1|>2^10`, finite-g Taylor and EM errors, and a separate final polynomial/quotient arithmetic allowance `2^-64`. The independent replay reproduces its bound below `2^-44`.

That last arithmetic allowance remains an explicit acceptance gate, not an enclosure generated by this scalar note. Exact rational interval polynomial/division operations are an available way to incur no additional roundoff before an explicitly checked output rounding; a different rounded implementation must prove it meets `2^-64`. A wide interval image is not itself an arithmetic error or evidence of nonvanishing. No new half-plane, winding or sign claim follows here.

## Finite schedule sizes, without a performance inference

The following counts follow from the specified dimensions, independently of coefficient values:

| Item | Count or safe upper count |
|---|---:|
| Moment contributions | 393,216 |
| Completed bucket rounding gates | 12,288 |
| Length-32 transforms | 384 |
| Normalized butterflies | 30,720 |
| FFT output rounding gates | 61,440 |
| Horner affine rounding gates | at most 3,072 |
| Final Horner scale rounding gates | 128 |
| Complete correction rounding gates | 128 |
| Final assembled coefficient rounding gates | 128 |
| Total non-elementary gates just listed | at most 77,184 |

One finite elementary cache can use at most 1025 length-512 log series (log 2 plus all nontrivial scaled inputs), two length-256 arctangent series, and at most 1064 complex-exp calls: 1024 baseline phases, eight correction phases and a full 32-entry common twiddle table. Each complex-exp call uses two 513-term polynomials and four squarings. Lower-stage twiddles are exact selections from that common table. Exact zero logs/phases and duplicate twiddles may reduce these upper counts. This specifies a finite implementation option; it is not a claim that the author's proposed or existing code has already implemented this cache.

All intermediate field arithmetic between the listed gates is exact rational arithmetic. Thus these counts do not bound numerator/denominator lengths, expression sharing, elaboration, kernel reductions, memory or wall time. They cannot justify a speed comparison with the native pilot or a production-height estimate.

## Acceptance boundary

No missing finite precision bound was found for the stated named-gate schedule. Formal elementary wrappers, source coefficient identities, exact finite witness construction, serialized-radius checks, final interval arithmetic and kernel acceptance remain work. In particular, the note allows fresh internal bin choices and centers; it does not prove that its future enclosures fit arbitrary immutable old moment, FFT or coefficient boxes. Full containment and matching source expressions remain mandatory. The earlier native success is not used as a premise of this review.
