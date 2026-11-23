# Independent review of the two principal wave blocks

2026-11-11. **PASS for both complete bounded blocks.** All 34 sample points, 416 initial waves, 416 rotations, 6,656 center updates and 7,054 direct summands passed independent review. I found no floor-activation, phase, correction, norm-radius or final-enclosure defect. No producer correction is requested.

This accepts an external arithmetic experiment under the reviewed source and paper identities. It does not establish a Lean proof, a full sign chain, a zero count, or spectral coverage. No high-height EM, builtin zeta, Gamma, Riemann–Siegel, FFT, Lean/Lake command, dependency change, or canonical/frozen edit was used.

## Pinned artifacts

Paths are relative to `work/qrh-campaign/agents/` unless otherwise stated.

| Producer/input | SHA256 |
|---|---|
| `prime-estimates/PRINCIPAL_BLOCK_WAVE_PILOT_2026-11-11.md` | `B6CB1D560AA1620E53B67E7E570926EB04536E6E4F53E9A6C5DD985369F246EC` |
| `prime-estimates/principal_block_wave_pilot_20261111.py` | `A35976CBB906FA01A8F275C1C6262DD55835D442A179DEC1CEA22471FA132F34` |
| Its same-stem JSON | `B3C699860BBE37132305DD5C23AC5FDC1E82742AF85F97C3E75EA98FDC9BDA56` |
| Reused `prime-estimates/principal_k0_point_certificates_20261111.py` | `9A84F801745C8F9DD7CAD2F0E41F7633F8AFB850895C68845D4119E675543A22` |
| `work/qrh-blueprint/turing-scalars/PRINCIPAL_BLOCK_WAVE_ERROR_2026-11-11.md` | `F93CEC28EB94AB14BF6F10B74828C39D0634AA11D7D9A400377A8A4302D20EE0` |
| `mellin/REVIEW_PRINCIPAL_BLOCK_WAVE_ERROR_2026-11-11.md` | `B0D2C9233FF50EC1F82514E032E1D5B8BA3E74AA5731C22E452821E29A69E6A0` |

New independent replay files:

| Artifact | SHA256 |
|---|---|
| `independent-feasibility/review_principal_block_wave_pilot_20261111.py` | `33D837BF526576C6C00D797422D54849DBE646B79512D442C46F2E351D6E6E12` |
| Its same-stem JSON | `7463203723CB4307697CB958DE5C1C693745EDE6B28EF0EEAB0741752DE5DEA2` |

The replay uses the separately written direct Khat evaluator `independent-feasibility/review_k0_point_certificates_20261111.py`, pinned at `97622AE1D4402C3BB73483C34438E493514570ED965C446A897419BEBE53BBCD`. It imports no producer implementation and does not call that helper's optional EM routine. The direct arithmetic uses 320-bit dyadics, Machin truncations 40/16, 64 log terms, degree-80 cosine, and 32 sinc terms, versus the producer's 128-bit elementary arithmetic and 48-bit wave centers.

The actual HardyZ interpretation remains the reviewed Khat assembly at `E14AC6ADC47771795B75142340962F9FEA95BC499049D7BBD0D4103B7019B6D6`, with review `A39ED6F31EE45499080BD95357B453F065F0FFEEE78AFDC9B794775460A73633`. The present experiment does not add a new analytic premise.

## 1. Exact grids and floor activation

Both grids have h=1/64 and B=16, hence 17 retained samples t_j=t0+j*h. The independently checked geometry is:

| M | k | t0 | top |
|---:|---:|---|---|
| 18 | 130288 | 16285/8 | 16287/8 |
| 398 | 63698027 | 63698019/64 | 63698035/64 |

The integer k is certified by equal floors of 128*M^2 times the lower and upper rational pi bounds. The entire uncertainty interval for the exact cutoff 2*pi*M^2 lies strictly between t_8 and t_9. Each t_j separately satisfies the strict certificate `2*pU*N^2<t_j<2*pL*(N+1)^2`.

