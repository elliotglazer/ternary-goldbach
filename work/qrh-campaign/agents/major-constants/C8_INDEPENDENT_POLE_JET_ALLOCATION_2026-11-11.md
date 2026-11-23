# Independent conductor-eight pole jets and their conditioning

2026-11-11. Paper and scalar checks only. No elementary function value, jet array, evaluator, transform, Lean build or numerical pilot was run. This proposes an independent calculation for the mandatory full-containment check. It neither accepts saved data nor changes the fixed attempt's precision or resource limits.

## 1. Fixed inputs and the distinct calculation

The accepted pilot is `zero-sum/NONPRINCIPAL_TENSOR_PILOT_DESIGN_2026-11-11.md`, SHA256 `3B4B21946F89CA503F03A2BBC030B73F556B31254BA643C427AFB1B39CA5A43B`; its review is `moebius/REVIEW_NONPRINCIPAL_TENSOR_PILOT_DESIGN_2026-11-11.md`, SHA256 `0046FAEEC56248F33F5AB9CD80E8C8675631FBF77679FE54CE436DD9A56FCFA3`. Both were read in full and their hashes checked.

Its exact parameters are c=8, N=37, M=16, K=30, three centers `s0=1+i/8, 1, 1-i/8`, target radius 1/16, outer radius 1, and units in coordinate order `(1,5,7,3)`. Thus

```
X_a=296+a in (297,301,303,299), X_1=297,
L_a=log X_a, L_1=log297.
```

The producer's P-jet path uses Q=32 exponential moments and a binomial convolution. The proposed independent path uses neither those moments nor the producer's pole-jet routine. At the exact center 1 it subtracts normalized powers of the two endpoint logs. At the two off-center points it computes direct endpoint exponential jets and performs the finite quotient recurrence below. Direct finite head sums and direct character sign sums replace both time and character transforms in the independent full-coefficient check. Common elementary arithmetic libraries may remain a shared dependency; this is independence of the mathematical evaluation path, not a claim of disjoint software trust.

Only the three accepted nonprincipal rows are interpreted as actual L-functions. The principal row is excluded. The producer remains the fixed 192-bit attempt and the independent check the fixed 256-bit attempt under the accepted deadlines and other caps. The error requirements below do not prove that native arithmetic at either precision meets them, and do not authorize escalation.

## 2. Actual entire function and all normalized coefficients

The accepted entire correction is

```
P_a(s)=[X_a^(1-s)-297^(1-s)]/[8*(s-1)]             for s != 1,
P_a(s)=-(1/8)*integral_(L_1)^(L_a) exp((1-s)*u) du for every s.
```

The integral representation is proved in `zero-sum/POLE_DIFFERENCE_JET_ENCLOSURE_PLAN_2026-11-11.md`, SHA256 `3F73AF600725DDB51ED622577BF374251B38C408D0D52D4EA06CFCF1BDD60011`, reviewed at `39D7D84D0706FE27A7DEF211684FA1DCA4D9E3544AB1A496AE435DDF4E04F577`. Its finite-interval integrand is entire in s and locally uniformly dominated with every derivative. Thus differentiation gives the actual normalized jet, including at the removable point. The factor 1/8 is the already conductor-scaled factor; there is no further 8^(-s), Gauss factor or Gamma factor.

At s0=1, for h=0,...,29,

```
P_h(1)=[(-L_a)^(h+1)-(-L_1)^(h+1)]/[8*(h+1)!].   (C)
```

Indeed the normalized integral derivative is `(-1)^(h+1)/(8*h!)` times the integral of u^h. In particular `P_0(1)=-(L_a-L_1)/8`; nonreference residues do not have zero P jets at 1. The last requested coefficient requires power 30 and factorial 30!, not only powers through 29. Equivalently, a numerator Taylor series at 1 must be retained through degree 30 before division by its simple zero. A length-30 numerator truncated first would lose the last answer.

For s0=1+q, q=+i/8 or -i/8, define direct normalized numerator coefficients

```
N_h=exp(-q*L_a)*(-L_a)^h/h!
    -exp(-q*L_1)*(-L_1)^h/h!, h=0,...,29.
```

Expanding the exact identity `8*(s-1)*P_a(s)=X_a^(1-s)-297^(1-s)` at s0 gives

```
q*P_h+P_(h-1)=N_h/8, P_-1=0,
P_h=(N_h/8-P_(h-1))/q.                            (R)
```

There is no factor h in (R), because the coefficients are derivatives divided by factorials. Here q is an exact nonzero rational complex number. Division is an exact signed coordinate interchange and scaling: for q=+i/8,

```
P_h=-i*N_h+8*i*P_(h-1);
```

for q=-i/8 the formula is `P_h=i*N_h-8*i*P_(h-1)`. Those signs must not be inferred from a floating-point denominator. The recurrence can be derived from power series on a neighborhood of radius less than 1/8, or directly from derivatives of the entire identity. It supplies the true jets regardless of the larger outer disk used later for finite-U Cauchy bounds.

