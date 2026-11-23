# Independent review of the full-family completeness plan

2026-11-11. Verdict: the normalized two-sided count identity, auxiliary lower-weight inequality, integer saturation and closed-endpoint addendum pass this independent paper/source review. The derivation below fixes the normalization directly from the completed functional equation. It does not import a printed zero-count normalization, historical GRH computation, or a numerical completeness result.

This is not approval of a production evaluator or a new proved Turing bound. The original theorem behind the proposed explicit integrated-S constant still needs its complete source proof and formal implementation. Actual main and auxiliary sign packets, their function enclosures, character manifests and a numerical upper bound satisfying saturation are not supplied by the plan. No Lean process, production computation, canonical edit or frozen-file edit occurred in this review.

## Frozen inputs

| File under `agents/zero-sum/` | SHA256 |
| --- | --- |
| `FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md` | `740840E7576E988AF4C8F8053030BE59EB4EA18DE8C7E0D6B391BF7C9B1C5DEF` |
| `FAMILY_PRODUCTION_ENDPOINT_ADDENDUM_2026-11-11.md` | `6759192EED071A69B064D793CA307FD563BCB436ACCFB28238C77C5AB74E87F4` |

Both file hashes were checked. The second file was written in response to review feedback and leaves the original plan unchanged. It states the closed-count endpoint reduction and makes the Fourier normalization explicit.

