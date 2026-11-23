# Independent review: global physical high-frequency tail

Verdict: **PASS for the bounded source/mathematical implication.** No correction to the author report is required. This is not a Lean build or a validation of all imported mathematics.

Reviewed author: `integration/QRH_GLOBAL_TAIL_ANALYTIC_AUDIT_2026-11-11.md`, SHA-256 `F3DAB6983C136728A4AE0A9467C44397A41F7CA4F476FDB3C16BAA5F5464B0EE`, read in full. Its finite-source qualification and lower-foundation boundary are accurate. All 28 listed source hashes and full-file line spans were independently verified. The supporting receipt pins the 21 files whose relevant bodies were independently inspected in this review; it does not claim every unrelated declaration in those files was audited.

| Reproduction artifact in this directory | SHA-256 |
|---|---|
| `check_global_tail_source_20261111.py` | `E25CB0C792A62F83355F4335DEDA2D08E93D5CF7D2AFA81793D6BAAA8E3421A6` |
| `check_global_tail_source_20261111.json` | `3AFACE4D9EB374B385AFADD06E14F7541A2AE4BCD3E9B03324352BCADF5BA00B` |

The checker passed five elementary exact identities and the byte/line checks. It performs no Fourier, L-function or spectral evaluation, and these simple scalar checks are not offered as proof of the analytic inputs.

## Object and scope

The target is `InverseInitialHighFrequencyTail.original_physical_tail_rapid` in `Inversion/InitialHighFrequencyTailRapid.lean:14`, under `work/openai-math/lean/OAI/NumberTheory/DirichletL`, commit `4eaee87548250b2682affda7d05d947c05554bae`.

It bounds the actual `physicalBlock` on an arbitrary **finite** set S of physical source points. S may contain arbitrarily many frequencies, subject to the radial lower bound. The bound is independent of the frequency-set size, finite prime-pool size, index types, character, j, selected slots and their lists. The chosen finite seminorm set and positive constant depend on fixed `Lcap,saving,tau` and the fixed lattice/ray infrastructure. The displayed seminorm is still evaluated on Phi. This is stronger than a frequency-by-frequency bound, but is not itself an infinite physical-source summability theorem.

No local `A0=0` log-profile estimate is substituted. The proof uses rapid decay of the original radial Fourier transform on the entire Eisenstein lattice, then the original physical coefficients and finite support keys.

## Actual Fourier transform and source seminorms

`GaussSum/SexticRadialPoisson.lean:234,304,426` defines

- `paperFrequency(u)=(2i/sqrt(3))*conj(u)`;
- `paperFourier(f,u)=(2/sqrt(3))*integral paperE(-z*u)*f(z)`;
- `paperRadialFourier(Phi,t)=paperFourier(z -> Phi(norm(z)^2),sqrt(t))`.

Its exact standard-Fourier adapter is at line 307; the paper-frequency squared norm is `4/3*norm(u)^2` at line 290. The argument below only uses t>=0. There is no claim that the square-root profile is globally Schwartz on the real t-line.

`Poisson/RadialFourier.lean:70–174` constructs the continuous linear map from a Schwartz Phi on R to the plane Schwartz function `Phi(norm(z)^2)`, then applies the Schwartz Fourier continuous linear map. Proper-growth control for the composition is explicit: norm(z)<=1+norm(z)^2. Evaluating at `paperFrequency(sqrt(t))` gives squared norm `4t/3`. Hence `(1+t)^A <= (1+norm(frequency))^(2A)`. The plane Schwartz bound yields a finite plane seminorm supremum, with explicit factor `(2/sqrt(3))*2^(2A)`.

`schwartzCLM_finite_seminorm_control` then bounds that seminorm by `C*sup_s seminorm(Phi)`, using continuity of the linear operator. C>0 and the finite set s are chosen **before** Phi and t. Thus for every A,

    (1+t)^A * norm(paperRadialFourier Phi t)
      <= C_A * sup_{s_A} seminorm(Phi),  t>=0.

This explains both the uniformity and its limit: these are qualitative finite-seminorm constants, not explicit numerical constants or a uniform bound over all Phi without seminorm control. The proof does not use the later Euler/log-separation theorem.

## Genuine lattice summability and the tail

`RadialFourier:474–500` transports the lattice through its actual bijection with Z x Z. For coordinates a,b,

    q=norm(eisEmbedding(h))^2=a^2-a*b+b^2 >= (a^2+b^2)/2.

Consequently

    (1+q)^(-2) <= 4/((1+a^2)*(1+b^2)).

`GaussSum/SecondPoissonScale.lean:704,719` proves summability of the right side from the integer p-series with p=2, treating zero as a finite exception, then taking the nonnegative product sum. This supplies a genuine finite `eisensteinCauchyMass`; it is not obtained from a potentially default-zero `tsum`.

For K>0, T>=0 and a tail point with T<=Kq, the elementary `polynomial_tail_majorant` at line 502 uses

    min(1,K)*(1+q) <= 1+Kq,
    (1+T)^A <= (1+Kq)^A.

The source weighted bound at order A+2 therefore gives

    norm(paperRadialFourier Phi (Kq))
      <= C_A*sup_s seminorm(Phi)
         /[min(1,K)^2*(1+T)^A] * (1+q)^(-2).

