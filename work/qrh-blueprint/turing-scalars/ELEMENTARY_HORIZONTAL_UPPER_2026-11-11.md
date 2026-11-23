# An elementary alternative to the sharp Turing upper bound

2026-11-11. New research alternative, pending independent review. It preserves the same primitive-character family and final Goldbach theorem. Its larger auxiliary allowance trades computation for a smaller analytic proof. No claim is made that any production sign packet meets that allowance. No Lean build, spectral scan, canonical edit, or frozen-note edit was performed.

## Source-backed growth estimate

At target commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`, `TernaryGoldbach/Explicit/LGrowth.lean:179` states

```
TernaryGoldbach.Explicit.norm_LFunction_le
  (hchi : chi != 1) (hs : 0 < s.re) :
  norm (chi.LFunction s) <= (Q+1)*norm(s)/s.re.
```

Here Q is a natural modulus with NeZero Q; chi is an actual complex Dirichlet character. The coordinator read the whole source file, including its imports and proof. It bounds periodic partial sums by Q+1, identifies L with the partial-sum integral first on Re(s)>1 and then by analytic continuation on Re(s)>0, and integrates the absolute majorant. No PlattGRH premise appears in this declaration or its displayed argument. This is source inspection, not a new compilation or transitive axiom audit.

Let Q>1, chi primitive, and t>50. Primitivity excludes the principal character at such a modulus. Put `Z(t)=log(Q*t/(2*pi))`, which is positive. The upper horizontal integral is the same actual function

`I_chi(t)=integral_(1/2)^infinity log(norm(L(sigma+i*t,chi))) d sigma`.

Compact integrability across zeros and the canonical Euler-log tail are justified by the separate horizontal-upper plan. In particular, actual log norm is locally integrable across finite-order zeros; no zero-free premise is imposed on the compact interval. The positive-half-plane growth estimate here replaces only Rademacher's sharper estimate.

## Elementary compact-interval bound

For `1/2<=sigma<=5/4`, we have

```
Q+1 <= (3/2)*Q,
1/sigma <= 2,
norm(sigma+i*t)/t = sqrt(1+(sigma/t)^2)
                  < sqrt(1+1/1600) < 1001/1000.
```

All divisions have positive denominators. Thus the source growth theorem gives

`norm L(sigma+i*t) < (3003/1000)*Q*t`.

Use the elementary inequalities `pi<22/7` and `exp(3)>19`. The latter follows from the positive exponential Taylor polynomial through degree6. Exact rational arithmetic gives

`(6006/1000)*pi < (6006/1000)*(22/7) < 19 < exp(3)`.

Away from zeros, monotonicity of log therefore implies

`log(norm L(sigma+i*t)) < Z(t)+3`.

The compact interval has length3/4, so the integral is at most `(3/4)*Z(t)+9/4`. Using the already independently reviewed external/paper bound

`J=integral_(5/4)^infinity log zeta(sigma) d sigma < 148/125`,

and the absolute Euler-log majorant for the L-function tail gives

```
I_chi(t) < 1717/500 + (3/4)*Z(t)
         = 3.434 + .75*Z(t).                              (E)
```

The J packet is `ZETA_LOG_INTEGRAL_2026-11-11.md`, SHA256 `66DCFC80712A8773682D23F2121BB05A2494CEE1AD7EB7A975EEAED7B399852E`, with independent review `agents/integration/REVIEW_ZETA_LOG_INTEGRAL_2026-11-11.md`, SHA256 `262ABBD71433135C1A3EC11703D28112E14DB2047B08303BA2A3829AB86B9DE2`. Its interval and analytic formalization remain obligations. Equation(E) needs no Gamma-ratio estimate, functional equation, or Phragmen-Lindelof theorem for its compact upper bound.

## Conditional integrated-S consequence

Retain the historical lower horizontal target as an explicit unfinished proof obligation:

`I_chi(t) > -34507/10000 - (6/25)*Z(t)`.

Also retain Littlewood's canonical-log identity as a separate obligation:

`pi*integral_(t1)^(t2) S_chi(t) dt = I_chi(t2)-I_chi(t1)`.

For 50<t1<t2, monotonicity of Z and(E) give both signs of the difference bounded by

`68847/10000 + (99/100)*Z(t2)`.

Since pi>157/50, exact coefficient comparisons prove the sufficient replacement

```
abs(integral_(t1)^(t2) S_chi(t) dt)
 < 11/5 + (8/25)*log(Q*t2/(2*pi)).                         (T)
```

This does not prove the lower bound or Littlewood identity. It removes the sharp upper Rademacher estimate from a complete route once those remaining results and their formalization are supplied. The statement applies separately to chi and its inverse, with both parities and no conductor upper bound.

## Effect on the same completeness test

The accepted family plan uses any proved upper allowances in

`U = (integral G - W + B_chi + B_inverse)/h`,

then requires `U<K_main+1`. It does not intrinsically require the historical constants. The closed-endpoint addendum retains this form with the count identity used almost everywhere.

Compared with `B_old=1.8397+.1242*Z(T+h)`, the new allowance is larger by

`Delta=3603/10000+(979/5000)*Z(T+h)` per channel.

For exactly the same T,h,W and gamma enclosure, the computed upper U increases by `2*Delta/h`. This also applies to a real character, whose two channels are counted twice. A packet that formerly passed remains certified by this replacement only if its actual margin exceeds that surcharge. Increasing h requires new auxiliary evidence and recalculated allowances; it is not automatically a proof that a packet will pass.

Neither Hcert, the full conductor family, the requested beta bound, nor any Goldbach root premise changes. No production packet is accepted by this note, and no efficiency estimate is inferred. The sharper source route remains available if the larger allowance is too costly.

## Scalar evidence and remaining work

`elementary_horizontal_upper.py` checks12 rational inequalities and identities, including the norm factor, exp3 Taylor bound, intercept, slope and allowance surcharge. It writes a separate receipt and uses no floating-point acceptance or special-function evaluator. These checks verify arithmetic, not the analytic theorem.

Independent review must inspect the actual LGrowth declaration and its proof scope; the elementary norm/log reduction; compact log integrability and Euler-log tail dependencies; both signs of the Littlewood difference; and the two-channel completeness surcharge. All Lean wrappers, transitive axiom validation, lower-bound proof, Littlewood identity and actual family evidence remain open.
