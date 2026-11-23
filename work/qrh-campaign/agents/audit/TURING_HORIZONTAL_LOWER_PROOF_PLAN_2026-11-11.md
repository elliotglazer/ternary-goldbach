# Lower horizontal logarithms: a local proof avoiding the completed product

2026-11-11. Research derivation and exact scalar checks. No Lean/Lake build, zero or prime scan, dependency change, or frozen-package edit. This note supplies a complete paper-level local argument from standard complex-analysis facts and the existing source growth bound. Instantiating and checking those facts in Lean remains work. The historical sharper argument is reconstructed separately; it is not silently assumed.

## 1. Carrier and outcome

Let Q>1 be a natural conductor and chi a primitive complex Dirichlet character modulo Q, of either parity. It is therefore nonprincipal. Use the actual continued Dirichlet L-function, and for real t>50 put

```
Z(t) = log(Q*t/(2*pi)),
I(t) = integral_(1/2)^infinity log|L(sigma+i*t,chi)| d sigma.
```

The recommended local route proves

```
I(t) > -127.184 - 21*Z(t) > -128 - 21*Z(t).                 (Llocal)
```

The second comparison uses only 127.184<128. Neither this result nor its proof assumes RH, a finite zero list, simplicity, or a completed-L Hadamard product. In fact the local argument works for every nonprincipal character of modulus Q>1; primitivity is retained to match the intended family consumer.

Combining the rounded version with the separately reviewed elementary upper bound `I(t)<3.434+.75*Z(t)` and the correctly normalized Littlewood identity would give

```
|integral_(t1)^(t2) S(t,chi) dt|
  < 42 + 6.93*log(Q*t2/(2*pi)),       50<t1<t2.              (Tlocal)
```

This is a larger auxiliary allowance than the published 1.8397+.1242*log term. It is not a claim that existing sign data already saturate the enlarged allowance. Littlewood and the family endpoint/count adapter remain separate proof obligations. The final Goldbach theorem need not acquire any premise from this change.

## 2. What the historical lower proof actually requires

