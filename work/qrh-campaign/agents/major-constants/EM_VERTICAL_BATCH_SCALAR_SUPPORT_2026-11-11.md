# Scalar error support for vertical batching of finite EM main sums

2026-11-11. Independent paper and exact-arithmetic support for the scheme supplied by moebius_route. Corrected version: section 5 uses the geometric factor for radius 1/8, replacing the erroneous factor from radius 1/64 in the previous version. The exact combined budget still passes; the primary residual truncation and all workload counts are unchanged. No moments, transforms, coefficient values, zeta values, or panel margins were evaluated. This note bounds the additional batching error only. The EM remainder, finite-g Taylor remainder, coefficient arithmetic, and contour acceptance obligations remain separate.

## 1. Exact scheme and residual interval

Fix `N=333334`, K=24, a real `sigma>=629/1250`, and exact centers

```
s_j=sigma+i*(t0+j*Delta),  0<=j<J,
```

with positive integer J and positive real Delta. Rational Delta is convenient for a checker. Let L be a power of two with `L>=4J`. For each n=1,...,N define

```
x_n=L*Delta*log(n)/(2*pi).
```

Choose a certified rational midpoint m_n with `|m_n-x_n|<=1/8`, and set `q_n=floor(m_n+1/2)`. This makes `|x_n-q_n|<=5/8`, including midpoint ties. Let

```
k_n=q_n mod L,
delta_n=Delta*log(n)-2*pi*q_n/L,
r_n=J*delta_n,    y_j=j/J.
```

All r_n are exact real numbers, even though their numerical enclosures may have width. Since `pi<22/7`,

```
|r_n|<=5*pi*J/(4L)<=5*pi/16<55/56<1,
0<=y_j<1.
```

The bin must be justified by its midpoint error, not by an unchecked rounded logarithm. Integer q_n, including its value before reduction modulo L, is retained to define the residual.

For jet order `0<=h<24` and residual order `0<=m<p`, define exact complex bucket moments

```
A_(h,m,k)=sum_(n:k_n=k)
          n^(-s_0)*(-log n)^h/h! *(-i*r_n)^m/m!.
```

With the normalized positive transform

```
Dplus(A)_ell=(1/L)*sum_(k=0..L-1) A_k*exp(2*pi*i*k*ell/L),
```

the approximation to the normalized main-sum jet is

```
S_hat_(h,j)=L*sum_(m=0..p-1) y_j^m*Dplus(A_(h,m,*))_(-j mod L).
```

Indeed `j*Delta*log n=2*pi*j*q_n/L+y_j*r_n`. The negative output index and the factor L are both necessary with this convention. This is a finite algebraic identity with a truncated residual exponential, not an approximation of centers by a Fourier lattice. Every center remains the exact s_j above.

## 2. Real-phase Taylor remainder

For real theta and p>=1,

```
|exp(-i*theta)-sum_(m=0..p-1)(-i*theta)^m/m!|
 <= |theta|^p/p!.
```

Apply the integral Taylor remainder on the real interval [0,1] to `f(t)=exp(-i*theta*t)`. Its p-th real derivative has constant norm `|theta|^p`, and the integral kernel has mass 1/p!. The pinned Mathlib file `Analysis/Calculus/Taylor.lean:535` provides `taylor_integral_remainder` for a complete real normed space, hence also for complex-valued f. The function is smooth on the whole real line, so its differentiability hypotheses hold. This avoids the invalid use of a real scalar mean-value formula for a complex-valued function.

The phase here is the actual real number `y_j*r_n`; interval width in r_n belongs to the arithmetic enclosure of the moments. Thus the additional error in an exact jet is at most

```
|S_h(s_j)-S_hat_(h,j)| <= W_h/p!,
W_h=sum_(n=1..N) n^(-sigma)*(log n)^h/h!.                 (1)
```

A generic complex exponential tail `exp(R)*R^p/p!` would also be safe for `|theta|<=R`, but is not needed for this real-phase bound.

## 3. Individual jet weights and a weighted disk bound

Since sigma>1/2 and `sqrt(N)<578`, decreasing-function integration gives

```
sum_(n=1..N)n^(-sigma) <=2*sqrt(N)-1<1156.
```

Also log(N)<13. One entirely rational certificate is `(8/3)^13>N+1` together with `exp(1)>8/3`, the latter from the first five exponential Taylor terms. Therefore

```
W_h<1156*13^h/h!, 0<=h<24.
```

The maximum of these 24 rational bounds is `6733146600397009/119750400<2^26`. A looser generic estimate, including an unnecessary factor exp(1)<3, is `<2^33`. Consequently p=48 certainly makes every individual jet truncation error less than `2^-120`. Exact factorial comparisons also show that the looser `2^33/p!` bound permits p=36 for `2^-100` and p=39 for `2^-120`. These are scalar alternatives, not claims about an optimized implementation.

For the principal panel consumer, use its actual coefficient weights instead. If `0<=rho<=1/8`, then

```
sum_(h=0..23) rho^h*W_h
 <=sum_(n=1..N)n^(-sigma)*exp(rho*log n)
 <=sum_(n=1..N)n^(-3/8)
 <=(8/5)*N^(5/8)-3/5 <8192.                            (2)
```

