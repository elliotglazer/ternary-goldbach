# Elementary Turing bound for the existing character family

2026-11-11. The upper estimate, local lower estimate, and canonical Littlewood identity have now each passed independent review. Their exact composition below gives a complete paper argument, with reviewed external scalar evidence for the J integral. This new synthesis awaits its own independent review. No Lean theorem, formal declaration, build, scan, finite family certificate, or frozen-package change is supplied.

The assembled mathematical result is

```
abs(integral_(t1)^(t2) S_chi(t) dt)
  < 42 + (693/100)*log(Q*t2/(2*pi)),
```

for the actual canonical S of every primitive complex Dirichlet character of natural conductor Q>1, either parity, and every pair of real endpoints 50<t1<t2. No conductor or height upper bound, RH, simplicity, finite zero list, or spectral certificate is a hypothesis. All analytic components are obligations to prove internally; none becomes an allowed premise of the final Goldbach theorem. The original BinaryGoldbachInput and target theorem remain unchanged.

## Exact source and review ledger

Agent paths below are relative to `work/qrh-campaign/agents/`. The root upper note is under `work/qrh-blueprint/turing-scalars/`.

| Input | Producer SHA256 | Independent review and SHA256 |
| --- | --- | --- |
| Root `ELEMENTARY_HORIZONTAL_UPPER_2026-11-11.md` | `0875B2B87A02421B7B8CD6CAD0D1C33433A051E240F48EA4C5F45FE04558BD27` | `integration/REVIEW_ELEMENTARY_HORIZONTAL_UPPER_2026-11-11.md`, `696E6E8B9C73D3AE3593F2D5C1386E4B386048DA046915CD976C0A43425D7E94` |
| `audit/TURING_HORIZONTAL_LOWER_PROOF_PLAN_2026-11-11.md` | `A8D21679E5BF2C631D7399D73A70E85E3486EBC6A92CC1668C5060E77E2E11C9` | `integration/REVIEW_TURING_HORIZONTAL_LOWER_PROOF_PLAN_2026-11-11.md`, `B4CAE7485D7BB6655D207BEB2E1716A904F637E36753C48EF5D15FD1A6B41992` |
| `mellin/LITTLEWOOD_CANONICAL_LOG_PROOF_PLAN_2026-11-11.md` | `6BB683D71E4B96A593E93699B3EEF52CF5443289DED3B1CEE06B3C232B7253D9` | `audit/REVIEW_LITTLEWOOD_CANONICAL_LOG_PROOF_PLAN_2026-11-11.md`, `1F477AC1CC894AFAD6D4714143B3C4DEC3C0E91330F16F2E1FA27106C56D84EB` |
| Root `ZETA_LOG_INTEGRAL_2026-11-11.md` | `66DCFC80712A8773682D23F2121BB05A2494CEE1AD7EB7A975EEAED7B399852E` | `integration/REVIEW_ZETA_LOG_INTEGRAL_2026-11-11.md`, `262ABBD71433135C1A3EC11703D28112E14DB2047B08303BA2A3829AB86B9DE2` |