Thus N=M-1 for j=0,...,8 and N=M for j=9,...,16. The independent direct evaluator obtains exactly the same N at every sample. Both blocks lie strictly above 1500 and below one million. All grid quantities are rational; no floating cutoff was used.

All M waves are initialized at t0 and propagated for every step. In particular the initially inactive Mth wave has already undergone nine checked updates when it first enters the active sum at sample 9. The state lists have length M even before activation. Each block has its own initialization; no error radius is inherited from the other block.

The exact irrational cutoff itself is not one of these rational sample heights. Its closed-endpoint analytic treatment belongs to the accepted Khat assembly. This pilot checks the branch changes on both sides and does not assume continuity of the truncated Khat expression.

## 2. Initial and rotation enclosures

The exact wave and rotation conventions are

```
w_n(t)=n^(-1/2)*exp(-i*t*log n),
r_n=exp(-i*h*log n),
w_n(t_(j+1))=r_n*w_n(t_j),     |r_n|=1.
```

The negative sign agrees with `2 Re(exp(i*thetaHat)*sum w_n)` in the source Khat formula. I independently enclose all 398 log/root table entries, each of the 416 initial-wave values and each of the 416 rotations. Their tighter enclosures are contained in the producer boxes. Multiplication by t0 and h occurs before the trigonometric enclosure, so log uncertainty is charged at the correct scale.

The producer's trig routine is the already reviewed finite exponential-coordinate construction: the full argument interval is reduced with a certified pi interval, its midpoint uses even/odd powers below degree 48, the tail is 2*4^48/48!, and the reduced input radius is included by the global sine/cosine Lipschitz bound. The whole reduced interval must be inside [-4,4]. No assumption about a narrow midpoint alone is made.

For each box I recompute its 48-bit center using exactly `floor(2^48*x+1/2)/2^48` on each midpoint coordinate. I also recompute the recorded radius as the sum of the maximum coordinate distances to that center. This L1 bound dominates the Euclidean norm and therefore meets the theorem's norm-error contract. It is not an unconverted pair of coordinate error bounds.

All initial radii satisfy E0=e/(64*M). All rotation radii satisfy `delta=min(1/(2*B),e/(128*M*B))`. The rotation centers are not assumed to lie exactly on the unit circle.

## 3. Every center update and propagated radius

Starting from those initial centers and radii, the reviewer recomputes all complex products q_n*v_(n,j) as exact rational pairs, applies the specified rounding, and compares both coordinates to the next stored state. It independently computes each update's L1 rounding error and checks it is at most eta=e/(128*M*B). All 6,656 updates agree exactly; the per-step maximum and sum summaries are recomputed from the individual updates rather than trusted.

For each wave the stored radius is exactly

```
R_next = R + d_n*(abs(v.re)+abs(v.im)) + b,
```

where d_n is its actual rotation radius and b is the recomputed center-update error. The mathematical split is

```
r_n*w-v_next = r_n*(w-v) + (r_n-q_n)*v + (q_n*v-v_next).
```

Because the exact r_n has modulus 1, the norm is bounded by R+d_n*|v|+b, which is at most the stored expression. This proof does not need |q_n|=1 and does not omit a cross term. It is valid with correlated initial/rotation errors.

All 7,072 stored wave states are covered by the initialization and update checks. Every actual stored radius is nonnegative and at most the declared uniform wave bound e/(16*M). The allocations satisfy B*delta<=1/2 and

```
2*(E0+B*(delta+eta)) = e/(16*M).
```

One distinction is worth preserving in a future checker: the stored recurrence uses L1(v), which can exceed |v|. The generic theorem bounds the true Euclidean error; it does not automatically show that every more conservative L1-based bookkeeping radius is below the same value. This pilot explicitly checks that additional inequality for every stored radius, and the independent replay confirms it. There is no missing assertion in the present data.

## 4. Active sums, fresh phase, and correction

At each sample I sum exactly the first N stored centers and their individual radii. Both sums agree with the record. The complex center sum has no rounding error: arbitrary-precision rational addition of the dyadic centers is exact. The active radius sum is at most e/16. Inactive waves remain in the state but are absent from this sum.