The last strict inequality follows from the exact integer test `N^5<5120^8`. All discarded terms in the exponential series are nonnegative. This proof does not discard a positive zero contribution or posit cancellation.

## 4. Propagation through finite g and its quotient

The source-faithful finite EM function is

```
g(s)=(s-1)*[main_sum(s)+half_term(s)+Bernoulli_terms(s)]
      +(N+1)^(1-s).
```

This is the expression checked in `HIGH_PRINCIPAL_SLAB_SCALAR_SUPPORT_2026-11-11.md`, SHA256 `5176DAF690017CF8889BF14F22A882CF93B713B76D126983AAB7359BA8ECB060`, and in the reviewed coefficient-semantics packet. Only the main-sum jets are replaced by the batching scheme. Half terms, corrections, and the pole-removal term must still be enclosed separately.

At a fixed center c=s_j, let e_h be the additional main-sum coefficient error. Multiplication by s-1 changes the degree-h error to `(c-1)e_h+e_(h-1)`, where e_-1=0. Retaining exactly degrees 0,...,23 gives the polynomial error bound

```
sum_(h=0..23) rho^h*|(c-1)e_h+e_(h-1)|
 <=(|c-1|+rho)*sum_(h=0..23)rho^h*|e_h|.
```

The omitted degree-24 product term is not silently included in the finite polynomial. The displayed inequality drops it in the safe direction while bounding only the retained coefficient errors. The existing finite-g Taylor remainder still bounds the actual omitted Taylor series.

On `|s-c|<=rho`, `|s-1|>=|c-1|-rho`. If `|c-1|>3rho`, this division amplifies the weighted coefficient error by less than 2. This condition holds for high-ordinate centers and must be explicitly checked in a general application. From (1) and (2), the additional quotient error from residual truncation alone is then less than

```
2^14/p!.
```

The exact test `32!>2^114` proves that p=32 makes this error less than `2^-100`. This is a weighted panel/quotient conclusion. It does not assert that each of the 24 individual jets has error below `2^-100`.

## 5. Moment and transform arithmetic cannot be omitted

The moment centers and transform outputs must enclose the exact A values, including baseline exponentials, logarithms, residuals, factorial normalization, accumulation, roots of unity, and transform roundoff. If the normalized moment-transform output for each m,h has Euclidean radius at most eps_mh, and exact center contraction is used, the resulting jet arithmetic error is at most

```
L*sum_(m=0..p-1) y_j^m*eps_mh.
```

For the two examples J=1024 or 4096, y_j is dyadic. Exact rational contraction of serialized rational output centers is therefore possible, though this note gives no implementation or storage-bit bound. For other implementations, add the center-contraction error and any approximated y_j weights.

One sufficient optional allocation for p=32 is to require every normalized output radius to be at most `2^-104/(L*p)`. It then produces each jet arithmetic error at most `2^-104`. After the same finite-g multiplication and quotient, their disk contribution is at most `(16/7)*2^-104`, since for `rho<=1/8` the disk weight sum is at most 8/7. Exact arithmetic verifies

```
2^14/32! + (16/7)*2^-104 <2^-100.                        (3)
```

Thus p=32 can retain the full `2^-100` batching allowance even with this explicit finite-arithmetic budget. The output-radius requirement is a finite obligation to be produced, not an assumed evaluator theorem. It includes moment-input error; a certified FFT of uncertified bucket moments would not suffice.

On the particular accepted high slab, the previously checked analytic EM-plus-Taylor square allowance was `(3/2)*(2^-38+2^-21/7)/2^19`. Adding (3) still stays below `2^-42`. This comparison applies only where those original N/M/domain bounds hold. It transfers no EM or spectral margin to other heights or rectangles.

## 6. Arithmetic and storage counts for the proposed loops

The following counts use L=4J and p=32. They concern direct construction of all K*p bucket arrays, K*p normalized radix-two transforms, and contraction at J centers.

| Count | J=1024, L=4096 | J=4096, L=16384 |
|---|---:|---:|
| Main moment contributions N*K*p | 256000512 | 256000512 |
| Naive separate-center coefficient contributions J*N*K | 8192016384 | 32768065536 |
| Normalized transforms K*p | 768 | 768 |
| Dense bucket entries K*p*L | 3145728 | 12582912 |
| Radix-two butterflies K*p*(L/2)*log2(L) | 18874368 | 88080384 |
| Final contraction terms J*K*p | 786432 | 3145728 |
| Moment entries if one jet order is streamed | 131072 | 524288 |

The receipt also records p=48, which increases the moment, transform, and storage counts by 3/2. One exact baseline exponential per n can be shared across h and m. The moment-count comparison excludes the cost of computing certified logarithms, phases, bins and residuals, plus FFT twiddles, interval widths, and EM corrections. It is not a complete operation count or a runtime claim. Streaming a jet order may require recomputation or retaining per-n data; those storage/arithmetic choices must be stated by an implementation.

The primary mathematical gain is that the moment-construction sum is independent of J at fixed p. No assertion of a faster actual certificate follows until moment error, transform error, serialization and the final panel comparisons have been produced and checked.

The companion `em_vertical_batch_scalar_support_20261111.py` uses only exact rational/integer calculations and writes a JSON receipt. It checks the factorial targets, weight bounds, optional arithmetic allocation, old-slab allowance and counts. No numerical Fourier transform, L-value, or source edit was performed.