The shared source is `DirichletCharacter.LFunction chi` at target `23b2d68ca344203d4384e0aff7affa4ec034bef9`, with Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`. Existing `TernaryGoldbach.Explicit.norm_LFunction_le` supplies the positive-half-plane growth theorem; its actual file has SHA256 `5E6BD327045A95842498DD35DA4D4CA476D7DF37275EA612CD4FA46D2273C341`. Source availability is not a claim of a new build or axiom audit.

The numerical J input has accepted paper/external-Arb evidence and still needs its analytic and proved-checker formalization. The upper and lower reviews include exact scalar replay, with no builtin special-function acceptance. This synthesis runs no new scalar computation. The lower review's exact replay already checked both difference signs and the final constants.

## Canonical S and exceptional heights

For Re(s)>1, define the Euler logarithm by the absolutely convergent prime-power series

```
ell_chi(s) = sum_(p prime) sum_(k>=1) chi(p)^k/(k*p^(k*s)).
```

It satisfies exp(ell_chi)=L(s,chi) and tends to zero at right infinity. For a nonexceptional ordinate t, continue this logarithm horizontally to 1/2+it along the actual nonvanishing L-function and set S_chi(t) to its imaginary part divided by pi. This is a continuation convention, not the pointwise principal argument of the endpoint value.

On any compact height interval, the exceptional ordinates can be taken to include all zero ordinates obstructing the horizontal paths. They are finite. At each such ordinate choose the average of the two one-sided S limits, or any finite value. The integral is unchanged. A nonreal character's initial imaginary Euler-log value at 2 need not be zero. Resetting it to zero, independently resetting winding integers, or adding a root-number phase would change the required function.

Define

```
I_chi(t) = integral_(1/2)^infinity log(norm(L(sigma+i*t,chi))) d sigma.
```

Finite assignments to log norm at its isolated zero points do not change I. The compact part is integrable across finite-order zeros, and the Euler-log majorant makes the tail absolutely integrable. The Littlewood proof supplies local boundedness and measurability of S, local Lipschitz regularity of I, and the identity

```
pi*integral_(t1)^(t2) S_chi(t) dt = I_chi(t2)-I_chi(t1).
```

It includes exceptional endpoints. Its finite factorization proves I is continuous through zero ordinates, while jumps of S occur in its almost-everywhere derivative. There is no extra endpoint term. The final independent review pinned above explicitly verifies the domain, normalization, multiplicities, and right-edge limit, as well as the join to the two horizontal bounds.

## Composition of the constants

Put Zj=log(Q*tj/(2*pi)). Then 0<Z1<Z2. The reviewed bounds are

```
I_chi(t) < 1717/500 + (3/4)*Z(t),
I_chi(t) > -128 - 21*Z(t).
```

The lower bound uses the final joint harmonic/zero budget with coefficient 21, not the earlier separate-budget coefficient 32. It avoids a completed-function product, Gamma estimates, Booker pairing, and the sharper historical lower constants. The upper bound avoids Rademacher interpolation. These changes concern only this route; they do not imply those analytic subjects are absent from every other campaign component.

The two difference estimates are

```
I(t2)-I(t1) < 65717/500 + (3/4)*Z2 + 21*Z1,
I(t1)-I(t2) < 65717/500 + (3/4)*Z1 + 21*Z2.
```

Both are at most `65717/500+(87/4)*Z2`. The respective differences from this common bound are 21(Z2-Z1) and (3/4)(Z2-Z1), both nonnegative. Thus the same upper bound controls the absolute difference. Dividing the Littlewood identity by pi>157/50 gives the displayed Turing estimate because

```
42*(157/50)-65717/500 = 223/500 > 0,
(693/100)*(157/50)-87/4 = 51/5000 > 0.
```

Every comparison is strict in the required direction. The argument treats the actual character and its inverse separately. Inversion preserves conductor, primitivity, and parity, so the same constant applies to both. No pairing hypothesis on their numerical root-phase choices enters this integrated-S proof.

## Exact existing completeness consumer

The unchanged consumer documents are

- `zero-sum/FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md`, SHA256 `740840E7576E988AF4C8F8053030BE59EB4EA18DE8C7E0D6B391BF7C9B1C5DEF`.
- `zero-sum/FAMILY_PRODUCTION_ENDPOINT_ADDENDUM_2026-11-11.md`, SHA256 `6759192EED071A69B064D793CA307FD563BCB436ACCFB28238C77C5AB74E87F4`.
- Their independent paper/source review `major-constants/REVIEW_FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md`, SHA256 `3033D761A2FE3F1B140A750CD1261D640EF8D1E98FA81711A438EB899A8AFE58`.

For T>50 and h>0, use the allowance

```
B(Q,T+h) = 42+(693/100)*log(Q*(T+h)/(2*pi))
```

for each of chi and its inverse. Let C_chi(T) be the closed count of all nontrivial zeros of the actual completed function through |Im(rho)|<=T, with multiplicity, including real zeros. The independently reviewed count normalization is, almost everywhere in the auxiliary height interval,

```
C_chi(t) = G(t)+S_chi(t)+S_inverse(t),
G(t) = 2*theta_a(t)/pi.
```

Here theta_a uses the holomorphic log-Gamma branch real on the positive axis. Its argument-principle, conjugation, multiplicity, and completed/trivial-zero adapters remain formal obligations. The Turing assembly does not replace them with its local logarithms.

For disjoint certified sign intervals (u_j,v_j) strictly inside (T,T+h), define W as the sum of T+h-v_j over both character channels. Each contributes a lower bound on the integrated added-zero count. Integrating the count identity gives

```
C_chi(T) <= U = (integral_T^(T+h) G(t) dt - W + 2*B(Q,T+h))/h.
```

For a real character the two channels coincide but must still be counted twice, both in W and in the allowance. For a nonreal pair each positive channel is used once. Main sign intervals strictly below T and the required exact central contribution provide K_main<=C_chi(T). Real zeros away from the center cannot be silently dropped; any such unaccounted zero would prevent successful saturation.

A proved rational upper enclosure of U must satisfy the strict test `U<K_main+1`. Integer-valuedness then proves equality and completeness. The closed-endpoint addendum includes zeros exactly at T in C_chi(T), so an unaccounted boundary zero also prevents saturation. Values at auxiliary exceptional ordinates do not change the integrals. Conductor one is excluded from this nonprincipal theorem and retains its separate principal-zeta normalization and evidence.

No existing packet automatically passes this larger allowance. Replacing a prior allowance in a previously evaluated U requires recomputing the exact upper enclosure and its strict margin. Increasing h changes the required auxiliary signs, Gamma integral, and allowance. Actual data over that larger range must be generated and checked. This synthesis gives no runtime, size, or saturation guarantee and does not alter Hcert or the selected conductor family.

## Remaining status

The component reviews are complete, and the Littlewood review independently checks the same mathematical join. This new synthesis is submitted for a further independent assembly review. The analytic proof still requires Lean implementation and exported type/axiom validation. The Euler-log and actual-L-function bridges, finite analytic orders and factorization, Blaschke division, harmonic bounds, integral limits, the J certificate, and the canonical count adapters are substantive tasks. The full-family sign and central evidence and strict integer saturation are also absent. No frozen Lean anchor or approved dependency graph is created here.