For a=1, X_a=X_1 exactly, so all P jets are exactly zero at all three centers. Take this branch from the integer residue, not from a small computed log difference. There are 90 such exact zeros. Of the other 270 P coefficients, 90 use (C) and 180 use (R). Together these are the pilot's 360 residue/center P coefficients.

This identifies the same P used in the accepted finite-U/source continuation. It does not identify an individual ordinary Hurwitz finite part at 1 with Mathlib's totalized Hurwitz value. As in the accepted adapter, the common pole cancels only in a nonprincipal character sum. Source and mathematical normalization are unchanged.

## 3. Exact conditioning of the off-center recurrence

Let a supplied numerator center have norm error at most epsilon_N,h, and let the arithmetic and final rounding for one recurrence step introduce norm error at most eta_h relative to applying (R) to those supplied centers. Exact q has modulus 1/8. Therefore

```
e_h <= epsilon_N,h +8*e_(h-1)+eta_h, e_-1=0.       (S)
```

The factor 1/8 on the numerator cancels the denominator's factor 8. If every `epsilon_N,h+eta_h<=epsilon`, then

```
e_h <= [(8^(h+1)-1)/7]*epsilon,
G=(8^30-1)/7<2^88.                                (G)
```

This is an absolute-error statement. It does not give relative accuracy near a small coefficient, and does not describe the conditioning of the entire function itself. It exposes the substantial growth specific to this independent quotient recurrence. It does not dismiss that growth because the true P function is entire.

## 4. A sufficient elementary and arithmetic allocation

Set

```
delta=2^-240 for every log and elementary exponential input/output error,
r=2^-224 for each named complete rational-arithmetic gate.
```

The elementary exponential error is measured against the exponential at its exact rational approximate argument; error from replacing an actual log by its center is accounted for separately. All radii are Euclidean. Coordinate boxes need the corresponding norm conversion. A 256-bit working setting alone is not a proof of either target. These are required enclosures that must be checked within the existing fixed attempt.

One sufficient arithmetic schedule uses exact rational complex operations between named gates, followed by a rounding with norm error at most r at each gate. A nearest coordinate grid of step r/2 suffices for such a rounding. Alternatively an interval implementation may round internally if its proved aggregate error for that complete gate is at most r. That alternative requires its own verified propagation; no arbitrary operation schedule is assumed sound merely because its setting is 256 bits.

The needed logs are positive-base real logs. Every head and endpoint base is at most 303, so its log is below 7: `exp(1)>5/2` and `(5/2)^7>303` suffice. Require log centers in [0,8], with log1 exactly zero. For every h<=29, the normalized log power and its derivative with respect to the log are bounded by exp(8)<3^8<2^13. This follows by comparison with the nonnegative exponential series, not from a function evaluation. For h=0 the derivative is zero.

At an off-center point, `exp(-q*L)` has norm 1. Replacing L by its real center changes the phase by at most delta/8, using the unit-speed imaginary exponential. Adding the independent elementary exponential error delta gives phase error below 2*delta. Consequently each numerator N_h has error below `2^16*delta` before its complete rational-power/product/difference gate. Allowing r for that gate gives

```
epsilon_N,h <=2^16*delta+r.
```

Allow a separate r for each recurrence step. Then all off-center pole jets have error at most

```
E_off=G*(2^16*delta+2*r)<2^-134.                    (Poff)
```

This includes the full 30-step amplification; it is not a per-step error relabeled as a final error. If one uses an arithmetic library instead of exact rational operations within a gate, its complete gate radius must still meet the specified r.

At s0=1, apply the real mean-value bound to the normalized power `(-L)^(h+1)/(h+1)!`. Its derivative magnitude is at most 2^13 on [0,8]. The two endpoint-log errors and factor 1/8 give

```
E_one <=2^11*delta+r<2^-223.                        (Pone)
```

The zero branch a=1 introduces no error. All three cases satisfy the accepted P-block allowance 2^-84, with much more room than required. There is no Q32 moment tail on this independent path: (C) and (R) are exact formulas, and only elementary/finite arithmetic errors are added.

The accepted elementary source plan, `prime-estimates/INTERVAL_PRIMITIVES_SOURCE_PLAN_2026-11-11.md` at `BD64557F5ABFDDCA57717B180BE6AB93B888351547F3B75505B25226F190B2CC`, supplies rational log/exp gates with finite tails. The previously reviewed explicit elementary budget `FINITE_EM_RATIONAL_ELEMENTARY_BUDGET_2026-11-11.md` at `50D1FFB0385A0F2FCE3BA9EF3BBB4FFD3BAC5A0103E95A8329E79A25D524A541` supplies an even stronger rational accuracy construction on these smaller argument domains. Neither result asserts that native 256-bit interval arithmetic automatically passes, nor authorizes replacing the accepted independent attempt by a longer or higher-precision run. No built-in exprel, Hurwitz or zeta function is used here.

