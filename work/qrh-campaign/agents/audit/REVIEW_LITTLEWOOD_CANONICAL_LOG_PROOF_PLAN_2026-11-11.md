# Independent review of canonical Littlewood and its horizontal-bound join

2026-11-11. **PASS at paper-proof level, with no correction requested.** The reviewed proof establishes the actual canonical identity at every pair of endpoints in its stated domain. Its branch normalization, signs, multiplicities, local regularity, and right-edge limit are sound. No RH, simplicity, numerically complete zero inventory, or endpoint nonvanishing premise is hidden in the argument.

No Lean build, prime or zero scan, source mutation, dependency change, or frozen-package edit was performed. Source/API reads are not an elaboration or axiom-closure check. This review is separate from a final compiled Turing theorem and from acceptance of any finite family certificate.

## Reviewed pins

| Artifact | SHA256 |
| --- | --- |
| `mellin/LITTLEWOOD_CANONICAL_LOG_PROOF_PLAN_2026-11-11.md` | `6BB683D71E4B96A593E93699B3EEF52CF5443289DED3B1CEE06B3C232B7253D9` |
| `audit/TURING_HORIZONTAL_LOWER_PROOF_PLAN_2026-11-11.md` | `A8D21679E5BF2C631D7399D73A70E85E3486EBC6A92CC1668C5060E77E2E11C9` |
| Independent lower review, `integration/REVIEW_TURING_HORIZONTAL_LOWER_PROOF_PLAN_2026-11-11.md` | `B4CAE7485D7BB6655D207BEB2E1716A904F637E36753C48EF5D15FD1A6B41992` |
| Independent upper review, `integration/REVIEW_ELEMENTARY_HORIZONTAL_UPPER_2026-11-11.md` | `696E6E8B9C73D3AE3593F2D5C1386E4B386048DA046915CD976C0A43425D7E94` |

These hashes were verified directly. The upper producer is `work/qrh-blueprint/turing-scalars/ELEMENTARY_HORIZONTAL_UPPER_2026-11-11.md`, pinned by its review to `0875B2B87A02421B7B8CD6CAD0D1C33433A051E240F48EA4C5F45FE04558BD27`. The J-integral paper/external evidence is independently reviewed at `262ABBD71433135C1A3EC11703D28112E14DB2047B08303BA2A3829AB86B9DE2`; its formal replay remains open.

