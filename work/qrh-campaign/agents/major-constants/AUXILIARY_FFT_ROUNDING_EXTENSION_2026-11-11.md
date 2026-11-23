# Finite FFT rounding at arbitrary auxiliary heights

2026-11-11. This note gives a universally terminating parameter rule for the already reviewed rational radix-two algorithm. It removes the fixed 36-stage restriction from its **rounding analysis**. It does not generate coefficients, twiddles, FFT traces, signs, or spectral certificates, and makes no runtime or memory claim. No Lean build, canonical edit, or frozen-note edit was made.

The rule applies to every finite stage count, rational nonnegative input-center norm bound, positive rational scale bound, and positive rational output tolerance. At the auxiliary example `c=4,H=10^8,N=2^37`, it selects 147-bit dyadic rounding, 32 terms in each Machin arctangent, and exponential Taylor degree 53. The scaled FFT arithmetic error is bounded by `10^-30/16`, inside the requested `10^-30/8` allowance. This is a finite arithmetic witness for a specified algorithm, not evidence that a transform or its input packets have been checked.

## 1. Frozen inputs and scope

The finite algorithm and general stage recurrence are from `agents/moebius/FAMILY_FINITE_FFT_PROOF_PLAN_2026-11-11.md`, SHA256 `6E303D60C855E2CAD444EBC4EB3B1A3BD192D9BEAFAE0448F3F6D63CD9CDAC2E`. Independent review: `agents/major-constants/REVIEW_FAMILY_FINITE_FFT_PROOF_PLAN_2026-11-11.md`, SHA `B98A0735B223EBA01922044733750DC13A3C806B531AA1894D54589B68A88B0D`.

The auxiliary-height parameter adapter is `work/qrh-blueprint/turing-scalars/AUXILIARY_FOURIER_PARAMETERS_2026-11-11.md`, SHA `45E848935AC76C8450550DFE02279C697514BF227B37EA6FD25221B3F7C37F47`; independent review `agents/zero-sum/REVIEW_AUXILIARY_FOURIER_PARAMETERS_2026-11-11.md`, SHA `5EB56E2F86C5CE05CCA3491C237FE66F4C0053F656AD1401211A47406833DA21`. Its receipt is read only. The adapter permits arbitrary rational `H>=1`, including a Turing auxiliary endpoint, without a bound `cH<=10^8`.

Only the **general** radix-two invariant and rounding recurrence are reused. None of the predecessor's numerical specializations `d<=36`, `B<100000001`, multiplier below 51, or fixed 180-bit/degree-64 prescription is imported into the arbitrary-height result.

All analytic source identities and the final Goldbach theorem premises remain as before. A larger auxiliary height changes the finite parameter choices, not the required spectral target or the character family. This note concerns arithmetic after source-bound coefficient enclosures are supplied; producing those enclosures remains separate work.

## 2. General input and algorithm

Take:

* an integer `d>=0`, with `N=2^d`;
* rational complex input centers `a_0,...,a_(N-1)` and a rational `B>=0` with `|a_k|<=B` for every k;
* a positive rational period P and a positive rational D bounding the exact scale `s=2*pi*N/P`, so `0<s<=D`;
* any positive rational tolerance `eps>0` for the **scaled output arithmetic error**.

The generic theorem allows eps>1 and d=0. When d=0 the inverse transform is the single input and there are no butterfly stages; the scale multiplication still needs rounding. The centered even-frequency alias adapter itself uses N>=2, so no centered-index convention is asserted for N=1.

Use the reviewed bit-reversed input order, positive-exponent twiddles, and simultaneous normalized butterflies

\[
 (u,v)\longmapsto ((u+\zeta v)/2,(u-\zeta v)/2),\qquad
 \zeta=e^{2\pi i r/m},\quad 0\le r<m/2.
\]

The exact output is the normalized inverse DFT Y, and the desired scaled output is sY. The center norm bound B may be verified directly from rational centers, or deduced from the analytic coefficient envelope and their proved input radii. It is not an assumption that the approximate centers equal the true Fourier coefficients.

## 3. One local error budget for every stage count

Define the positive rational number

\[
 \delta=\min\left\{
 \frac1{2(d+1)},\quad
 \frac1{(d+1)(B+2)},\quad
 \frac{\mathrm{eps}}{2(B+2)(Dd+1)}
 \right\}.\tag{1}
\]

Require the following local accuracies, all implemented below:

* each approximate twiddle differs from its exact value by at most delta;
* each butterfly output center differs from the exact rational expression in its approximate inputs and twiddle by at most delta;
* the final scale center differs from s by at most delta;
* the final rounded complex product differs from that exact center product by at most delta.

Let E_j be the maximum arithmetic error at stage j relative to the **exact transform of the rational centers**. The reviewed recurrence is

\[
 E_j\le(1+\delta/2)E_{j-1}+\delta B/2+\delta,\qquad E_0=0.
\]