## 5. Complete independent finite-U coefficient allocation

A small P radius alone is not a full coefficient enclosure. The following direct reconstruction covers the other blocks at the same three centers. It uses no time-bin approximation and no transform circuit.

For `E_n,h=exp(-s0*log n)*(-log n)^h/h!`, the actual constant phase has norm at most 1 because Re(s0)=1. Since |s0|<2, replacing the log by its real center changes the phase by at most 2*delta; adding elementary exponential error delta gives 3*delta. The same log-power bound gives a per-term coefficient perturbation at most

```
e=2^15*delta.
```

Compute the 37 head terms per residue directly. With one complete head summation gate r, its coefficient error is at most `37*e+r`. The half endpoint contributes error at most `e/2+r`.

For the full Bernoulli block, use the exact rational polynomial

```
Bpoly_a(z)=sum_(m=1..16)b_m*(s0+z)_(2m-1)/(37+a/8)^(2m-1),
b_m=B_(2m)/(2m)!.
```

Every affine factor in a rising polynomial has coefficient l1 norm less than 33, whereas `37+a/8>=297/8>33`. Also |b_m|<=1. Thus `||Bpoly_a||_1<16`. Compute these signed rational polynomials exactly, or certify their complete aggregate arithmetic within the gate allowance; retain degrees through 29. Multiplying by the endpoint exponential's normalized coefficient array therefore gives Bernoulli-block error at most `16*e+r`. The scaling is the actual `8^(2m-1)*X_a^(1-s-2m)` from the accepted finite-U adapter; using the denominator `37+a/8` is its algebraically identical form, not an omitted conductor factor.

For an explicit sufficient exact-between-gates schedule, take the rising polynomials and their rational coefficients exactly, so that this last r covers the full exponential convolution and final rounding only. Any library implementation that also approximates the rising polynomials must include those errors in the same complete block allowance, rather than treating r as merely its last rounding.

Allow r for the final residue addition. Then each direct U_a coefficient has error at most

```
E_U=(37*e+r)+(e/2+r)+(16*e+r)+max(E_off,E_one)+r.
```

Contract the four residues with the exact character signs and allow r for that signed sum. Every one of the 270 nonprincipal character/center coefficients has error at most

```
E_L=4*E_U+r<2^-128.                                (L)
```

This is a sufficient accuracy target for the mandatory direct finite-U reconstruction. It includes all head, half-endpoint, Bernoulli and P terms. There is no additional c^(-s), no principal zetaF multiplier, and no division by s-1 in the full nonprincipal L reconstruction. The division in (R) is solely an internal formula for P at two exact nonzero q values.

## 6. Full containment, not a matching-digits test

The accepted producer publishes coefficient balls of radius `Rpub=2^-75`. Its claimed center error, once actually established by the required arithmetic evidence, is bounded by

```
A=2^-76+2^17/32!.
```

Let an independent direct coefficient center be q_h with proved Euclidean radius `rind=2^-128`, as permitted by (L), and let C_h be the immutable published center. Acceptance still requires a certified rational D_h with

```
|q_h-C_h|+rind <= D_h <=2^-75.                       (I)
```

The squared-norm or rational L1 comparison must be computed for the actual saved centers. There is enough theoretical room: if both center-error claims are valid, triangle inequalities give `|q_h-C_h|+rind<=A+2*rind<2^-75`, which the scalar script verifies exactly. This margin calculation is not a replacement for (I), and does not assume a native producer's center-error claim has already been formally accepted. Failed containment remains a failed independent check even if two separate enclosures might both be valid.

For whole disks, use the independent D_h values in the accepted coefficientwise tube test. The reviewed actual-point EM bound E<2^-70 and finite-function Taylor tail Tay<2^-77 retain their domain and conductor hypotheses. The complete sufficient tube budget remains

```
(3/2)*(E+Tay)+(16/15)*2^-75+2^-75<2^-68.
```

The factor 3/2 applies if analytic disk errors are inserted as square padding. It does not turn a coordinate radius into a Euclidean coefficient radius without proof. Shared endpoint and conjugation tests remain additional consistency checks. No independent P truncation tail is charged, because this path has none; no producer time-residual tail is charged twice after coefficient containment.

## 7. Scope of the scalar receipt

`c8_independent_pole_jet_allocation_20261111.py` checks 15 rational/factorial inequalities. Its JSON records delta, r, the exact amplification G, complete block bounds, and the prospective containment margin. It does not compute logarithms, exponentials, actual P coefficients or any pilot data.

The new mathematical result is a separate exact P-jet path with an explicit 30-order absolute-conditioning bound and a complete sufficient direct-coefficient allocation. Its numerical execution and all actual containment witnesses remain required. Fixed precision, deadline, memory and output caps from the accepted pilot are unchanged. If those caps prevent the required elementary or aggregate radii from being proved, the outcome is incomplete, not a reason to infer accuracy from convergence or the nominal bit setting.
