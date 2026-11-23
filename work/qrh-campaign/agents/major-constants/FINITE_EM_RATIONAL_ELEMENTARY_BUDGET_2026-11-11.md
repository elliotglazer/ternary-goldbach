# Rational elementary budget for the fixed principal batch

2026-11-11. Scalar sufficient-condition derivation only. No logarithm, exponential, zeta value, coefficient array, transform, or panel was evaluated. No Lean build or checker implementation is claimed. The companion script checks error inequalities using integers, Fractions and factorials only.

## 1. Fixed target and a specific arithmetic schedule

Use precisely the existing principal pilot

```
N=1024, B=1025, M=16, K=16, p=24, J=8, L=32,
sigma=629/1250, t0=31999/16, Delta=-1/8,
c_j=sigma+i*(t0+j*Delta), j=0,...,7,
rho=1/16, outer radius=1.
```

All rational constants, including sigma and every center, are imported exactly. The accepted scalar note is `EM_SMALL_BATCH_FULL_BUDGET_2026-11-11.md`, SHA256 `47256C6265C63BF1851B0FD7347F57BC18849AA7B629FFA72442EF9D05A22D23`. Its arithmetic gates are retained: bucket radius `2^-110`, normalized FFT arithmetic radius `2^-110`, main-jet arithmetic `2^-98`, full correction coefficient `2^-80`, and final assembly/midpoint `2^-80`. Its complete coefficient squares have coordinate halfwidth `2^-52`.

Here is one sufficient rational schedule. It is different from the saved native producer and is not a claim about rounding after every primitive operation:

* Compute elementary rational centers with the certified errors below.
* Between the named rounding gates, perform field arithmetic, finite sums, factorial divisions, polynomial products, and coefficient recurrences exactly over rational complex numbers.
* Round only at an elementary output, a completed moment bucket, each normalized FFT stage output, the stated Horner steps, a completed correction coefficient, and the final assembled coefficient. No unlisted roundoff is admitted.

Put `eta=2^-1024` and `epsilon=2^-512`. Elementary outputs use internal rounding norm at most eta; the other named gates use norm at most epsilon. For example, coordinatewise nearest rounding to grid step `epsilon/2` changes a complex point by less than epsilon. Signed integer floor/nearest witnesses are checked by exact comparisons, including negative coordinates. An outward interval with proved error padding is then formed around the rounded center. A disk radius e implies coordinate bounds e; interpreting a coordinate square back as a disk requires its sqrt(2) factor. The error arguments below use norms throughout until the existing final square contract.

This schedule avoids an unproved stability assertion for arbitrary dyadic rounding. Exact rational denominators may grow substantially. Neither the 1024-bit accuracy parameter nor the gate count bounds their full stored bit length or checker cost. A different round-after-every-operation schedule needs a separate propagated bound.

## 2. Source-backed elementary certificates with explicit lengths

The accepted elementary source plan is `prime-estimates/INTERVAL_PRIMITIVES_SOURCE_PLAN_2026-11-11.md`, SHA256 `BD64557F5ABFDDCA57717B180BE6AB93B888351547F3B75505B25226F190B2CC`. The exact coefficient rules are in `EM_FINITE_COEFFICIENT_SEMANTICS_2026-11-11.md`, SHA256 `ADE7149EE7D5C3586A2AA7267C39363828747D801DE5EF1F4508A21B737F69D3`.

At Mathlib pin `56a005855ea17e0b0958f73ec801ae140b0a1679`, I re-read `Analysis/Complex/Exponential.lean:377,407`. The second theorem is

```
norm(z)/(n+1)<=1/2
 => norm(exp(z)-sum_(m<n)z^m/m!) <=2*norm(z)^n/n!.
```

The elementary source plan pins Machin's exact identity at `Analysis/SpecialFunctions/Trigonometric/Arctan.lean:336`, alternating arctangent bounds at `Analysis/SpecificLimits/Normed.lean:1041`, and the exact log-tail wrapper `TernaryGoldbach.Prelim.RamPf.log_one_add_inv_bounds` at `Prelim/RamareHarm.lean:31`. No numerical library result is a premise of those certificates.