Target source is `work/ternary-goldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. The Mathlib cache inspected is the target's exact manifest revision `56a005855ea17e0b0958f73ec801ae140b0a1679`, at `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`.

## 1. Source normalization and the actual completed function

Let χ be primitive of conductor c>1. It is nonprincipal. Let a be 0 or 1 according to parity, and let χ̄=χ⁻¹. Define

`Ψχ(s)=c^((s+a)/2) · DirichletCharacter.completedLFunction χ s`.

Pinned Mathlib `NumberTheory/LSeries/DirichletContinuation.lean:203,223,249,257,283` supplies the gamma factor, the completed function, its entire differentiability for nonprincipal χ, its relation to L, and the primitive functional equation. On the right half-plane these give

`Ψχ(s)=(c/π)^((s+a)/2) Γ((s+a)/2) Lχ(s)`.

The source functional equation is written with a conductor power:

`completedLFunction χ (1-s) = c^(s-1/2) rootNumber χ · completedLFunction χ⁻¹ s`.

Multiplying by `c^((1-s+a)/2)` gives exactly

`Ψχ(1-s)=εχ Ψχ̄(s)`,

where εχ is the source root number. Target `Explicit/LGrowthLeft.lean:221` proves `|εχ|=1` for primitive χ. This is an existing theorem, not an assumed property of a numerical Gauss-sum enclosure.

Conjugation of Dirichlet series on Re(s)>1, compatibility of the gamma factor with conjugation, and analytic continuation give

`Ψχ̄(conj s)=conj Ψχ(s)`.

This precise completed-function conjugation wrapper remains to be formalized if not separately exported. It follows from equality on the convergence half-plane and the identity theorem for the entire completed functions. Combining the identities yields

`Ψχ(1-conj s)=εχ conj Ψχ(s)`.                              (FE)

The constant nonzero factor is important for signs but contributes no change of argument along a path.

Choose a constant eχ with `|eχ|=1` and `eχ² εχ=1`. On Re(s)=1/2, (FE) makes `eχ Ψχ(s)` real. This verifies the plan's sign normalization. Either square-root choice is valid if held fixed for the whole character. Independent branch flips between samples would invalidate a sign-change certificate.

The zeros of Ψχ are exactly the nontrivial zeros of Lχ with the same multiplicities. On `0<Re(s)<1`, the gamma and exponential factors are holomorphic and nonzero. On Re(s)≥1, pinned `NumberTheory/LSeries/Nonvanishing.lean:397` proves Lχ nonzero, and the gamma factor is nonzero. Equation (FE) transports this to Re(s)≤0. This also treats s=0: an even L-function's trivial zero there is cancelled by the gamma pole in the entire completion, and the completed value is nonzero by reflection from s=1. It must not be counted as a nontrivial real zero.

The remaining real zeros with `0<β<1`, if any, are genuine completed zeros and must be retained. Nonvanishing on Re(s)=2 also shows the entire function is not identically zero, making its zeros locally finite with finite positive analytic orders. These are the exact carrier and multiplicity facts needed by the count proof.

## 2. Independent derivation of the two-sided count

First take T>0 with no nontrivial zero at either ordinate ±T. Let P be the right half of a symmetric rectangle, oriented

`1/2-iT → 2-iT → 2+iT → 1/2+iT`.

Its reflection `r(s)=1-conj s` travels up the left half from the same bottom midpoint to the same top midpoint. The full counterclockwise contour consists of P followed by the reverse of r(P). It encloses the entire open critical strip through height T.

By (FE), a continuous argument of Ψχ along r(P) changes by the negative of its change along P. Reversing that reflected path changes the sign again. Hence the full argument change is twice the change along P. The argument principle therefore gives

`Cχ(T) = Δarg_P Ψχ / π`,                                  (1)

where Cχ counts all nontrivial zeros with `|γ|<T`, including real zeros and their analytic multiplicities. No root-number argument appears in (1), because multiplication by the fixed εχ changes argument only by a constant.

Set

`θa(t)=t/2 · log(c/π) + Im logΓ((1/2+a+it)/2)`.

The analytic log-Gamma branch is real on the positive axis. Consequently its conjugation symmetry makes θa odd. The exponential/gamma factor in Ψχ has a holomorphic logarithm throughout the right half-rectangle, and its argument change along P is `2θa(T)`.

For Lχ on the right edge, the elementary Dirichlet-series estimate gives

`|Lχ(2+it)-1| ≤ Σ_{n≥2} n^(-2) < 3/4`.

Thus Re Lχ is positive all along that edge. Its principal argument there is continuous and agrees with the canonical argument continued from the value 1 at right infinity. This removes any undetermined winding integer on the right edge.

Define Sχ(T) to be the canonical horizontal argument at `1/2+iT`, divided by π, with the preceding normalization. Conjugation gives the bottom canonical argument `-π Sχ̄(T)`. The argument change of Lχ along P is therefore

`π Sχ(T) + π Sχ̄(T)`.

Substitution into (1) proves

`Cχ(T)=2θa(T)/π + Sχ(T)+Sχ̄(T)`.                           (2)

This proves the plan's proposed identity with its exact factors. It has no standalone +1 or other calibration constant. Such a zeta-style correction would be wrong here: Ψχ is entire and has no pole at 1. The conductor-one principal entry requires its separately derived zeta count normalization.

The contour covers the real axis in its interior. Thus a real zero, including a central zero, contributes its full multiplicity to Cχ. The proof never initializes a count at t=0 or assumes that Sχ(0) is small. This is essential for a nonprincipal family argument.

Source `Explicit/RectResidue.rectInt_logDeriv_mul` can provide the actual argument-principle sum for the entire Ψχ. New wrappers must connect argument changes, analytic orders, conjugation and the nontrivial-zero carrier. The paper identity above does not claim those wrappers are already implemented.

## 3. The auxiliary-weight inequality and its direction

Use `G(t)=2θa(t)/π`. In the original plan, T and T+h are nonexceptional. For intermediate nonexceptional t, define Aχ(T,t] as the multiplicity count of positive ordinates in `(T,t]`. Conjugation identifies the negative-ordinate additions for χ with positive-ordinate additions for χ̄. Therefore

`Cχ(t)=Cχ(T)+Aχ(T,t]+Aχ̄(T,t]`.

Integrating (2) gives

```
h Cχ(T) = ∫_T^(T+h) G(t)dt
          + ∫_T^(T+h) Sχ(t)dt + ∫_T^(T+h) Sχ̄(t)dt
          - ∫_T^(T+h) [Aχ(T,t]+Aχ̄(T,t]]dt.
