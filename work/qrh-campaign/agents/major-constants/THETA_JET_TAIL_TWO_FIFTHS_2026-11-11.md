# Uniform theta jet tails down to imaginary part two fifths

2026-11-11. Independent paper derivation and pinned-source check. The proposed bound is valid, including the closed boundary `Im(v)=2/5`. It applies to the ordinary complex derivatives of orders 0, 1, and 2 of the three classical theta constants. No numerical theta evaluation, spectral assertion, Lean implementation, or change to a frozen packet is made here.

## 1. Exact statement and truncations

For `Im(v)>0`, use

```
theta3(v) = sum_(n in Z) exp(pi*i*n^2*v),
theta4(v) = sum_(n in Z) (-1)^n exp(pi*i*n^2*v),
theta2(v) = sum_(n in Z) exp(pi*i*(n+1/2)^2*v).
```

Let `N` be any natural number, including zero, and define finite approximants

```
T3,N(v) = 1 + 2 sum_(n=1..N) exp(pi*i*n^2*v),
T4,N(v) = 1 + 2 sum_(n=1..N) (-1)^n exp(pi*i*n^2*v),
T2,N(v) = 2 sum_(n=0..N-1) exp(pi*i*(n+1/2)^2*v).
```

An empty finite sum is zero. Put `u=N+1/2`. For `r` equal to 2, 3, or 4, for `j` equal to 0, 1, or 2, and for every complex `v` satisfying `Im(v)>=2/5`,

```
|theta_r^(j)(v) - T_r,N^(j)(v)|
    <= 384 exp(-u^2/5).                                      (A)
```

Consequently, if `M` is a natural number with `5M<=u^2`, then

```
|theta_r^(j)(v) - T_r,N^(j)(v)| <= 384*2^(-M).                (B)
```

These bounds are independent of the real part of `v`. They therefore apply uniformly to any point enclosure contained in the closed half-plane `Im(v)>=2/5`. A center in that half-plane does not suffice if its enclosure extends below it.

## 2. Source normalization and existing APIs

The inspected Mathlib checkout is

`C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`

at the target dependency pin `56a005855ea17e0b0958f73ec801ae140b0a1679`.

* `Mathlib/NumberTheory/ModularForms/JacobiTheta/OneVariable.lean:29` defines `jacobiTheta` by the integer series above. `jacobiTheta_eq_jacobiTheta₂` at line 32 identifies it with the two-variable function at first argument zero. `hasSum_nat_jacobiTheta` at line 79 and `jacobiTheta_eq_tsum_nat` at line 94 give the central term and positive-pair normalization. File SHA256 `7C29B4B07AED2E46D40FE408362F2A707126BFBBF05C3B374420AA0EDDF06B5C`.
* `Mathlib/NumberTheory/ModularForms/JacobiTheta/TwoVariable.lean:46` defines the term as `exp(2*pi*i*n*z + pi*i*n^2*v)`. The sum is defined at line 252, summability is recorded at line 262, and the joint derivative theorem begins at line 294. File SHA256 `CC4E420DA8441AD20DDBE3709040C4CFBEBB530C6DDD8E101FF2FC1F0B6F8820`.
* Thus classical `theta4(v)=jacobiTheta₂ (1/2) v`, while `theta2(v)=exp(pi*i*v/4)*jacobiTheta₂ (v/2) v`. The latter follows by combining exponents into `pi*i*(n+1/2)^2*v`. The source subscript 2 means two variables; it does not mean classical theta2. These two named classical wrappers and their second-derivative tail theorem remain to be implemented.
* `Mathlib/Analysis/Calculus/SmoothSeries.lean:89`, `hasDerivAt_tsum_of_isPreconnected`, accepts an open preconnected set, termwise derivatives with a summable uniform norm majorant, convergence at one point, and membership of the evaluation point. It returns the derivative of the sum as the sum of derivatives. Its Fréchet version is at line 72. File SHA256 `4EE4C5646105728EE6A257B0ECE7FB80FFA6FB246370471EBFA8FEFF567EC0E7`.
* `Mathlib/Analysis/Complex/Exponential.lean:249`, `Real.sum_le_exp_of_nonneg`, bounds every finite nonnegative exponential Taylor sum by the exponential. `Real.add_one_le_exp` is at line 633. These support the elementary estimates below. `OneVariable.lean` already demonstrates `norm_exp`, geometric summability, and the norm of a sum bounded by the sum of norms.

The proof uses the usual elementary inequalities `3<pi<4`. There is no Fourier normalization of `2*pi` in the second argument: the derivative multiplier here is exactly `pi*i*a^2`.

## 3. One pair and the summable majorant

Write `Y=Im(v)`. For a real mode `a>=1/2`, the ordinary derivative of order `j` of `exp(pi*i*a^2*v)` is

```
(pi*i*a^2)^j exp(pi*i*a^2*v),
```

whose norm is `(pi*a^2)^j exp(-pi*Y*a^2)`. For each `j=0,1,2`,

```
(pi*a^2)^j <=16*a^4.
```