### Logs and pi

For each integer `1<=n<=1025`, write `n=2^k*u`, `0<=k<=10`, `1<=u<2`. With `t=(u-1)/(u+1)<=1/3`, take 512 terms of the log atanh expansion. Use the same length for log 2. The complete error before rounding is bounded by

```
11 * [2*3^-1025/(1025*(1-1/9))] < eta/16.
```

After a rounding error at most eta/2, each log center differs from the actual log by less than eta. Set log 1 exactly to zero. The other centers can be required to satisfy `0<=loghat(n)<=8`; the elementary bounds log 2>1/2 and log 1025<7 make this consistent with the stated error. Logs are reused as the same exact rational centers in phases, powers and residuals.

For pi, take 256 terms in each arctangent in `16*atan(1/5)-4*atan(1/239)`. The error is at most

```
20/(513*5^513)<eta/16.
```

Round with norm error at most eta/2, giving a center pihat within eta of pi. The coarse rational comparisons

```
16*(1/5-1/375)-4/239>3,       16/5<4
```

leave room to certify `3<pihat<4`. These are coarse domain checks, not an assumption that a decimal pi constant is exact.

### Exponentials and phase reduction

Every needed constant exponential can be computed at an exact rational argument `z=x+i*theta` with `-8<=x<=0` and `|theta|<2^14`. This covers `exp(-c_j*loghat(n))`, `exp(-c_j*loghat(B))`, and twiddles. The separate positive-real H exponential is unnecessary: the exact identity `H=B*exp(-s*log B)` is used in the full correction below.

For exp(x), put w=x/16, so `|w|<=1/2`. Use 513 terms, degrees 0 through 512, then four exact squarings. The initial error is at most

```
d0=2*(1/2)^513/513!.
```

All exact intermediate exponentials have norm at most 1. If their approximation error is below 1, a squaring increases it by at most a factor 3. Thus the final real-exp error is at most `3^4*d0<eta`, and the inequality also verifies the inductive small-error condition.

For cis(theta), choose the exact integer `k=nearest(theta/(2*pihat))`. Then `|k|<2^12` and the rational reduced center `r=theta-2*k*pihat` satisfies `|r|<=pihat<4`. The actual reduced angle is `theta-2*k*pi`; its difference from r is at most `2^13*eta`. Periodicity is applied to this actual angle, not to a midpoint substitution. The norm Lipschitz bound `|exp(i*u)-exp(i*v)|<=|u-v|` follows from the real integral of its unit-norm derivative. Use the 513-term complex exponential polynomial at i*r. Its norm error is at most

```
2*4^513/513! + 2^13*eta.
```

The polynomial computation and four real-exp squarings are exact rational arithmetic. Multiplying the resulting rational centers and rounding once with error eta gives a complex exponential center whose error is below `2^16*eta<epsilon`. For the product estimate, the true real exponential has norm at most 1, and the approximate cis has norm below 2. The scalar script checks all these inequalities without computing any of the centers. A source wrapper for the elementary Lipschitz estimates remains formal proof work.

## 3. Bins, phases and every moment coefficient

Let ell=log n and ellhat its center. Throughout, `0<=ell<=7`, `|ellhat|<=8`, and `|c_j|<2001`. The true phase has norm at most 1. An exponential integral along the input segment gives

```
|exp(-c_j*ellhat)-exp(-c_j*ell)| <=3*2001*epsilon.
```

The factor 3 bounds exp of the segment's real part, which is at most 1 even under the coarser epsilon input bound. Including the elementary exponential error yields phase error `<2^13*epsilon`; the approximate phase has norm below 2.

For bins, use the exact rational midpoint

```
xhat=L*Delta*ellhat/(2*pihat)=-2*ellhat/pihat,
q=nearest(xhat), k=q mod L.
```

Since both pi and pihat exceed 3, the error against `x=-2*ell/pi` is below `3*epsilon<1/8`. This proves the accepted bin witness even if the exact x lies near a half-integer. It does not require reproducing a previous producer's q. The coarse domain gives `|q|<=6`.