```

Suppose disjoint, strictly interior sign intervals `(u_j,v_j)` certify a zero of the indicated character in each. The interval contributes at least one zero γ_j with `γ_j<v_j`, and its contribution to the added-count integral is `T+h-γ_j ≥ T+h-v_j`. Hence the exact rational quantity

`W=Σ_j(T+h-v_j)`

is a lower bound on that integral. Additional auxiliary zeros, including off-line or multiple zeros, only increase the integral. They are subtracted in the formula. Thus missing auxiliary roots cannot make the following upper bound unsound:

`Cχ(T) ≤ [∫ G - W + Bχ+Bχ̄]/h`,                            (3)

provided `|∫ Sχ|≤Bχ` and `|∫ Sχ̄|≤Bχ̄` have been proved with the same canonical argument convention.

There is no extra factor 1/π on W or on the normalized S integrals. Their π factor has already been incorporated in G and the definition of S. This is independently determined by (2), regardless of a printed formula's layout.

For a real character, χ=χ̄, so the positive auxiliary list occurs twice, representing distinct positive and negative roots of the same L-function. Its W and its integrated-S allowance are both doubled. For a nonreal pair, each character's positive list occurs once. Within a single channel, overlapping sign intervals cannot be counted as distinct roots without an additional disjointness argument.

## 4. Main signs, real zeros and integer saturation

For nonreal χ, count positive main sign intervals for χ and χ̄, strictly below T, and add an independently certified central multiplicity rχ. Let the resulting integer be K. Conjugation transports the χ̄ intervals to negative roots of χ, so all represented roots are distinct apart from multiplicities explicitly assigned to the center. Therefore `K≤Cχ(T)`.

For real χ, the formula is `K=2 K_positive+rχ`. The central root must not be doubled. A proof that `Lχ(1/2)≠0` gives rχ=0; a ball merely containing zero does not give a central multiplicity. If an exact central order is used, it must be proved from the analytic function and its derivatives or an equivalent source-faithful argument.

Off-critical real zeros are not excluded by the central point check. They remain in Cχ. If the rational upper endpoint U obtained from (3) satisfies `U<K+1`, then

`K ≤ Cχ(T) ≤ U < K+1`

forces `Cχ(T)=K`. Every represented ordinary sign interval contributes at least one unit of multiplicity, and the central certificate contributes its stated multiplicity. Equality leaves no room for any off-line zero, additional root inside a sign interval, missed even-order zero, off-critical real zero, or extra multiplicity at a counted root. Thus all counted zeros lie on the critical line. Simplicity of roots supplied only by ordinary sign intervals follows from equality, rather than being a premise.

It is unnecessary for U's numerical interval to contain a unique integer on its own. The independent lower bound K and the strict upper test suffice. It is also unnecessary to certify every auxiliary root. These are genuine reductions in the checker contract.

## 5. The closed-endpoint addendum

The addendum correctly strengthens the endpoint contract. Define Cχ(t) using `|γ|≤t`. Equation (2) holds away from the locally finite exceptional ordinates, hence almost everywhere on `(T,T+h)`. Changing S at isolated jump ordinates does not change its integrals. For every t>T the closed-count identity

`Cχ(t)=Cχ(T)+Aχ(T,t]+Aχ̄(T,t]`

still holds. Zeros exactly at T belong to the base count, not the auxiliary count. Zeros exactly at T+h have zero area contribution at that endpoint. Integration therefore gives the same formula and inequality (3), without requiring T or T+h to be a nonexceptional ordinate.

Main sign intervals are strictly below T. If saturation succeeds for the closed Cχ(T), any root at `|γ|=T` would be an extra unrepresented root and would contradict equality. Thus successful saturation itself excludes such boundary zeros. Taking T≥Hcert then covers the inclusive requested height, with no separate top-path computation required by this integrated variant.

This deduction requires the analytic count identity almost everywhere and integrability of S, with a consistent right-limit or other measure-equivalent convention. It does not remove hypotheses from a pre-existing theorem by assertion. The new a.e./closed-count wrapper must be proved, as the addendum explicitly states. A strict Hardy sign at the critical-line endpoint alone would still not exclude an off-line zero at the same ordinate; the argument here uses full-count saturation instead.

## 6. Active domains and source Turing status

The reviewed campaign profile uses odd primitive conductors `c≤150000` and primitive conductors divisible by four with `c≤300000`. There are 150000 eligible conductor integers, including c=1. Their exact primitive-character total is 5,543,640,188. The nonprincipal formula reviewed here applies to 5,543,640,187 characters; the single c=1 primitive character follows the separate principal route. Conductors congruent to 2 modulo 4 supply no primitive characters and must not reappear as independently primitive indices.

With `qt(c)=2c` for odd c and c for even c, `Dc=1200000/qt(c)`, the selected height is

`Hcert(c)=min(ceil(200+max(1000,(704/7)Dc)),100000000/c)`.

This is the reviewed source profile from `major-constants/RESUME_COMMON_HEIGHT_MAJOR_2026-11-11.md`, not a replacement by an unrounded integer height. Its minimum is `1000/3`, attained at c=300000, and is greater than 50. Choosing a certified rational T≥Hcert satisfies that lower-height condition for the candidate Turing bound. Any auxiliary zone above T needs actual sample enclosures but does not assume finite RH there; its incomplete sign list remains a lower-count list.

I directly read [Platt's primary preprint, Section 3](https://arxiv.org/pdf/1305.3087v1). Its Theorem 3.3 states the candidate allowance `1.8397+.1242 log(c(T+h)/(2π))` for T>50, h>0, and refers to Rumely. The later sharper constants are attributed to personal communication. The displayed Theorem 3.2 is not used to set the normalization in this review.

Attempts to retrieve Rumely's original AMS PDF and a scanned copy failed in this session. Consequently this review does not certify the full original proof or all hidden context of that numerical allowance. No corresponding Lean integrated-S theorem was identified. The plan appropriately leaves that theorem as a source/proof task. Its constants cannot yet be treated as an implemented producer for Bχ. The independently verified conclusions here are (2), the implication (3) from valid integrated-S bounds, and the ensuing integer saturation.

The published-domain inclusion `Hcert(c)≤100000000/c` is arithmetic and already reviewed separately. It does not import the historical zero verification, authenticate a historical data set, or establish the new manifest's runtime. This review does not authenticate the listed public C++ snapshot or its historical configuration.

## 7. Fourier normalization clarification

The original plan's Fourier expression needed an explicit definition of its time-domain function. The addendum supplies the correct one:

`F_a(t,χ)=c^(-(2a+1)/4) exp(πηt/4) Zχ(t)`, with `Zχ=eχ Ψχ(1/2+it)`.

This positive conductor scalar is necessary for the displayed factor `c^(-(2a+1)/4)` in the Fourier formula. Without it, taking the transform of the unscaled `exp(πηt/4) Zχ` would produce a different constant. This correction does not alter signs or the count proof, but matters for every absolute error allowance. The addendum resolves the ambiguity without editing the frozen plan.

The proposed Gaussian-series tail follows from its stated successive-term ratios. The transform identity, contour shift, both periodization tails, gamma normalization and numerical FFT errors are still separate proof obligations. This bounded review does not certify a complete Fourier evaluator or its production parameters.

## Conclusion

There is a concrete valid completeness implication here. A canonical two-sided count, proved integrated-S allowances, certified main sign intervals, and an auxiliary lower weight satisfying (3) with `U<K+1` establish finite critical-line completeness, including real roots and closed height boundaries. The count has the exact formula (2), with no additive calibration constant. The endpoint addendum is sound and removes a separate top-path requirement if its a.e. wrapper is implemented.

The unresolved analytic producer is an explicit source-faithful integrated-S bound with all hypotheses proved. The unresolved computational producers are the actual sign packets, gamma-phase enclosures, arithmetic manifests and saturation checks for the complete family. The reviewed plan identifies these as unfinished work and does not claim that existing pilots close them.