For d=0 all sums below are empty. For general d, expand the recurrence. The binomial estimate gives

\[
 (1+\delta/2)^d\le\frac1{1-d\delta/2}<\frac43<2,
\]

because `d*delta/2<=d/(4(d+1))<1/4`. This estimate follows from `binomial(d,j)<=d^j` and the convergent positive geometric series; it does not assume a fixed d. Therefore

\[
 E_d\le d(B+2)\delta=:E_*<1,\tag{2}
\]

where the strict bound follows from the second term of (1): `E_*<=d/(d+1)<1`.

Let V be the final rounded scaled output. The scale/product perturbation bound then gives

\[
 |V-sY|\le D E_*+\delta(B+E_*)+\delta
 < D E_*+\delta(B+2)
 =(B+2)(Dd+1)\delta\le\mathrm{eps}/2<\mathrm{eps}.\tag{3}
\]

This bound remains valid at B=0 and d=0. No statistical independence is used. The slack factor 1/2 is deliberate; the rule need not optimize precision to establish a terminating construction.

## 4. Constructive dyadic precision and pi enclosure

For a rational real x define `Round_p(x)=floor(2^p*x)/2^p`, applying it componentwise to complex numbers. Signed inputs have real error below `2^-p`, so complex error is below `2^(1-p)` by the sum of component errors.

Starting with p=2, increase p until

\[
 2^{1-p}\le\delta/4.\tag{4}
\]

This search terminates because dyadic powers tend to zero. Every butterfly is evaluated as an exact rational expression in its current centers and approximate twiddle, then rounded by this rule. The same rule is used for twiddle centers and the final complex product. Each resulting local rounding error is strictly below delta/4 and therefore below delta. Exact rational arithmetic and integer floor are finite operations; this prescription is not a claim about an unexamined floating FFT library.

For an integer `J>=2`, set

\[
 S_J(x)=\sum_{j=0}^{J-1}\frac{(-1)^jx^{2j+1}}{2j+1},\quad
 \widehat\pi_J=16S_J(1/5)-4S_J(1/239),
\]
\[
 e_\pi(J)=\frac{16}{(2J+1)5^{2J+1}}+
           \frac4{(2J+1)239^{2J+1}}.
\]

The finite geometric identity integrated over [0,x] proves the arctangent remainder, and the already reviewed Machin identity gives `|pi_hat_J-pi|<=e_pi(J)`. Start at J=2 and increase until

\[
 e_\pi(J)\le\frac{\delta}{4(D+1)}.\tag{5}
\]

Termination follows, for example, from `e_pi(J)<=20/5^(2J+1)`. The center has a safe range for **every** J>=2, not only eventually: the alternating sums lie between

\[
 L(x)=x-x^3/3,\qquad U(x)=x-x^3/3+x^5/5.
\]

Thus `16L(1/5)-4U(1/239)<=pi_hat_J<=16U(1/5)-4L(1/239)`. Exact rational comparisons put both endpoints strictly between 3 and 22/7. This ensures that the later angle and Taylor bounds are valid for every accepted J. The proof neither rounds the true pi to an unverified center nor assumes the principal branch of an arbitrary inverse tangent.

## 5. Constructive Taylor degree for every twiddle

Put `A=22/7`. For an integer K>=6 define

\[
 T_K=\frac{A^{K+1}}{(K+1)!}\,
          \frac1{1-A/(K+2)}.\tag{6}
\]

The denominator is positive: `A/(K+2)<=A/8<1/2`. Starting at K=6, increase K until

\[
 T_K\le\delta/4.\tag{7}
\]

This is another terminating rational test. Indeed, successive terms of `A^(K+1)/(K+1)!` from K=6 onward have ratio at most A/8<1/2, and the geometric denominator in (6) is below 2. Hence

\[
 T_K\le\frac{2A^7}{7!}\,2^{-(K-6)}\longrightarrow0.
\]

For each stage and r define the rational angle `theta_hat=2*pi_hat_J*r/m`, compute exactly

\[
 Q_K(i\widehat\theta)=\sum_{j=0}^K\frac{(i\widehat\theta)^j}{j!},
\]

and round it componentwise with Round_p to obtain the approximate twiddle. Since `0<=theta_hat<pi_hat_J<A`, the complex exponential power series has tail at most T_K. The true angle differs by at most e_pi(J), because `2r/m<1`. The real-axis exponential Lipschitz bound therefore proves

\[
 |\widehat\zeta-\zeta|
 <e_\pi(J)+T_K+2^{1-p}
 \le\delta/[4(D+1)]+\delta/4+\delta/4<\delta.\tag{8}
\]

No claim that the rounded twiddle has unit norm is needed. At d=0 no twiddle is used; performing these scalar searches anyway still terminates.

## 6. Output scale construction

