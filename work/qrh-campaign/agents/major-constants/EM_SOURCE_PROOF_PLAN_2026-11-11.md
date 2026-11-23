# Source-faithful Euler–Maclaurin evaluator proof plan

2026-11-11. Read-only source research and paper derivation. No Lean file, declaration, build, dependency change, or frozen-file edit was made. The identities below are proof targets with derivations, not existing checked evaluator theorems. External Arb output remains untrusted input until its interval arithmetic and these analytic identities are proved.

The target source is `work/ternary-goldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. The exact manifest Mathlib revision is `56a005855ea17e0b0958f73ec801ae140b0a1679`, read in `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`. The lean-search-discovery and lean-workflow skills guided the source inspection. This note uses the actual scripts:

- `agents/mellin/psi_head_counts_20261111.py`, SHA256 `D7F187FA357EACA184A2214F8952B396B9D2DF42348580993005B7DA00252A9A`.
- `agents/zero-sum/c5_family_dft_certificate_20261111.py`, SHA256 `C5125697833CC998C79D854F73D8D6D80B442C6972885C1AC35675F128851FC8`.

Hashes identify the versions read. No numerical replay is claimed here. The earlier remainder reviews and this source bridge address different obligations.

## 1. What the source already supplies

The following Mathlib paths are relative to the pinned Mathlib root.

| Source | Existing fact used |
| --- | --- |
| `NumberTheory/LSeries/HurwitzZeta.lean:73` | `HurwitzZeta.hasSum_hurwitzZeta_of_one_lt_re`: for real `a∈[0,1]` and `1<Re(s)`, the sum over `n:ℕ` of `1/(n+a:ℂ)^s` is `hurwitzZeta a s`. |
| Same file, `:67` | `differentiableAt_hurwitzZeta a hs` for `s≠1`. |
| Same file, `:83` | `hurwitzZeta_residue_one`: `(s-1) hurwitzZeta a s → 1` as `s→1`, `s≠1`. |
| Same file, `:90-104` | Differentiability at 1 after subtracting `1/(s-1)/Gammaℝ s`; the limit of that regularization is the library's totalized `hurwitzZeta a 1`. Also, `differentiable_hurwitzZeta_sub_hurwitzZeta a b` proves every Hurwitz difference entire. |
| `NumberTheory/LSeries/RiemannZeta.lean:129` | `HurwitzZeta.hurwitzZeta_zero : hurwitzZeta 0 = riemannZeta`. Since the shift is a `UnitAddCircle`, shift 1 is also shift 0. The positive series at shift 1 is the convenient evaluator representation. |
| `NumberTheory/LSeries/ZMod.lean:85` | `ZMod.LFunction Φ s = N^(-s) * ∑ j:ZMod N, Φ j * hurwitzZeta (toAddCircle j) s`. |
| `NumberTheory/LSeries/DirichletContinuation.lean:60,97` | `DirichletCharacter.LFunction` uses the preceding definition; `differentiable_LFunction hχ` proves it entire for `χ≠1`. |
| `NumberTheory/Bernoulli.lean:224` | `sum_bernoulli n`: `Σ k<n, choose(n,k) B_k = if n=1 then 1 else 0`. This proves the scripts' rational recurrence. Odd Bernoulli numbers above index 1 vanish by `bernoulli_eq_zero_of_odd`. |
| `NumberTheory/ZetaValues.lean:47-125` | Real `bernoulliFun`, its values at 0 and 1, `bernoulliFun_one`, derivative `hasDerivAt_bernoulliFun`, antiderivative, continuity and interval integrability. |
| Same file, `:274-302` | `periodizedBernoulli`; continuity for index different from 1; summable Fourier coefficients; `hasSum_one_div_pow_mul_fourier_mul_bernoulliFun` for index at least 2 and argument in `[0,1]`. |
| `MeasureTheory/Integral/IntervalIntegral/IntegrationByParts.lean:110` | `intervalIntegral.integral_mul_deriv_eq_deriv_mul_of_hasDerivAt`, with continuous factors, derivatives on the interval interior, and integrable derivatives. It applies to complex-valued factors. |
| `Analysis/SpecialFunctions/ImproperIntegrals.lean:130,178` | Integrability of `t^a` on `Ioi c` for `a<-1`, `c>0`, and integral `-c^(a+1)/(a+1)`. The same file `:251` gives the complex-power integral. |
| `Analysis/Calculus/ParametricIntegral.lean:284` | `hasDerivAt_integral_of_dominated_loc_of_deriv_le`: a derivative under the integral, with measurable kernels, an integrable kernel at the base point, and a uniform integrable derivative bound on a neighborhood. Its scalar parameter is `[RCLike 𝕜]`, so it applies with `𝕜=ℂ`. |
| `Analysis/Analytic/Uniqueness.lean:224` | `AnalyticOnNhd.eqOn_of_preconnected_of_eventuallyEq`: analytic functions equal near one point are equal on a preconnected domain. |
| `Analysis/Complex/Exponential.lean:464,484` | Bounds for an exponential minus its finite power series. The second bound does not include the factorial improvement needed by the c5 exprel code; that sharper small lemma is derived below. |

Target `TernaryGoldbach/Explicit/ZetaGrowth.lean:17-30` defines

`zetaF = Function.update (fun s => (s-1)*riemannZeta s) 1 1`,

and supplies `zetaF_of_ne`, `zetaF_one`, and `differentiable_zetaF`. Thus the exact head evaluator target is already an entire function with value 1 at 1.

Scoped searches used both Euler–Maclaurin names and Bernoulli/integral formula shapes across the target and Mathlib. They found the ingredients above, but no ready complex Hurwitz Euler–Maclaurin remainder theorem. The new work is assembling finite-cell integration by parts, its limit and analytic continuation. This is a scoped absence finding, not a claim about every possible reformulation in Mathlib.

## 2. A single exact formula with the scripts' indices

Take an integer `N≥1`, real `0<a≤1`, and integer `M≥1`. Put `B=N+a>1`, let `B_j` denote the ordinary Bernoulli number with `B_1=-1/2`, and set

`(s)_r = ∏_{j=0}^{r-1}(s+j)`, with `(s)_0=1`.

Every positive-base power below means `exp(-s log b)` when written `b^(-s)`. Its equality with the source's complex power must be established using positivity of b; no complex logarithm branch is selected numerically.

Define the entire finite function

```
F[a,N,M](s) = Σ_{n=0}^{N-1} (n+a)^(-s)
             + (1/2) B^(-s)
             + Σ_{k=1}^{M} B_(2k)/(2k)! · (s)_(2k-1) · B^(1-s-2k).