The extra two powers are essential. The factor min(1,K)^(-2) remains when K is small; it has not been hidden in a supposedly uniform constant. The source separately proves full-lattice norm summability at order 2 (`:533`), and proves the subtype tail sum bound (`:544`) using summability of both the majorant and the bounded function. `C*(eisensteinCauchyMass+1)` is positive and independent of K,T,Phi.

`InitialHighFrequencyTailKernel.finite_radial_tail` injects an arbitrary finite frequency set F into the full tail subtype. It uses this established summability before comparing sums. Complex coefficients may depend arbitrarily on the frequency, but their norms must be bounded by Gamma on F; no cancellation or smoothness of those coefficients is used.

There is a separate correct infinite-sum interface in `InitialHighFrequencyTailInfinite.lean`: `weighted_radial_summable` first proves bounded-weight summability by the radial norm majorant, and `norm_tsum_of_finite_bound` then uses the norm limit of finite partial sums. `weighted_radial_tsum_tail` combines them for an arbitrary subtype predicate. This does not by itself claim summability over infinitely many physical support keys or unbounded prime pools. Any such conclusion requires its own key/coefficient control. The target rapid theorem and its immediate `InitialDyadicTailBound.actual_high_mass_tail` consumer both retain finite source sets.

## Physical scale and original coefficient

`InitialHighFrequencyTailKernel.physicalKernel_frequency` is the exact source identity, with coefficient

    Z^(-D)*Z^m/[d*v*sqrt(n1*n2)]
      * W1(C*v*n1/Z^D) * W2(C*v*n2/Z^D)

and radial argument

    [Z^m/(d*v^2*n1*n2)] * norm(eisEmbedding(h))^2.

`InitialHighFrequencyTailScale` assumes C,d,v,n1,n2>=1, d<=L and both whole-column inequalities C*v*ni<=L. These give `d*v^2*n1*n2<=L^3`. The scalar coefficient has norm at most `Z^(m-D)*B1*B2`. The lower bound K>=Z^m/L^3 then makes the denominator loss at most `min(1,Z^m/L^3)^(-2)`. The direction is correct: increasing the lower bound on K reduces the upper-bound loss.

`InitialHighFrequencyTailCoefficient` uses the original columns, not the normalized clipped Fourier columns. Its exact `physicalTerm_original_coefficient` identity needs Valid's two overlap-disjointness hypotheses to restore source-ideal products. The original coefficient includes initialBeta, two Mobius factors, the ray coefficient, and the conjugate/ordinary original columns. The two Mobius factors and initialBeta have norm at most one. Mark factorization is exact; each marked column has norm at most its mark, and each mark is bounded by 128L. Thus

    norm(originalCoefficient) <= norm(secondRayCoefficient rho)*(128L)^2.

No claim that the mark itself has norm at most one is made. The mark bound uses pairwise-disjoint slot lists and the selected-coefficient norm assumptions. Those hypotheses cannot be discarded.

`InitialHighFrequencyTailSource` defines five support keys and proves the exact fiber decomposition. Once key and frequency are fixed, the source point is unique; the finite image summation therefore loses no multiplicity. Each support key injects into an ideal of norm <=L, giving at most 128L choices per coordinate. Consequently there are at most `(128L)^5` keys, independent of the size of the containing finite pool. After summing the fixed finite ray-index set, `original_physical_tail` has the stated full factor `(128L)^7`.

The detailed local Gauss/trace column inequalities and the ideal-count foundations are not re-proved in this review. Their exact uses are visible in the coefficient and key-count adapters, and the author independently audits those branches.

## Uniform rapid-order choice

Let c=Lcap. Under Z>=1, L>=1, c>=0, L<=Z^c, -m<=c and m-D<=c,

    min(1,Z^m/L^3) >= Z^(-4c).

The three losses are therefore `7c` from the support/coefficient factor, `c` from `Z^(m-D)`, and `8c` from the squared reciprocal minimum. Also `(1+Z^tau)^A >= Z^(tau*A)`. Thus the complete raw factor is at most

    128^7 * Z^(16c-tau*A).

`InitialHighFrequencyTailPower.initial_tail_rapid_order` chooses a natural A strictly larger than `(16c+saving)/tau`. Tau>0 makes this possible. This choice precedes all index types, prime data, Phi, weights, scales and finite sets. It is valid also at Z=1 and when saving is nonpositive. The final fixed ray mass is multiplied into the constant as `R+1`, ensuring a positive constant even if R=0. The new source seminorm set depends on the chosen A; increasing saving is not free of additional Phi seminorm requirements.

## Remaining boundary and verdict limits

The substantive lattice/radial tail and its rapid exponent are reconstructed here from the actual Fourier definition, continuous Schwartz operators, integer summability and elementary scale inequalities. This does not prove the entire global QRH theorem. The remaining lower inputs include the plane Fourier/Schwartz and integration APIs, the actual Eisenstein coordinate/trace identities, local normalized Gauss/column estimates, ideal/support counting, and the source's preceding exact physical expansion. Later use of the rapid tail still must supply Valid, bounded marks and weights, whole-column bounds, and a genuine high-radial condition on every retained point. The immediate dyadic consumer uses a finite live-point filter and high-window geometry; it is not licensed to discard a nonzero low-radial term.

No Lean build, evaluator, special-function value, or numerical spectral calculation was run. No source or author artifact was changed.