The actual primary printed identity is Trudgian, [arXiv:0903.1885v3](https://arxiv.org/pdf/0903.1885), Lemma3.4. The detailed proof being reviewed is the author's finite-factorization reconstruction, not an assumption that the citation itself supplies a Lean theorem.

## 1. Exact carrier and Euler normalization

The carrier is the actual entire continued function `DirichletCharacter.LFunction chi` for a primitive nonprincipal character of conductor Q>1. I directly re-read pinned Mathlib `NumberTheory/LSeries/DirichletContinuation.lean:74` (`LFunction_eq_LSeries`) and line97 (`differentiable_LFunction`). They give the claimed series equality for Re(s)>1 and entire differentiability under chi!=1. The proof does not replace this function by a completed function, numerical evaluator, or finite sum.

For Re(s)>1 the positive-majorized double Euler-log series converges absolutely and locally uniformly. Its exponential is L and its real part is log|L|. This fixes the logarithm at right infinity. For sigma>=2,

```
|ell(sigma+it)| <= log zeta(sigma)
 <= zeta(sigma)-1
 <= 2^(-sigma)*(1+2/(sigma-1)) <= 3*2^(-sigma).
```

The decreasing integral comparison used here has the correct lower endpoint2. Its integrated tail is `3*2^(-R)/log2`, uniform in t. This proves absolute integrability, not merely a pointwise upper bound on an undefined improper integral.

At Re(s)=2, the same Dirichlet-series comparison yields |L-1|<3/4, putting L in the right half-plane. Hence its principal logarithm there agrees with ell by continuation from right infinity. The vertical path from2 to2+it retains the initial imaginary value Im ell(2). That value can be nonzero for a nonreal character. Resetting it to zero, or using the principal argument of the final critical-line value, would be invalid; the reviewed note does neither. No root-number argument is added to S.

## 2. Actual finite factorization and the branch integer

An open bounded rectangle U is chosen with the entire compact integration rectangle strictly inside it. Since L is entire and not identically zero, its zeros on the compact closure of U are finite, with finite analytic orders. Dividing by every corresponding linear factor with its full order removes the apparent poles and leaves a holomorphic nonvanishing quotient on U. Zeros on the boundary of U do not obstruct this argument; division removes them too, while U itself is the log domain.

The simply connected rectangle admits a holomorphic logarithm h of this quotient. Every removed zero has real part less than R because R>=2 and the Euler half-plane is zero-free. Thus the principal log of each factor is holomorphic on a narrow connected neighborhood of the right vertical segment.

On that neighborhood,

```
ell - h - sum_j m_j*Log(s-rho_j)
```

has exponential1. Its holomorphic continuity into the discrete set 2*pi*i*Z makes it a single constant. Adjusting h by this one constant establishes exact right-edge equality for the entire height interval. This correctly supplies the branch integer that would otherwise be missing.

For t different from the finitely many zero ordinates, each factor's horizontal path stays in the upper or lower half-plane. Its principal Arg is continuous along that path, even when its real part becomes negative. Since it matches the right-edge factor log, uniqueness of continuation gives the exact left-edge formula for pi*S. This also shows S defined in the construction is independent of the chosen R and auxiliary rectangle: it is the same Euler-anchored horizontal continuation.

There is no assertion that a computed list contains all zeros. The finite set is the mathematically defined actual zero set. Enriching the exceptional set to all nontrivial zero ordinates in the compact height interval changes no a.e. conclusion; the minimal finite exceptional set from the rectangle already suffices for the identity.

## 3. Single-zero calculus and all boundary cases

For rho=beta+i*gamma and beta<R, put

```
H_rho(t)=integral_a^R log|sigma-beta+i*(t-gamma)| d sigma,
a=1/2.
```

For y=t-gamma!=0, direct differentiation gives

```
H_rho'(t)=integral_a^R y/((sigma-beta)^2+y^2) d sigma
         =Arg(a-beta+i*y)-Arg(R-beta+i*y).
```

The sign is correct because the derivative of Arg(x+i*y) in x is negative y/(x^2+y^2). Its absolute integral is at most pi over any subinterval of the real line. The displayed antiderivative

```
(x/2)*log(x^2+y^2)-x+y*atan(x/y)
```

has x derivative log|x+i*y| for either sign of y. Its limit as y tends to0 is x*log|x|-x, with the continuous value0 at x=0. This proves continuity even when beta is an integration endpoint. Joining the two pi-Lipschitz sides across gamma then proves H_rho is pi-Lipschitz and absolutely continuous on the full height interval.

Thus a zero creates an integrable logarithmic singularity and a derivative jump, but no jump in H_rho itself. Multiplication by its integer order multiplies both statements; no simplicity assumption is used.

The branch limits at a are exactly:

| Real part of zero | Lower/upper Arg limits at its ordinate | Jump in S per multiplicity |
| --- | --- | --- |
| beta>a | -pi, +pi | 2 |
| beta=a | -pi/2, +pi/2 | 1 |
| beta<a | 0, 0 | 0 |

The right-edge Arg is continuous since R-beta>0. The analytic h is continuous. This verifies the note's jump formula, including zeros exactly on the critical line. For a primitive character, interpreting the jump as the total count at that ordinate uses the separate same-character reflection rho -> 1-conj(rho), including equality of analytic orders. That symmetry is not needed for Littlewood's identity itself. Conjugation alone would not preserve the character in general.

## 4. Finite-width identity, endpoint values, and regularity

The finite factorization gives an equality of log-norm integrands away from finitely many zero points on each horizontal segment. Those exceptions are negligible and their singularities integrable. Consequently

```
I_R(t)=integral_a^R Re h(sigma+i*t) d sigma + sum_j m_j*H_rho_j(t).
```

The analytic term is continuously differentiable on the compact height interval, while the finite zero sum is Lipschitz. Hence I_R is absolutely continuous. Writing h=u+i*v, Cauchy–Riemann gives u_t=-v_sigma, and therefore the analytic derivative is v(a,t)-v(R,t). Adding the zero terms and using the exact right-edge normalization yields

```
I_R'(t)=pi*S(t)-Im ell(R+i*t)
```

almost everywhere, with the claimed positive sign in front of S.

The finite expression for S is bounded and measurable away from the finite exceptional set. Assigning any finite value at each exceptional point preserves local boundedness, measurability, and every integral. One-sided limits exist; taking their average is permissible but unnecessary for the integral identity. The absolutely continuous fundamental theorem consequently applies to arbitrary endpoints, including zero ordinates, without extra weights or perturbation terms.

The distinction is essential: zeros can create jumps in I_R', but I_R remains continuous. There is no first-derivative point mass to add to the integrated identity.

## 5. Infinite right edge

Both limiting estimates are uniform and sufficient:

```
|I(t)-I_R(t)| <= 3*2^(-R)/log2,
|integral_(t1)^(t2) Im ell(R+i*t) dt| <= 3*(t2-t1)*2^(-R).
```

Passing to the limit in the already integrated finite-width identity establishes

```
pi*integral_(t1)^(t2) S(t) dt = I(t2)-I(t1)
```

at every 50<t1<t2. No exchange of an uncontrolled derivative limit is used. The further claim that I is locally Lipschitz is also justified: first bound the canonical S on a fixed compact interval using R=2, then apply the established all-endpoint identity. The proof correctly does not infer Lipschitz regularity merely from uniform convergence of I_R.

## 6. Join to the new local Turing allowance

The reviewed identity and the two reviewed horizontal bounds have exactly the same actual I, nonprincipal carrier, conductor, and height domain. Both bound I at all t>50, including exceptional ordinates. There is therefore no endpoint-domain gap in their join.

Set Zj=log(Q*tj/(2*pi)). Then 0<Z1<Z2 and the bounds are

```
-128-21*Zj < I(tj) < 1717/500+(3/4)*Zj.
```

The two difference bounds are, respectively,

```
I(t2)-I(t1) < 131.434+.75*Z2+21*Z1,
I(t1)-I(t2) < 131.434+.75*Z1+21*Z2.
```

Both are at most 131.434+21.75*Z2. The exact margins with pi>157/50 are

```
42*(157/50)-131.434 = 223/500 >0,
(693/100)*(157/50)-21.75 = 51/5000 >0.
```

The accepted paper arguments therefore assemble to the unconditional-in-RH-and-spectrum **paper theorem**

```
|integral_(t1)^(t2) S_chi(t) dt|
 < 42+(693/100)*log(Q*t2/(2*pi)),
```

for every primitive nonprincipal chi of conductor Q>1 and 50<t1<t2, of either parity. No Rademacher, completed-product, Gamma estimate, finite RH assertion, simplicity, or zero-exclusion premise is needed for this assembled route. General complex analysis, the actual L/Euler identities, and the reviewed explicit J bound are proved/reduced at paper and external scalar scope, not yet Lean scope.

This assembly acceptance is distinct from family completeness. The latter still needs the exact completed-count identity and its constant/phase normalization, reflection with multiplicities, the a.e. closed-count adapter, and finite evidence satisfying its integer-saturation test with the new allowance. For a real character the two channels are still counted twice. The note cannot certify an unchanged old packet, conductor-one principal row, or final Goldbach root by itself.

## Remaining proof-status boundary

The producer accurately lists substantive formal tasks: construct the actual Euler log, finite zero factorization with orders, holomorphic log and branch normalization, potential integrals and a.e. derivatives, absolute-continuity integration, and the quantitative tail limit. Their completion must be checked against the exact final declarations and axioms. The horizontal-bound adapters and the J interval certificate also require formal replay.

Verdict: the canonical identity is accepted as a sound complete paper derivation, and its mathematical join to the reviewed 42+6.93Z allowance is valid. No Lean theorem, validated source dependency closure, approved anchor, finite family completeness certificate, or Goldbach closure is asserted by this review.