Retain q itself in the residual, rather than its residue modulo L. The actual residual and its rational approximation are

```
r=J*(Delta*ell-2*pi*q/L),
rhat=J*(Delta*ellhat-2*pihat*q/L).
```

They differ by at most `4*epsilon`. The accepted bin proof gives `|r|<55/56`; hence `|rhat|<2`. This includes n=1, with exact zero log and q=0, and signed Delta.

For h<16 and m<24, compute the rational moment center exactly as

```
Ehat_n * (-ellhat)^h/h! * (-i*rhat)^m/m!.
```

Computing the powers by the accepted coefficient recurrences is equivalent only if those recurrences use exact rational arithmetic between these gates. Finite powers satisfy

```
|ellhat^h/h!| <=2^45,
|ellhat^h/h!-ell^h/h!| <2^46*epsilon,
|rhat^m/m!| <=2^23,
|rhat^m/m!-r^m/m!| <2^29*epsilon.
```

For h=0 or m=0 the corresponding difference is zero. For positive indices these follow from the finite difference-of-powers identity on the segments with bounds 8 and 2. Multiplying the three factors and using a telescoping product identity gives moment error `<2^82*epsilon`. This bound includes the baseline phase, log-power and residual-power errors without any independence assumption about reused inputs.

Each bucket has at most 1024 terms. Sum their rational centers exactly, then round once with norm error epsilon. Its radius is below `2^93*epsilon<2^-110`. The resulting serialized center has norm below `2^80`. This size bound is for the actual rational input centers to the FFT, not just the true mathematical moments. If a different preexisting center array is supplied, its corresponding bound must be checked separately.

## 4. Five normalized FFT stages and contraction

Each required exact twiddle is `exp(2*pi*i*k/32)` with an appropriate integer representative k. Construct its center from pihat and the preceding exponential primitive. Taking `0<=k<32`, the input-angle error is at most `2*epsilon`, so the twiddle error is below `4*epsilon`; its norm is at most `1+4*epsilon`.

Use the exact positive normalized radix-two butterflies `(u +/- w*v)/2`, with the reviewed permutation convention, and round each output once with norm error epsilon. No rounding is hidden inside the rational multiplication or addition. With `B0=2^80`, let E_l be the arithmetic error relative to the exact normalized transform of the serialized input centers after l stages. The exact stages have infinity norm at most B0. Hence

```
E_0=0,
E_(l+1) <=(1+2*epsilon)*E_l + 2*epsilon*B0 + epsilon.
```

Five stages give `E_5<2^87*epsilon<2^-110`. The approximate stage outputs have norm below `2^81`. This arithmetic radius is separate from the bucket-input radius; the exact normalized transform's operator norm one transports the latter without a factor 32.

Read the negative time index `-j mod32`, contract the 24 residual orders with exact `y=j/8`, and multiply by L=32. One possible bounded-rounding implementation uses Horner, rounding once after each of its at most 24 rational affine updates. Since `0<=y<=1`, those errors sum to at most `24*epsilon`; final multiplication by 32 and rounding gives at most `769*epsilon<2^-100`. Exact Horner throughout with one final rounding is also allowed. Combining both input and FFT radii gives

```
main-jet arithmetic
 <=32*24*(bucket_error+E_5)+769*epsilon <2^-98.
```

No radius is inferred from the fact that a rational twiddle approximately satisfies a root equation. Its source exponential identity and the positive transform convention are required.

## 5. All correction terms and both coefficient recurrences

For each exact c_j, form the polynomial in z

```
C_j(z)=1/2+sum_(m=1..16)b_m*B^(-(2m-1))*(c_j+z)_(2m-1),
Q_j(z)=(c_j-1+z)*C_j(z)+B,
R_j(z)=exp(-c_j*log B)*exp(-z*log B)*Q_j(z).
```

This R_j is the full non-head correction to g. It includes the half term, all signed Bernoulli corrections, and `H=B^(1-s)` through the final B in Q. It is not a bound for the unmultiplied C alone. Bernoulli numbers and the negative integer powers of B are exact rationals.