For `j=0`, use `a^4>=1/16`. For `j=1`, use `16a^2>=4>pi`. For `j=2`, use `pi^2<16`. This estimate would be false at `a=0` for `j=0`; that mode is treated separately.

Set `t=a^2>=0`. The nonnegative exponential series gives `exp(t)>=t^2/2`, hence `a^4<=2 exp(a^2)`. Both signs of a mode together therefore have norm at most

```
2*16*a^4 exp(-pi*Y*a^2)
 <=64 exp(-(pi*Y-1)*a^2)
 <=64 exp(-(3Y-1)*a^2)
 <=64 exp(-a^2/5),                                      (C)
```

where the last inequality uses `Y>=2/5`. The theta4 phase has modulus one and is the same for opposite integer modes. No cancellation is required.

Theta2 pairs `n` with `-n-1`, so its first omitted absolute mode is exactly `u=N+1/2`. Theta3 and theta4 pair `n` with `-n`; their first omitted absolute mode is `N+1`, which is greater than `u`. Their zero mode is 1 for derivative order zero and 0 for positive derivative orders. It is retained exactly, and theta2 has no zero mode.

For all integers `k>=0`,

```
(u+k)^2 = u^2+2uk+k^2 >= u^2+k.
```

Indeed `2u>=1`; this even holds without using `k^2>=k`. For the integer tails use `N+1+k>=u+k` before this estimate. The sum of (C) is at most

```
64 exp(-u^2/5) sum_(k>=0) exp(-k/5)
 =64 exp(-u^2/5)/(1-exp(-1/5))
 <=384 exp(-u^2/5),
```

because `exp(1/5)>=1+1/5=6/5`. This proves (A), once the derivative series has been identified with the actual derivatives.

## 4. Local convergence and actual derivatives

The closed lower bound `Y>=2/5` is a bound on the evaluation domain, not the open set on which differentiation is justified. For any point of this domain take, for example, the open half-plane `Im(v)>1/5`. It is convex and contains that point as an interior point.

More generally, for a fixed `eta>0`, for `Im(v)>=eta`, and for each fixed nonnegative integer `j`, the exponential Taylor inequality yields

```
(pi*a^2)^j exp(-pi*eta*a^2)
 <= j!*(2/eta)^j exp(-pi*eta*a^2/2).                     (D)
```

Apply `exp(t)>=t^j/j!` with `t=pi*eta*a^2/2`. Each paired mode sequence has `a>=k+1/2`, so the right side is bounded by a constant times a geometric sequence in `k`, uniformly in `v` on this half-plane. The finitely many zero or initial modes cause no problem.

Use (D) with `eta=1/5` and orders 0, 1, 2. It proves absolute convergence of each series and summable uniform bounds for the derivatives. Apply the cited open-set sum-derivative theorem to the order-zero terms, then to the order-one terms. Thus the order-one and order-two sums are the ordinary derivatives of the source functions. Finite differentiation and the absolute tail reindexing then justify the subtraction in (A). This argument also proves local uniform convergence throughout the upper half-plane by choosing a smaller positive `eta` below the point under consideration.

No claim that convergence on a closed half-plane alone permits differentiation is needed. No third derivative or derivative of the numerical tail bound is used.

## 5. A terminating rational cutoff rule

Let a desired tail tolerance be the positive rational `epsilon=p/q`, with positive integers `p,q`. Choose `M>=0` by repeated doubling until

```
p*2^M >=384*q.
```

This search terminates since powers of two are unbounded. Next choose any natural `N` satisfying

```
(2N+1)^2 >=20M.
```

This is exactly `5M<=(N+1/2)^2`. It too is a finite integer search; `N=5(M+1)` is an explicit, deliberately loose upper bound on a successful search. A smaller cutoff can be found by integer binary search. If the surrounding evaluator requires `N>=1`, impose that additional harmless minimum.

Finally, monotonicity of the exponential and `exp(1)>=2` give

```
exp(-u^2/5)<=exp(-M)=exp(1)^(-M)<=2^(-M).
```

Hence (B) is at most `epsilon`. The tests involve only integers and do not require evaluating logarithms, square roots, or theta functions. For a strict tolerance, replace the first test by a strict inequality.

For Taylor coefficients normalized by `j!`, dividing (A) or (B) by `j!` is valid; using the same bound without division is also safe for these three orders. If the consumer differentiates with respect to another variable, its chain-rule factors must still be applied. Likewise, a modular transformation may amplify the seed errors. This note bounds the reduced-point derivatives only, and does not remove those propagation terms.

## 6. Scope of the domain repair

The theorem covers the modular reduction guarantee `Im(v)>2/5` without replacing it by `Im(v)>=1`. It even covers equality. It supplies a finite, exact-arithmetic tail cutoff for all three reduced theta jets through order two. Finite terms, modular word identities and branch choices, certified point-domain containment, outward rounding, and propagation to the original theta or xi value remain separate checker obligations. The analytic result is a paper derivation supported by the source APIs above, not a newly accepted Lean theorem or a successful numerical enclosure.