```

On `Ω_M={s:Re(s)>1-2M}`, define the absolutely convergent remainder

```
R[a,N,M](s) = -(s)_(2M)/(2M)!
              · ∫_{N}^{∞} bernoulliFun (2M) ({t}) · (t+a)^(-s-2M) dt.
```

Here `{t}=t-floor(t)` and the integral can be a Bochner set integral over `Ioi N`; changing the endpoint has measure zero. The periodic Bernoulli factor is real and is cast to ℂ. The remainder has a minus sign. Initially for `Re(s)>1`, the exact identity is

`hurwitzZeta a s = F[a,N,M](s) + B^(1-s)/(s-1) + R[a,N,M](s)`.       (EM)

This includes the term k=M, with rising factorial length `2M-1`; its remainder uses length `2M`. Omitting that final term or using length `2M+1` would not match either script.

### 2.1. Finite-cell derivation and the sign

For a smooth complex function f and integers `N<L`, first integrate `(t-n-1/2) f'(t)` on each `[n,n+1]`. Since this linear function has endpoint values `-1/2,+1/2`, summing the cell formulas gives

`Σ_{n=N}^{L-1} f(n) = ∫_N^L f(t)dt + (f(N)-f(L))/2 + Σ_{n=N}^{L-1} ∫_n^{n+1} B_1(t-n)f'(t)dt`.

On each cell use `(B_{r+1}(t-n)/(r+1)!)' = B_r(t-n)/r!` and integration by parts. All degrees at least 2 have equal values at the two endpoints, so their boundary terms telescope between cells. Odd degrees above 1 have zero endpoint values. After reaching degree 2M this gives

```
Σ_{n=N}^{L-1} f(n) = ∫_N^L f(t)dt + (f(N)-f(L))/2
  + Σ_{k=1}^{M} B_(2k)/(2k)! · (f^(2k-1)(L)-f^(2k-1)(N))
  - ∫_N^L B_(2M)({t})/(2M)! · f^(2M)(t)dt.
```

Each integration by parts is on an ordinary polynomial cell. No global derivative of the discontinuous periodic B1 is used. For degrees at least 2, matching endpoint values allow the last finite sum of integrals to become the displayed periodic integral. Agreement away from integer endpoints would also suffice by almost-everywhere congruence.

Apply this to `f(t)=(t+a)^(-s)`. Induction gives

`f^(r)(t)=(-1)^r (s)_r (t+a)^(-s-r)` for `t≥N`.