Build the rising polynomials by the exact old-array recurrence `P_(r+1)[h]=(c_j+r)*P_r[h]+P_r[h-1]`. All products are truncated only above degree 15, which leaves retained coefficients unchanged. In the polynomial coefficient l1 norm, each affine factor has norm less than 2048, while B=1025. Since `|b_m|<=1`,

```
||C_j||_1 <1/2+16*2^31 <2^36,
||Q_j||_1 <2002*2^36+1025 <2^48.
```

There is no numerical roundoff in these rational polynomial calculations. Their potentially large unscaled intermediates therefore need no speculative floating-point stability assumption.

The truncated exponential coefficient array is `(-ell_B)^h/h!`, h<16, computed exactly using ellhat_B. Its l1 norm is at most exp(8)<3^8<2^13. Differentiating this finite polynomial in the real log parameter bounds its l1 perturbation by `2^13*epsilon`. This verifies the second, exponential coefficient recurrence with its normalized factorials.

Compute the constant phase separately at each of the eight exact c_j. This avoids an unbudgeted height-step recurrence; a phase-recurrence implementation would need its own error propagation. The phase error is below `2^13*epsilon` as above. Exact truncated convolution with Q_j therefore bounds each full correction coefficient error, including final rounding epsilon, by

```
2^48*[2^13*epsilon*2^13+2^13*epsilon]+epsilon
 <2^78*epsilon <2^-80.
```

Finally assemble `(c_j-1)*S_h+S_(h-1)+R_h` exactly and round the output midpoint once with error epsilon. This is below the existing `2^-80` assembly allowance. The h=0 branch sets S_-1=0. No full-g term is omitted.

## 6. Resulting coefficient and panel budgets

The analytic p=24 residual truncation is already accepted, and contributes `<2^25/24!` per full-g coefficient. Adding the actual bounds from sections 3 through 5 gives

```
midpoint error
 <2^25/24! +2002*main_jet_arithmetic+correction_error+epsilon
 <2^-53.
```

Thus this constructive schedule can output all 128 full-g coefficient squares with the required coordinate halfwidth `2^-52`, without using a FLINT result as an acceptance premise. The inherited finite-g Taylor, EM and quotient allowances remain unchanged. Including their coordinate-square conversion and final quotient arithmetic `2^-64`, the complete analytic/numerical quotient-error bound remains below `2^-44<2^-40`. The batch residual is already in the coefficient squares and is not added twice.

This existence-of-accuracy derivation does not prove containment in an arbitrary immutable saved square. To accept an existing receipt, the checker must compare its newly proved coefficient enclosures with those exact saved endpoints and prove full containment. A successful native run or overlapping boxes do not discharge that check. The same distinction applies to previously saved bin choices, intermediate moment centers and twiddle payloads. The checker may use fresh internal witnesses, but every consumed output and label must match its declared mathematical expression.

For the proposed minimal slice j=7, the same uniform bounds apply to its 16 coefficients and complete panel. They do not remove the need for correct input buckets and normalized transform dependencies of index25, nor do they certify the other seven panels merely by analogy. The full derivation here covers all eight when all corresponding witnesses are supplied.

## 7. What is established and what remains

The scalar script `finite_em_rational_elementary_budget_20261111.py` verifies 29 exact inequalities for the explicit elementary lengths, input phases, moments, FFT recurrence, correction norm and final allowances. It computes no elementary centers or actual array entries. The script is a numerical-constant check for this paper proof, not a checker for the forthcoming receipt.

The accepted source plan supplies soundness routes for the rational gates. New formal wrappers and their finite witness data remain to be built. Exact rational intermediate expressions can have large denominators, and the design establishes no throughput or bit-complexity advantage. The stronger claim that every operation can be rounded on a 512-bit or 1024-bit grid is deliberately not made; its missing ingredient would be a schedule-specific error recurrence for every such operation. The schedule above specifies all its rounding gates and is sufficient without that unproved stronger claim.