The independent direct evaluator recomputes a, z, thetaHat, sqrt(a), F and J at each exact t_j. Every resulting enclosure is contained in its producer counterpart. The source sign `-(-1)^N` and the stable removable F formula are preserved on both sides of the cutoff. No stale correction or old N is reused.

The phase exp(i*thetaHat(t_j)) is newly enclosed at every sample. Its plus sign is essential. The independent sine component is computed through a separately enclosed shifted cosine, and both components are contained in the retained phase box. The extracted center u and its norm upper bound d_u are recomputed exactly and satisfy d_u<=e/(16*A).

The values A=11 and A=41 obey A>=1 and `(A-1)^2>=4*M`, hence A>=2*sqrt(M)+1. The correction center j0 is the specified 48-bit rounding of its interval midpoint, with recomputed absolute error d_J<=e/4. These are actual numeric inequalities, not a conclusion inferred from a bit count.

## 5. Final Khat error and direct comparisons

Let W be the exact active wave sum and S its retained center. Using the exact phase P of modulus 1,

```
|P*W-u*S| <= |W-S| + |P-u|*|S|
           <= sum_active R + d_u*L1(S).
```

Therefore the producer radius

```
R_K=2*(sum_active R+d_u*L1(S))+d_J+b_final
```

is a valid absolute Khat error. I independently recompute the exact unrounded real result `2 Re(u*S)+j0`, its final 48-bit rounding, b_final, and R_K. All records agree; b_final<=e/8 and R_K<=3*e/4 at all 34 samples. The direct bound uses the measured L1(S); it does not incorrectly assume L1(S)<=A.

The independent direct evaluator then computes Khat from the individual cosine sum, with the different precisions and truncations listed above. Every one of its 34 intervals lies inside both the recurrence interval and the producer's direct interval. It checks all 7,054 individual direct summand intervals, not merely their final sums. The complete replay performs 11,519 interval containments.

These comparisons corroborate the formula and recurrence assembly. Their soundness is not deduced from agreement: the norm-radius derivation above and the separately proved elementary interval formulas are the mathematical basis. No actual zeta value is needed to check this finite Khat expression.

The summary upper bounds also pass exact rational checks. In the small/large blocks respectively, the largest R_K is below 1.458e-12 / 2.661e-11, and the largest producer direct width is below 1.227e-27 / 1.103e-27. The initial, rotation and update-radius upper bounds in the producer's table also hold.

## 6. Actual HardyZ interval and limited sign scope

The allocation is exactly e=.019/t_top, with 1<=t_j<=t_top. Thus R_K<=3e/4 is strictly below .019*t_j^(-3/4). The independent replay additionally checks the exact fourth-power inequality `R_K^4*t_j^3<(.019)^4`.

The accepted analytic theorem contributes strict error .451*t_j^(-3/4). Therefore actual HardyZ is within .47*t_j^(-3/4) of the retained final center. The output rational Hardy radius H_j is positive and satisfies `H_j^4*t_j^3>=(.47)^4`; this independently certifies that it is an outward upper bound, not a rounded-down approximation. I verify each stored Hardy interval equals the center plus/minus H_j and recompute its sign classification.

All 17 small-block intervals are negative. In the large block, samples 0 through 3 are negative and samples 4 through 16 are positive. No retained interval is inconclusive. These are the reported isolated interval results only. The experiment supplies no global mesh coverage, saturation against a zero count, multiplicity information, or new finite spectral conclusion.

## Completion boundary

The independent full run completed in about 34.50 seconds and exited zero. It wrote only its new receipt. No high-height EM or actual-zeta computation was performed, and no benchmark extrapolation is justified by this small run.

The finite data and their intended mathematical interpretation pass review. Formal use still needs implementation of the elementary interval checker, exact center-update semantics, source Khat bridge, and the already reviewed analytic theorem in Lean. No such proof terms, full scan, or sign-chain completeness claim are supplied here.