For `Re(s)>1`, the upper endpoint derivatives vanish as `L→∞`. The integral of f becomes `B^(1-s)/(s-1)`. The odd derivative signs turn the lower endpoint corrections into the positive terms in F, while the even derivative leaves the negative remainder sign unchanged. Add the finite head `n=0,…,N-1` and use the existing Hurwitz HasSum theorem. This proves (EM) in its convergence half-plane.

Required formal work includes the explicit derivative induction, finite interval additivity, convergence of the partial sums and endpoint terms, and passage from finite to improper integrals. These are ordinary new lemmas, not evaluator premises.

### 2.2. Bernoulli numbers and the uniform periodic bound

The scripts start with `B_0=1` and use

`B_n = -(1/(n+1)) Σ_{j=0}^{n-1} choose(n+1,j) B_j`, `n≥1`.

The source's `sum_bernoulli (n+1)` and `choose(n+1,n)=n+1` prove this exact recurrence, including `B_1=-1/2`. Induction identifies every rational coefficient generated by the scripts with the source Bernoulli number.

The existing Bernoulli Fourier expansion, the unit norm of its Fourier factor, and summability give, for `x∈[0,1]`,

`|B_(2M)(x)|/(2M)! ≤ 2/(2π)^(2M) · Σ_{n≥1} n^(-2M) ≤ 4/6^(2M)`.

For the second inequality, use `n^(-2M)≤n^(-2)` and

`Σ_{n=2}^{L} 1/n² ≤ Σ_{n=2}^{L} 1/(n(n-1)) = 1-1/L`.

Thus the positive-index sum is at most 2. Finally `π>3`. This proves the exact coarse constant used by both scripts, without a tabulated Bernoulli maximum or a numerical zeta value. The factor 2 for positive and negative Fourier indices is essential; the zero index is zero under the source's totalized inverse convention. Apply the bound to `{t}∈[0,1]`. The Fourier-to-norm inequality and this final numerical bound are new wrappers around existing source facts.

### 2.3. Exact remainder bound and holomorphy

For `σ=Re(s)>1-2M`, positivity of `t+a` gives the exact norm `|(t+a)^(-s-2M)|=(t+a)^(-σ-2M)`. Therefore

`|R[a,N,M](s)| ≤ 4 |(s)_(2M)| B^(1-σ-2M) / [6^(2M)(σ+2M-1)]`.       (R)

This is a complex norm bound, not separate real and imaginary estimates. It implies that both coordinate errors lie in `[-E,E]`, which is exactly what the scripts' square error boxes require. No factor √2 is needed in this implication. Conversely a square error box of radius E only has norm bound √2E; that reverse implication is not used to justify the evaluator.

The same proof supplies absolute integrability. To prove that R is analytic throughout Ω_M, fix s₀ there and a small complex ball whose real parts are bounded below by some `σ_min>1-2M`. The derivative in s of the integral's exponential factor contributes `-log(t+a)`. Its norm is bounded by a constant times

`log(t+a) (t+a)^(-σ_min-2M)`.

Choose positive ε smaller than the remaining exponent margin. The elementary inequality `log v ≤ v^ε/ε` for `v≥1` gives an integrable power majorant. The periodic Bernoulli factor is bounded and measurable, and the finite rising factorial and its derivative are bounded on the local ball. Apply the pinned parametric-integral theorem with measure restricted to `Ioi N`. This proves complex differentiability on Ω_M and hence local analyticity. Every majorant must be uniform on that local ball, not only at s₀.

For a box with `Re(s)≥σ₀>1-2M` and `|s|≤S`, (R) yields

`|R| ≤ 4 ∏_{j=0}^{2M-1}(S+j) B^(1-σ₀-2M) / [6^(2M)(σ₀+2M-1)]`.       (RB)

The replacement of σ by σ₀ uses B>1 in the numerator and positivity of the denominator. This is why B's lower bound must be recorded. The c5 script instead encloses `|(s)_(2M)|` directly through its complex ball operations, which is also valid pointwise on the entire input box.

## 3. The actual zetaF head evaluator

In `psi_head_counts_20261111.py`, `Evaluator(N)` uses a=1 and B=N+1. Its finite sum is over integers 1 through N, not 0 through N and not 1 through N-1. Its `finite(s)` is exactly

`g(s)=(s-1)F[1,N,32](s)+B^(1-s)`.

The correction loop uses rising factorial lengths 1,3,…,63. The error uses length 64. At requested height 1500 the script sets `N=max(80,ceil(1500/3))=500`, so B=501. For prefixes it uses the same formula for N with the requested height.