Primary corroboration is [Trudgian, arXiv:0903.1885v3](https://arxiv.org/pdf/0903.1885), section 3.4, printed pp13–15; the inspected PDF is `audit/trudgian_turing_0903_1885.pdf`, SHA256 `E8D021A3C083D0F07427760661478E47390D446D06714257DEE702246FACC878`. Page14 was also rendered and visually checked for bars, signs, and exponents. Rumely's original detailed constants are accessible in the [OCR reproduction](https://paperzz.com/doc/8887603/numerical-computations-concerning-the-erh-%E2%80%94-all-q), printed pp430–433; its original page images were not obtained. Do not treat OCR-only typography as a verified original formula.

With a shift d in (1/2,1], an exact change of variables separates I into the compact integral of `log|L(s)/L(s+d)|`, the tail starting at 1/2+d, and another integral from 1/2+d to 1/2+2d. The last two use the Euler lower bound

```
log|L(sigma+it)| >= log zeta(2*sigma)-log zeta(sigma), sigma>1.
```

Write J(a)=integral_a^infinity log zeta(sigma) d sigma. Their combined lower contribution is

```
I_E(d) = (1/2)J(1+2d)-J(1/2+d)
          +(1/2)integral_(1+2d)^(1+4d) log zeta
          -integral_(1/2+d)^(1/2+2d) log zeta.
```

The completed function is

```
Lambda(s,chi)=(Q/pi)^(s/2)*Gamma((s+epsilon)/2)*L(s,chi),
epsilon in {0,1}.
```

Its analytic continuation at Gamma poles must be used; multiplying the pointwise raw functions at a pole is not a valid definition. Primitivity, the functional equation, nonvanishing at s=1, and Gamma cancellation establish an entire completed function with only nontrivial zeros. A Hadamard proof then needs order/growth control, the genus-one product, multiplicities, real exponential-factor cancellation, convergence, and integration across possible horizontal zero singularities. The zeta-only `Explicit/XiPartial.lean` is not already this general-character theorem.

For a fixed character, the reflection is rho -> 1-conj(rho), preserving its imaginary part and order. It is not rho -> 1-rho unless one also changes to the conjugate character. Trudgian's actual page14 has the required conjugation bar. Booker pairing at fixed t uses conjugated factors when passing to absolute values; no same-character conjugation invariance or line-RH can be inserted.

Only the real identity

```
sum_rho m_rho*Re(1/(s-rho))
 = (1/2)log(Q/pi)+(1/2)Re digamma((s+epsilon)/2)+Re(L'/L)(s)
```

is needed at Re(s)=1/2+d>1. A proof must establish this identity with its actual summation convention; the stronger complex cancellation printed in equation3.10 is unnecessary. The nonnegative real terms and their convergence follow from the actual zero carrier and the growth/product theorem, not from an assumed finite inventory. The Euler derivative is **minus** the von Mangoldt series. The positive sign displayed in the intermediate prime sum in equation3.15 is not an identity for L'/L; its stated upper bound remains valid by absolute values.

At d=1, the original Rumely numerical ledger consists of:

* Gamma compact integral at least `(1/2)log(t/2)-.0018`;
* Gamma half-derivative at 3/2+it at most `(1/2)log(t/2)+.0011`;
* the integrated zero-ratio loss at most 1.48 times the positive zero resolvent mass;
* `-zeta'(3/2)/zeta(3/2)<1.506`;
* `I_E(1)>-1.2183`.

These yield exactly

```
I(t) > -.24*Z(t)
       -[.0018+1.2183+1.48*(.0011+1.506)]
     = -.24*Z(t)-3.450608 > -.24*Z(t)-3.4507.
```

The scalar rounding is checked here; those five sharp analytic/numeric leaves are not proved here. Trudgian replaces the zero factor1.48 by log4 using Booker's paired inequality (Lemma2.10), and supplies a parameterized Gamma estimate, but cites external proofs for both. The local route below avoids every one of these specialized leaves, rather than adding them as final hypotheses.

## 3. Disk geometry and a source-proved growth bound

Translate the disk center to c=3/2+it and set

```
f(w)=L(c+w,chi),  R=7/5,  r=6/5,  M=16*Q*t.
```

The compact horizontal interval sigma in [1/2,3/2] corresponds to w in [-1,0]. It lies strictly inside the inner disk since 1<r<R. On the closed outer disk,

```
Re(c+w)>=1/10,
|c+w|<=t+3/2+7/5=t+29/10,
Q+1<=(3/2)Q.
```

The existing unconditional source theorem is `TernaryGoldbach/Explicit/LGrowth.lean:179`, `norm_LFunction_le`, with hypotheses `chi != 1` and `0<Re(s)` and conclusion

```
|L(s,chi)| <= (Q+1)*|s|/Re(s).
```

The exact file SHA256 is `5E6BD327045A95842498DD35DA4D4CA476D7DF37275EA612CD4FA46D2273C341`. Its binder and proof were read; it uses the actual L-function and character partial sums, with no PlattGRH binder. Thus for t>50,

```
|f(w)| <= 15*Q*(t+29/10) < 15.87*Q*t < M
```

on the entire closed outer disk. Nonprincipality gives analyticity on a neighborhood of this disk. No completed function, Gamma factor, or functional equation is needed for this estimate.

## 4. The center is nonzero and has a controlled logarithmic budget

The absolutely convergent Euler product at Re(c)=3/2 gives

```
|f(0)| >= product_p (1+p^(-3/2))^(-1)
        = zeta(3)/zeta(3/2) > 1/3.
```

Indeed zeta(3)>1 and the decreasing integral comparison gives `zeta(3/2)<1+integral_1^infinity x^(-3/2)dx=3`. Removing Euler factors at primes dividing Q only improves the lower bound. This also proves f is not identically zero.

Define the common nonnegative center budget

```
U=log(M/|f(0)|).
```

Then

```
0<=U<log(48*Q*t)=Z(t)+log(96*pi)<Z(t)+6.
```

For the last strict inequality it suffices that pi<22/7 and exp(1)>27/10: the exact comparison `(27/10)^6>96*(22/7)` is checked. The exponential bound follows already from its positive Taylor terms through degree5. These bounds are independent of conductor and height. Also M>1 and Z(t)>0 for Q>=2,t>50.

## 5. Finite zero removal, including inner-circle zeros

List every zero alpha of f in the **closed** inner disk |alpha|<=r, repeated according to its positive integer analytic order. This is a finite multiset: f is analytic on the larger open disk and not identically zero, so an infinite set of distinct zeros in the compact inner disk would accumulate inside the analytic domain. Each order is finite. Let N be its total cardinality with multiplicity. There is no supplied zero list, numerical completeness assertion, or simplicity hypothesis. Since f(0)!=0, all these alpha are nonzero.

For each repeated zero define the outer-disk Blaschke factor

```
B_alpha(w)=R*(w-alpha)/(R^2-conj(alpha)*w).
```

Its denominator is nonzero on |w|<=R, since |alpha|<=r<R. On |w|=R the factor has absolute value1, by expanding both squared norms. Put

```
g(w)=f(w)/product_alpha B_alpha(w),
```

with the analytic removable values at the listed zeros. More explicitly g equals f times the product of `(R^2-conj(alpha)*w)/R`, divided by the corresponding linear zero factors; local analytic factorization removes every apparent pole with its full multiplicity. The newly introduced numerator zeros lie outside the outer disk. Thus g is analytic on a neighborhood of the closed outer disk and is nonzero on a neighborhood of the **closed** inner disk. In particular, zeros exactly on |alpha|=r have been removed and cause no boundary failure. Zeros of f on |w|=R are harmless and need not be removed.

On the outer circle |g|=|f|<=M. The maximum-modulus principle gives |g|<=M throughout that disk. Define

```
h(w)=log M-log|g(w)|.
```

It is nonnegative and harmonic on a neighborhood of the closed inner disk; this follows locally from the analytic logarithm of a nonvanishing analytic function, and needs no single global choice of argument.

At the center the exact identity is

```
U=h(0)+sum_alpha log(R/|alpha|).
```

Since log(R/|alpha|)>=log(R/r)=log(7/6)>=1/7, we obtain the joint budget

```
h(0)+N/7 <= U.                                               (B)
```

The last logarithm inequality follows by integrating 1/x on [1,7/6] and bounding it below by6/7. This argument proves the needed zero-count bound directly from maximum modulus. It does not import a separate Jensen formula or choose a zero-free outer circle.

## 6. Harmonic and zero-factor losses on the segment

For |w|<=1, the Poisson formula on the radius-r disk gives Harnack's upper bound

```
h(w) <= (r+|w|)/(r-|w|)*h(0) <= 11*h(0).
```

Here h is nonnegative on the boundary, so the upper Poisson-kernel bound may be multiplied into the boundary integral. In detail, the kernel `(r^2-|w|^2)/|r*exp(i*theta)-w|^2` is at most `(r+|w|)/(r-|w|)`, and the unweighted circle average is h(0). The source API `Analysis/Complex/Harmonic/Poisson.lean:92`, `HarmonicOnNhd.circleAverage_poissonKernel_smul`, supplies the Poisson identity; the quantitative kernel inequality and its application remain to be instantiated. This file was read directly. Harmonicity on a neighborhood of the closed inner disk, established above, meets its domain requirement.

For a removed zero alpha and real w in [-1,0],

```
|R^2-conj(alpha)*w| <= R^2+R = R*(R+1),
|B_alpha(w)| >= |w-alpha|/(R+1).
```

Off its possible real zero,

```
-log|B_alpha(w)| <= log(R+1)-log|w-alpha|.
```

The logarithmic singularity is integrable. Writing a=Re(alpha), the pointwise distance inequality |w-alpha|>=|w-a| bounds the integral of the second term by that of `-log|w-a|`. For any real a, the positive part of this latter function is supported on |w-a|<1; its integral over [-1,0] is at most

```
integral_(-1)^1 -log|v| dv = 2.
```

Discarding its negative part only increases the upper bound. Hence

```
integral_(-1)^0 -log|B_alpha(w)| dw <= log(12/5)+2 < 3.        (F)
```

The last inequality uses exp(1)>27/10>12/5. Real zeros inside the segment or at its endpoints change only an integrable logarithmic singularity. Any finite convention for the log at the zero has no effect on the integral.

The factorization identity holds almost everywhere on the segment. Its integrated deficit is therefore

```
integral_(-1)^0 (log M-log|f(w)|) dw
 = integral h + sum_alpha integral -log|B_alpha|
 <= 11*h(0)+3*N
 <= 21*(h(0)+N/7) <= 21*U.                                  (D)
```

The crucial last step uses the **same** center budget for the harmonic and zero terms. Bounding them separately would waste this relation. All sums are finite, with actual multiplicities.

Since log M>0, (D) yields

```
integral_(1/2)^(3/2) log|L(sigma+it)| d sigma
 >= log M-21*U > -21*(Z(t)+6).
```

## 7. Tail, final constants, and what the allowance changes

The normalized Euler logarithm in Re(s)>1 satisfies `|log|L(s)||<=log zeta(Re(s))`. Consequently the tail from3/2 is bounded below by `-J(3/2)>-J(5/4)>-1.184`. The accepted paper/external certificate for J(5/4) is bound to integration review `REVIEW_ZETA_LOG_INTEGRAL_2026-11-11.md`, SHA256 `262ABBD71433135C1A3EC11703D28112E14DB2047B08303BA2A3829AB86B9DE2`. It is not yet a Lean theorem.

The compact integral and tail prove (Llocal). Compact integrability is also directly supported by `MeromorphicOn.intervalIntegrable_log_norm` in Mathlib's `Analysis/SpecialFunctions/Integrability/Log.lean:48`; the actual analytic horizontal restriction must be supplied. The tail is absolutely integrable by the Euler-log majorant. No exceptional-height exclusion was used in the lower bound.

For the conditional Turing consequence, let Zi=log(Q*ti/(2*pi)), so 0<Z1<Z2. Each of `I(t2)-I(t1)` and `I(t1)-I(t2)` is strictly less than

```
128+3.434+(21+.75)*Z2 = 131.434+21.75*Z2.
```

Using pi>3.14, the exact comparisons `42*3.14>131.434` and `6.93*3.14>21.75` establish (Tlocal) if Littlewood is proved with canonical Euler-log continuation. For a conjugate pair the allowance doubles, including when the character is real; dividing by an auxiliary interval length h produces `2*(42+6.93*Ztop)/h` in the average-count test. Enlarging h can reduce this term, but the endpoint and sign evidence must then be produced over that enlarged interval. No saturation success or runtime forecast is asserted here.

The literal historical allowance and this local allowance are not interchangeable in an already evaluated certificate. A consumer adopting the local route must recompute its exact integer-rounding inequality with the larger bound. The final mathematical Goldbach root can remain identical, but a fixed finite certificate may cease to suffice.

## 8. Evidence and remaining formal work

The accompanying `turing_horizontal_lower_scalars_20261111.py` uses only rational arithmetic and positive Taylor sums. Its JSON checks the disk geometry, growth coefficient15.87<16, log and exponential scalar comparisons, Harnack factor11, joint budget coefficient21, lower intercept127.184, both final Turing coefficients, and the historical3.450608 rounding. It does not claim any complex-analysis theorem kernel checked. File hashes are supplied with the frozen handoff.

The local paper proof leaves these implementation tasks, all explicit:

1. Instantiate actual nonprincipal L analyticity and the existing source growth bound; derive the Euler-product center bound and tail majorant.
2. Represent the finite analytic zero multiset on the closed inner disk with exact orders. Prove the finite Blaschke division extends analytically and removes all those orders, including inner-boundary zeros.
3. Instantiate maximum modulus and harmonic log norm, then derive the elementary Harnack bound from the existing Poisson formula. This requires no contour zero-count certificate.
4. Formalize the real logarithmic integral comparisons and exact scalar checks, together with the accepted J certificate's analytic and interval replay bridges.
5. Independently prove the normalized Littlewood identity and its a.e./closed-count endpoint adapter before using (Tlocal) in family completeness.

Thus the local route removes the specialized Hadamard, Gamma, Booker/Lehman, zeta-derivative, and sharp I_E(1) leaves. It does not remove general complex analysis or the Littlewood/counting argument, and it supplies no new axiom or root hypothesis.