Set `s_hat=Round_p(2*pi_hat_J*N/P)` with real rounding. The actual scale has `s=2*pi*N/P<=D`; since pi>1,

\[
 2N/P=s/\pi<D.
\]

It follows that

\[
 |\widehat s-s|
 \le (2N/P)e_\pi(J)+2^{-p}
 < D\delta/[4(D+1)]+\delta/8<\delta.\tag{9}
\]

This accounts for amplification of the pi error by the actual N/P; it does not borrow the fixed-height bound `2N/P<16`. Round the final exact rational complex product `s_hat*Y_hat` componentwise with Round_p. Equations (4)–(9) supply all local accuracies used in (3).

Thus (1), (4), (5), and (7) are a universally terminating parameter rule. Their three searches depend only on positive rational quantities and an integer d. They are not a collection of selected numerical examples. In particular they apply to arbitrarily small positive tolerances, arbitrarily large but finite B,D,d, and tolerances greater than one.

## 7. Join to arbitrary auxiliary-height Fourier parameters

Use the root adapter's notation: integer c>1, rational H>=1, `C=cH`, and rational `0<e<=1`. The adapter chooses P, an integer x>=2, and a power-of-two N, with

\[
 s=\omega N<D=88x/21.
\]

Its three analytic terms—time alias, omitted frequencies, and total retained-coefficient series tail—are each strictly below e/4. The additional requested rounding radius for each coefficient is `e/(8D)`.

The analytic Fourier envelope is `|C_j|<=C`. A coefficient center with the proved common series radius below `e/(4D)` and additional radius at most `e/(8D)` satisfies

\[
 |a_j|<C+3e/(8D)<C+1,
\]

because `D=88x/21>=176/21>8`. Thus `B=C+1` is a valid uniform center bound **once those coefficient enclosures are proved**. Alternatively a tighter B can be checked directly from all centers.

Apply the universal rule with `d=log2(N)` as an exact integer, `B=C+1`, the adapter's D, and `eps=e/8`. Equation (3) gives scaled FFT arithmetic error below e/16, hence certainly below the requested e/8. Coefficient uncertainty still contributes separately: multiplying its additional per-coefficient radius by the true total weight s<D gives error below e/8. The analytic series error was already budgeted and is not charged again in the FFT recurrence.

The combined radius is therefore strictly below

\[
 3e/4+e/8+e/16=15e/16<e.
\]

This eliminates the need to keep a fixed-height stage-count assumption in the **finite FFT rounding producer**. It does not eliminate the need to prove each actual coefficient enclosure, supply the correct primitive-character/root-phase labels, or check a transform trace. Those data remain absent. It also provides no off-grid interpolation, sign separation, or completeness result.

## 8. Exact auxiliary example beyond 36 stages

The root receipt `work/qrh-blueprint/turing-scalars/auxiliary_fourier_parameters.json` gives

```
c=4, H=100000000, C=400000000, e=10^-30,
P=25700000000, x=13, N=137438953472=2^37,
D=1144/21, B=400000001, eps=e/8.
```

The constructor in `auxiliary_fft_rounding_extension_20261111.py` reads that frozen row without changing it, then obtains

```
delta = 21 / 271033602032752000000000000000000000000000000,
p = 147,
J = 32 terms per Machin arctangent,
K = 53 (last included Taylor degree).
```

Every test is an exact Fraction comparison. Its conservative stage bound is

\[
 E_* = 777/677584000000000000000000000000000000,
\]

and the scaled-output cap from (3) is exactly

\[
 (B+2)(Dd+1)\delta=1/16000000000000000000000000000000=e/16.
\]

This example uses d=37 in the proof itself, rather than silently reusing d<=36. The 147-bit precision is smaller than the earlier conservative 180-bit choice because the old example targeted a different arithmetic allowance; it is not evidence of a faster implementation. No actual 2^37 array or stage trace was allocated.

## 9. Reproducibility and remaining formal work

The new script implements the rational rule for all inputs in section 2. Its receipt records the selected parameters and every local/global bound for the auxiliary row. It also exercises scalar boundary cases `d=0,B=0,eps>1`, a one-stage fractional example, and a large finite stage/norm example. Those tests check the implementation; universal termination and correctness are proved in sections 3–6, not inferred from the tests. The script generates no coefficient arrays, twiddle tables, transforms, or analytic function values.

The mathematical implementation obligations are those already identified in the reviewed finite FFT plan: exact radix-two/bit-reversal invariant, componentwise integer-floor rounding bounds, Machin and exponential Taylor remainders, and the stage/scale error inequalities. The new work is parameterizing their constants and proving the three scalar searches terminate. An actual floating or external FFT routine would need a refinement proof to this rational specification or a separately verified per-operation trace. Neither a precision label nor a library name supplies that proof.

All final theorem premises and all unresolved spectral certificates are unchanged. The result is a constructive finite-arithmetic producer design for arbitrary auxiliary heights, ready for independent review and later formalization.