Multiplying (EM) by s-1 on `Re(s)>1` gives

`zetaF(s)=g(s)+(s-1)R[1,N,32](s)`.

Both sides are analytic on Ω₃₂, which is `Re(s)>-63`: zetaF is entire by the target theorem, g is a finite combination of exponentials and polynomials, and R is analytic there by section 2.3. The domain is convex, hence preconnected. Apply the existing identity principle using a neighborhood of s=2 to extend this identity to all Ω₃₂, including s=1. At 1, g(1)=1 and the remainder multiplier is zero, exactly matching `zetaF_one`. No value of the totalized `riemannZeta 1` enters this proof.

On actual contour points the script uses `σ₀=-1/10`. A block with center c and half-length h uses `S=|c|+h`, and `|s-1|≤S+1`. Consequently its `em_error(S)` is exactly `(S+1)` times (RB). Its exponent is `1-σ₀-64` and its denominator is `σ₀+64-1`, both with the indices just derived.

### 3.1. Taylor layer and its separate domain

The head code expands only the finite entire g, not zetaF and not the EM remainder. It uses Taylor degree 23, with coefficients indexed 0 through 23, `K=24`, outer radius R=1, and actual block radius `h≤1/10`. If C bounds `|g|` on the radius-1 circle, Cauchy's coefficient bound gives the tail

`C (h/R)^24 / (1-h/R)`.

The source ingredients include `DifferentiableOn.hasFPowerSeriesOnBall` in `Analysis/Complex/CauchyIntegral.lean:693` and the iterated-derivative Cauchy estimate in `Analysis/Complex/Liouville.lean:42`. A new wrapper must identify the coefficients emitted by the finite exponential/series arithmetic with those of g, then sum the geometric tail. The script's `acb_series` execution is not such a proof.

For the outer circle, `|s|≤|c|+1` and `Re(s)≥Re(c)-1`. Applying these bounds term by term to the explicit entire g gives the script's `outer_bound(center)`. It keeps the absolute values of Bernoulli coefficients and the factor `|s-1|≤|c|+2`. The outer disk can extend to real part -1.1; it causes no problem because g is entire. The EM error bound using `σ₀=-.1` is needed only at the actual contour points. The combined panel error is the sum of this EM error and the Taylor tail, exactly as in the code.

## 4. The actual c5 common-pole subtraction

The c5 script uses `N=64`, `M=20`, and residue order

`(a_0,a_1,a_2,a_3)=(1/5,2/5,4/5,3/5)`.

Put `B_j=64+a_j`, choose the common reference `B_0=64+1/5`, and set `ℓ_j=log B_j-log B_0`. Define the entire function

`exprel(z)=Σ_{r=0}∞ z^r/(r+1)!`, with `exprel(0)=1`.

The exact pole-free expression associated to component j is

`Q_j(s)=F[a_j,64,20](s) - B_0^(1-s) ℓ_j exprel((1-s)ℓ_j) + R[a_j,64,20](s)`.       (Q)

For s≠1, the elementary identity `z exprel(z)=exp(z)-1` gives

`-B_0^(1-s) ℓ_j exprel((1-s)ℓ_j) = [B_j^(1-s)-B_0^(1-s)]/(s-1)`.

Thus for `Re(s)>1`,

`Q_j(s)=hurwitzZeta a_j s - B_0^(1-s)/(s-1)`.

The same pole, with the same reference base, has been removed from every component. Using `B_j` separately in the subtracted pole without the displayed correction would change the nonprincipal combination.

At s=1, (Q) is finite and its correction is exactly `-ℓ_j`. The code's k=1,…,20 correction terms have rising factorial lengths 1,…,39, and its EM remainder has length 40. The valid analytic domain is Ω₂₀, `Re(s)>-39`; the actual contour has `Re(s)≥111/200` and `|Im(s)|≤12`. The script freezes the remainder exponent and positive denominator at `σ₀=111/200`, and retains a ball enclosure of the length-40 rising factorial.

### 4.1. Why individual totalized Hurwitz values must not be substituted at 1

Mathlib explicitly documents that `hurwitzZeta a 1` is an assigned value at the pole. The source's differentiable regularization subtracts

`1/((s-1) Gammaℝ(s))`,

whereas Q_j subtracts `B_0^(1-s)/(s-1)`. Their finite parts need not agree. Therefore the scalar statement `Q_j(1)=hurwitzZeta a_j 1` is not a valid bridge and is not needed.

For every j, instead compare

`Q_j-Q_0` and `hurwitzZeta a_j - hurwitzZeta a_0`.

Both are analytic on Ω₂₀. The second is entire by the existing difference theorem; the first is analytic by its explicit formula and the remainder lemma. They agree on `Re(s)>1`. The identity principle extends equality to all Ω₂₀, including s=1. More generally any finite coefficients whose sum is zero give the correct totalized nonprincipal combination by writing it as a combination of these differences. This deals with the pole and the library's value convention simultaneously.

### 4.2. Exact character and DFT orientation

The residue generator is 2 modulo 5, with powers `(1,2,4,3)`. The code uses positive DFT weights `i^(k j)` for k=1,2,3, and multiplies by `5^(-s)`. Its exact target expressions are

```
5^(-s) (Q_0 + i Q_1 - Q_2 - i Q_3),
5^(-s) (Q_0 -   Q_1 + Q_2 -   Q_3),
5^(-s) (Q_0 - i Q_1 - Q_2 + i Q_3).
```

For each k, define the actual Dirichlet character by `χ_k(2^j)=i^(k j)` and χ_k(0)=0. Its four displayed values sum to zero. A finite group calculation proves multiplicativity, nontriviality, and primitivity modulo the prime 5; this construction is still required. The exact `ZMod.LFunction` definition then identifies the three expressions with `DirichletCharacter.LFunction χ_k`, using section 4.1 also at s=1. There is no division by φ(5). Replacing the DFT sign would conjugate the character and swap k=1 with k=3, so the positive sign and residue order must remain explicit.

The character parities are odd, even, odd because -1=2² modulo 5. Complex conjugation relates χ₁ at s to χ₃ at conjugate s. It does not justify a same-character symmetry across the real axis for χ₁ alone.

### 4.3. The exprel polynomial actually used

The code initializes the term at 1 and performs updates for k=1,…,18. It therefore computes

`P_18(z)=Σ_{r=0}^{18} z^r/(r+1)!`.

Its added error is `exp(|z|)|z|^19/20!`. This is justified by the exact tail estimate

```
|exprel(z)-P_18(z)|
 ≤ Σ_{r=0}∞ |z|^(19+r)/(20+r)!
 ≤ |z|^19/20! · Σ_{r=0}∞ |z|^r/r!
 = exp(|z|)|z|^19/20!,
```

where `(20+r)!≥20! r!`. The zero case z=0 is included. Define exprel by this entire power series, or by `∫₀¹ exp(tz)dt` and prove the series identity by dominated summation. The generic exponential tail lemma read in the source is weaker than this factorial-normalized bound; it must not be substituted without checking constants.

The exprel box is then multiplied by the common-base exponential and ℓ_j using ordinary complex interval arithmetic. Each EM remainder is added separately before the DFT. The final character scale has norm `5^(-Re(s))`. The interval semantics must propagate all these errors; one must not silently discard the four component errors because their poles cancel.

## 5. Dependency order and remaining proof work

The shortest source-faithful order is the following.

1. Identify the rational Bernoulli recurrence with source Bernoulli numbers; prove the periodic Bernoulli bound `4(2M)!/6^(2M)` from the existing Fourier formula.
2. Prove finite-cell integration by parts with endpoints and derivative signs as in section 2.1. Prove the derivative formula for the positive-base exponential powers.
3. Pass to the convergent Hurwitz series for `Re(s)>1`; define the remainder integral, prove its absolute bound and analyticity on Ω_M.
4. Derive the zetaF identity by the existing analytic identity theorem. Separately derive Hurwitz differences and zero-sum combinations, avoiding any false individual equality at s=1.
5. Prove exprel's entire series, difference quotient identity, and the degree-18 remainder. Build the finite c5 characters with the exact positive DFT convention and reduce the source LFunction definition.
6. Prove Taylor coefficients and the radius-1 geometric tail for the finite head function g. Prove the termwise outer bound with the actual N, M and K.
7. Connect these analytic statements to proved rational/dyadic interval arithmetic for exp, log, products, sums and error boxes. Only then consume the stored whole-panel half-plane witnesses in the separately developed polygon-crossing bridge.

Steps 1-6 are mathematical source bridges. Step 7 is a checker semantics and elementary-function enclosure task. None is replaced by a successful call to Arb's zeta, Hurwitz, series, exp or log implementation. The c5 diagnostic built-in Hurwitz comparisons are outside acceptance in the script and remain unnecessary for this proof plan.

There is no new spectral assertion in this plan. The aim is to prove that the finite expressions enclose the actual named analytic functions. Any resulting zero-count statement still requires the independently proved panel geometry, strict half-plane bounds, exact crossing rule, and analytic-order carrier transport.
