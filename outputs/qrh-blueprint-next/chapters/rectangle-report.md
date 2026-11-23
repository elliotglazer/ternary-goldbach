# Source ledger for rectangle and Taylor-head certificate checking

2026-11-11. Source inspection only. No Lean process, new Lean file, frozen declaration, canonical edit or dependency modification was made. The existing external Arb computations are evidence to replay, not trusted Lean operations.

The target source is `work/ternary-goldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Its manifest pins Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`. The inspected cache is

    C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib

Its HEAD was verified to equal that exact manifest revision. A command-local `git -c safe.directory=<that path> ... rev-parse HEAD` was used; no Git configuration was changed. Thus the APIs below are from the pinned dependency, not a different current Mathlib version. The lean-search-discovery and lean-workflow skills guided the read-only searches.

The main reusable fact is stronger than a generic Cauchy theorem: the target already proves a rectangle argument-principle identity for entire functions, with actual analytic multiplicities. The missing bridge is between the exact rational crossing computation and that boundary integral. A direct proof using local logarithms can avoid the additional free-homotopy/basepoint infrastructure.

## 1. Existing entire-function and multiplicity interfaces

All target names in this section are in namespace `TernaryGoldbach.Explicit`.

`Explicit/ZetaGrowth.lean:17-30` provides the exact continuation:

```lean
noncomputable def zetaF : ℂ → ℂ :=
  Function.update (fun s ↦ (s - 1) * riemannZeta s) 1 1
theorem zetaF_of_ne {s : ℂ} (hs : s ≠ 1) :
  zetaF s = (s - 1) * riemannZeta s
theorem zetaF_one : zetaF 1 = 1
theorem differentiable_zetaF : Differentiable ℂ zetaF
```

The formal evaluator must prove an identity/enclosure for this updated entire function. The raw pointwise product at1 is not its definition. The frozen height14 and Taylor-head evaluators cancel the pole before evaluating; that cancellation must be proved, including the value1 at1. The value at0 is1/2, so it is not an added zero.

For conductor3, Mathlib `NumberTheory/LSeries/DirichletContinuation.lean:60,97` supplies

```lean
noncomputable def DirichletCharacter.LFunction
    (χ : DirichletCharacter ℂ N) (s : ℂ) : ℂ := ZMod.LFunction χ s
lemma DirichletCharacter.differentiable_LFunction
    {χ : DirichletCharacter ℂ N} (hχ : χ ≠ 1) :
    Differentiable ℂ (LFunction χ)
```

These declarations are under `{N : ℕ} [NeZero N]`. Mathlib `NumberTheory/LSeries/ZMod.lean:85` defines

```lean
noncomputable def ZMod.LFunction (Φ : ZMod N → ℂ) (s : ℂ) : ℂ :=
  N ^ (-s) * ∑ j : ZMod N, Φ j * hurwitzZeta (toAddCircle j) s
```

The new adapter must construct the actual character with values0,1,-1 at residues0,1,2, prove nontriviality and primitivity, and reduce this definition to `3^(-s)*(hurwitzZeta(1/3,s)-hurwitzZeta(2/3,s))` with the correct `UnitAddCircle` arguments. A named ready-made chi3 declaration was not located by the scoped searches; no such declaration is assumed here. Mathlib `HurwitzZeta.differentiable_hurwitzZeta_sub_hurwitzZeta` at `NumberTheory/LSeries/HurwitzZeta.lean:104` already proves

```lean
lemma differentiable_hurwitzZeta_sub_hurwitzZeta (a b : UnitAddCircle) :
  Differentiable ℂ (fun s ↦ hurwitzZeta a s - hurwitzZeta b s)
```

This helps identify the cancellation at s=1. It does not identify the external EM/exprel implementation automatically. In particular the arbitrary value convention of each separate Hurwitz function at its pole must be handled through the analytic difference.

The target's finite zero carrier is analytic rather than a supplied list. `Explicit/Landau.lean:25-43` defines

```lean
noncomputable abbrev divB (f : ℂ → ℂ) (c : ℂ) (R : ℝ) :=
  MeromorphicOn.divisor f (closedBall c R)
noncomputable def zerosIn (f : ℂ → ℂ) (c : ℂ) (R r : ℝ) : Finset ℂ :=
  (divB_finite f c R).toFinset.filter fun u => ‖u - c‖ < r
```

`divB_finite` follows from compactness; `factor_ball` supplies the zero factorization for an entire f with f(c)!=0. Analytic divisor values, converted with `.toNat`, are actual vanishing orders. One must retain their positivity at zeros and prove the carrier comparison; checking a list of numerical zeros or Hardy-Z sign changes is not a substitute.

## 2. The generic rectangle argument principle is already present

`Explicit/RectResidue.lean:22` defines `rectInt` as bottom minus top plus i times right minus i times left, with increasing coordinate limits. This is the positively oriented rectangle integral when z.re<w.re and z.im<w.im.

At line360, `NoZerosOnSides f z w` is exactly the conjunction of nonvanishing on all four closed coordinate segments. Corners and both horizontal endpoints are included.

The exact generic theorem at line391 is:

```lean
theorem rectInt_logDeriv_mul {f : ℂ → ℂ} (hf : Differentiable ℂ f)
    {c : ℂ} {R : ℝ} (hR : 0 < R) (hfc : f c ≠ 0)
    {z w : ℂ} (hzw1 : z.re < w.re) (hzw2 : z.im < w.im)
    (hrect : [[z.re, w.re]] ×ℂ [[z.im, w.im]] ⊆ ball c (R / 2))
    (hbd : NoZerosOnSides f z w)
    {h : ℂ → ℂ} {U : Set ℂ} (hU : IsOpen U)
    (hsubU : [[z.re, w.re]] ×ℂ [[z.im, w.im]] ⊆ U)
    (hh : DifferentiableOn ℂ h U) :
    rectInt (fun s => logDeriv f s * h s) z w = 2 * π * I *
      ∑ u ∈ (zerosIn f c R (R / 2)).filter
        (fun u => z.re < u.re ∧ u.re < w.re ∧
                  z.im < u.im ∧ u.im < w.im),
        ((divB f c R u).toNat : ℂ) * h u
```

Take h=1 and U=univ. Choose c=2, prove f(2)!=0, and choose a rational R with strict enclosing-ball slack. For zetaF, nonvanishing at2 follows from its identity and zeta nonvanishing in Re(s)>=1. For chi3 it follows from the corresponding L-function theorem once the character is identified. A certified nonzero boundary vertex could instead serve as c. No numerical zero list is required by this theorem.

The specialized `WeilRect.rectInt_xi_eq` at line50 is not the right generic interface: it fixes the source rectangle and adds `GoodH` and k>=8. Reusing the generic theorem avoids introducing those unrelated premises. `RectResidue2.rectInt_logDeriv_inv_sub` counts weighted residues at an additional interior point and is also unnecessary for plain counts.

The source proof uses Mathlib `Complex.integral_boundary_rect_eq_zero_of_differentiableOn`, `Analysis/Complex/CauchyIntegral.lean:292`, whose hypothesis is `DifferentiableOn ℂ f` on the closed rectangle and whose conclusion is the same four-side boundary expression equal to0. That is a Cauchy theorem, not itself a zero-count checker.

## 3. Whole-panel evidence and exact geometry

The checker must validate rational input vertices p0,...,pn=p0 traversing the boundary once counterclockwise, with the stipulated four corners, side membership, order, adjacency and no missing intervals. The existing head certificate also shares vertical paths and reverses the left prefix. Each checkpoint assembly needs this same geometry theorem; monotonicity of stored counts is only a consistency check.

For each input panel j, the proposed verified numerical layer must establish, for every actual point s of that panel,

    Re(u_j*f(s))>0,  where u_j is one of 1,-1,i,-i.

This is a theorem about the actual analytic function. A strict sign at panel endpoints is insufficient. The external complex-ball strings are descriptive data, not a proof of this quantified assertion.

Let v0,...,vn=v0 be the shared rational image vertices. The finite checker also verifies `Re(u_j*v_j)>0` and `Re(u_j*v_(j+1))>0`. Thus the entire rational image edge lies in the same open half-plane. At every join, both the actual value f(p_j) and the single rational value v_j belong to the half-planes of both incident panels. Shared input and image vertices, including closure, are essential.

These half-planes immediately imply `NoZerosOnSides`. The actual input panel and its rational image edge must not be confused: only the former is an argument to f.

## 4. Recommended new bridge: local logarithms and telescoping

The following are new ordinary mathematical lemmas to prove, not existing declarations or proposed new assumptions.

For H_u={z:Re(u*z)>0}, define the local logarithm ell_u(z)=Complex.log(u*z). Since u!=0 and u*z is in the right half-plane, it lies in `Complex.slitPlane`. Along a differentiable nonzero curve w in H_u,

    derivative ell_u(w(t))=w'(t)/w(t).

The existing derivative/FTC APIs already have the required types:

```lean
-- Analysis/SpecialFunctions/Complex/LogDeriv.lean:87
theorem HasDerivAt.clog_real {f : ℝ → ℂ} {x : ℝ} {f' : ℂ}
    (h₁ : HasDerivAt f f' x) (h₂ : f x ∈ slitPlane) :
    HasDerivAt (fun t => log (f t)) (f' / f x) x

-- MeasureTheory/Integral/IntervalIntegral/FundThmCalculus.lean:1148
theorem intervalIntegral.integral_eq_sub_of_hasDerivAt
    (hderiv : ∀ x ∈ uIcc a b, HasDerivAt f (f' x) x)
    (hint : IntervalIntegrable f' volume a b) :
    ∫ y in a..b, f' y = f b - f a
```

The usual ambient real-domain normed-space variables of the FTC theorem are suppressed above; in this application its codomain is ℂ. Also available at `LogDeriv.lean:127` is

```lean
lemma Complex.deriv_log_comp_eq_logDeriv {f : ℂ → ℂ} {x : ℂ}
    (h₁ : DifferentiableAt ℂ f x) (h₂ : f x ∈ Complex.slitPlane) :
    deriv (Complex.log ∘ f) x = logDeriv f x
```

For an actual straight input panel gamma_j, the chain rule and cancellation of u_j give

    integral logDeriv(f)(gamma_j(t))*gamma_j'(t) dt
      =ell_(u_j)(f(p_(j+1)))-ell_(u_j)(f(p_j)).

For its rational image edge, apply the same theorem to the affine interpolation of v_j,v_(j+1), obtaining ell_(u_j)(v_(j+1))-ell_(u_j)(v_j). Entire f gives the required derivative continuity and integrability on each nonzero compact panel; these obligations must appear in the proof.

At a shared vertex put A=f(p_j), B=v_j. Both lie in H_u intersect H_v. The connector B+t(A-B) lies in this convex intersection. Along that connector ell_u and ell_v have the same derivative. FTC therefore proves

    ell_u(A)-ell_u(B)=ell_v(A)-ell_v(B).

This connector identity makes all actual-versus-rational endpoint errors telescope cyclically. Consequently the sum of actual panel integrals equals the sum of rational-edge integrals. Subdivision/orientation lemmas then identify the actual sum with `rectInt (logDeriv f) z w`.

This route proves the needed integral equality directly. It requires neither a based winding-number construction nor a general homotopy-invariance theorem. The crucial connector identity is valid because the two points are in both half-planes, not merely because each point is individually nonzero.

## 5. New exact ray-crossing theorem

The external c3 checker at lines64-71 uses det(a,b)=a.re*b.im-a.im*b.re and the following half-open rule for the positive real ray:

    +1 if a.im<=0<b.im and det(a,b)>0;
    -1 if b.im<=0<a.im and det(a,b)<0;
     0 otherwise.

The new finite theorem must identify the sum of these integers with the polygon integral divided by2*pi*i. All edges are already proved to avoid0 by their strict half-plane witnesses. Nonzero image vertices and exact closure are prerequisites.

A direct proof can use the branch `log(-z)`, whose cut in the z-plane is the positive real ray. For a nonhorizontal edge, its intersection with the real axis has real coordinate det(a,b)/(b.im-a.im). Thus the determinant sign test selects precisely the positive-ray crossing. The source `RectResidue.lean:84,89` already proves `log p-log(-p)=+/-pi*i` in the upper/lower half-plane, from Mathlib's argument identities. Mathlib `Analysis/SpecialFunctions/Complex/Arg.lean:413,417,599,633` supplies the corresponding argument identities and one-sided limits.

At a positive-real endpoint, the value arg(-z)=pi explains the half-open convention: an upward crossing beginning there receives+1; a downward crossing ending there receives-1. Horizontal real-axis edges have zero crossing contribution and an ordinary real logarithmic integral. Zero-length edges also contribute0. A straddling determinant-zero edge would meet0 and is ruled out by the half-plane certificate. These endpoint cases must be included in the theorem, not discarded as generic-position assumptions.

For a closed polygon the principal endpoint logarithms telescope, leaving exactly2*pi*i times the integer crossing sum. A ray-crossing theorem with this exact rule was not found by searches for winding/argument-principle/ray-crossing terminology in Mathlib Analysis and Topology, followed by inspection of their angle and covering APIs. This is a missing bridge, not a claim that no proof can be assembled from existing lemmas.

## 6. Alternative topological route and the basepoint issue

Mathlib does provide the underlying topology:

* `Topology/Homotopy/Affine.lean:31`: `ContinuousMap.Homotopy.affine (f g : C(X,E)) : f.Homotopy g`, defined by straight interpolation in a real topological vector space.
* `Topology/Homotopy/Path.lean:50`: `Path.Homotopy p q` is a homotopy relative to {0,1}. Its `hcomp` at157 combines adjacent path homotopies and `map` at226 transports them through a continuous map.
* `Analysis/SpecialFunctions/Complex/Arg.lean:638`: `Complex.continuousAt_arg_coe_angle (h : x ≠ 0)` proves continuity of `((↑) ∘ arg : ℂ → Real.Angle)` at x. This avoids the discontinuity of principal real argument.
* `Topology/Covering/FundamentalGroupCircle.lean:56` defines `AddCircle.windingNumber` on `FundamentalGroup (AddCircle p) x`, under `[Fact (0<p)]`. At61 it proves, for `γ : Path x x`, `f : C(I,ℝ)` and `hf : (↑) ∘ f = γ`, that `(windingNumber (.of (.mk γ)) : ℝ)=(f 1-f 0)/p`.
* `Topology/Homotopy/Lifting.lean:215` proves `IsCoveringMap.exists_path_lifts`: for a continuous path gamma and specified lifted start e, there exists `Γ : C(I,E)` with p composed with Γ equal to gamma and Γ(0)=e. Its `liftHomotopy` at307 and equations316,319 lift a continuous family from an initial lift.

For the certificates, straight interpolation between the actual image loop and rational polygon stays nonzero and is globally continuous. But the loop basepoint generally moves from f(p0) to rational v0. It is a closed free homotopy, not a `Path.Homotopy` relative to endpoints. The latter cannot be applied merely because the loops are closed.

A topological implementation therefore still needs free-homotopy winding invariance or explicit basepoint transport. One proof lifts the angle-valued homotopy to the square and observes that the endpoint difference divided by2*pi is an integer-valued continuous function of the homotopy parameter, hence constant. Connecting that winding to `rectInt (logDeriv f)` and then to exact rational crossings remains additional work. The local-log route above avoids these extra interfaces while proving the same result.

## 7. Numerical analytic layer, including the Taylor head wrapper

No located theorem interprets an Arb ball as a verified Lean enclosure. The eventual checker must use rational/dyadic interval objects with proved arithmetic semantics, including exp/log enclosures, complex multiplication and Horner evaluation. Either export sufficient finite witnesses for these operations or recompute them in a proved evaluator. Merely calling Arb again, parsing its descriptive strings, or wrapping its output in a result-shaped hypothesis does not discharge this layer.

The source-function layer needs the actual Euler--Maclaurin identity with remainder, including pole cancellation and rising factorials. Searches by Euler--Maclaurin names and by Bernoulli/integral statement shape did not locate the required complex Hurwitz/zeta evaluator theorem in pinned Mathlib. This remains a new analytic bridge. Some substantial ingredients already exist: `NumberTheory/ZetaValues.lean:302` proves, for k>=2 and x in[0,1],

```lean
theorem hasSum_one_div_pow_mul_fourier_mul_bernoulliFun
    {k : ℕ} (hk : 2 ≤ k) {x : ℝ} (hx : x ∈ Icc (0 : ℝ) 1) :
    HasSum (fun n : ℤ => 1 / (n : ℂ)^k * fourier n (x : UnitAddCircle))
      (-(2 * π * I)^k / k! * bernoulliFun k x)
```

This can supply the periodic Bernoulli norm estimate after a norm-sum bound. The EM summation/remainder identity, bounds on its complex derivatives, and identification with the actual continuation still need proofs.

For the Taylor head certificate, g is a finite entire EM expression. Its outer radius-one bound M_o concerns g, not the unknown zeta remainder on that outer disk. Mathlib has both the analytic expansion and Cauchy estimate:

```lean
-- Analysis/Complex/CauchyIntegral.lean:692
protected theorem DifferentiableOn.hasFPowerSeriesOnBall
    {R : ℝ≥0} {c : ℂ} {f : ℂ → E}
    (hd : DifferentiableOn ℂ f (closedBall c R)) (hR : 0 < R) :
    HasFPowerSeriesOnBall f (cauchyPowerSeries f c R) c R

-- Analysis/Complex/Liouville.lean:42
theorem Complex.norm_iteratedDeriv_le_of_forall_mem_sphere_norm_le
    [CompleteSpace F] {c : ℂ} {R C : ℝ} {f : ℂ → F}
    (n : ℕ) (hR : 0 < R) (hf : DiffContOnCl ℂ f (ball c R))
    (hC : ∀ z ∈ sphere c R, ‖f z‖ ≤ C) :
    ‖iteratedDeriv n f c‖ ≤ n.factorial * C / R^n
```

The standard complete normed complex-space parameters of the first theorem are inherited from its file context. These facts support, but do not directly certify, the truncated coefficients emitted by `acb_series`. New algebraic-series soundness must connect the finite exp/product series to the true Taylor coefficients of g. Cauchy coefficient bounds and a geometric tail then give `M_o*h^K/(1-h)` at R=1. Add the separately proved EM error on the actual panel. The outer disk may extend left of the EM real-part floor; this is harmless only because no EM remainder bound is applied there.

## 8. Dependency order and exact final conclusions

The preferred dependency order is:

1. Define exact rational complex intervals and prove primitive arithmetic, exp/log and finite-series enclosure rules. Validate the exact input geometry and shared vertices.
2. Prove the zetaF and chi3 source adapters, the EM remainder, and the Taylor-model soundness theorem. Obtain actual whole-panel half-plane assertions.
3. Prove the local-log panel integral identity, the two-half-plane connector identity and cyclic telescoping. Obtain actual boundary-integral equality with the rational polygon.
4. Prove the exact half-open ray-crossing formula, including real-axis endpoints, edge reversal and zero-length edges. Combine with step3 to obtain `rectInt (logDeriv f)=2*pi*i*k` for the checked integer k.
5. Apply the existing `rectInt_logDeriv_mul` with h=1. Cancel nonzero2*pi*i to identify k with the sum of actual nonnegative vanishing orders in the rectangle interior.
6. Use boundary nonvanishing to transfer from the open interior to the closed rectangle. For k=0, positivity of the order at any zero excludes every interior zero. For nonzero k, retain the multiplicity sum rather than the number of distinct roots.
7. Apply the function-specific carrier adapters. For zetaF on[-.1,1.1], use the unconditional negative-strip, Re=0 and Re>=1 exclusions in `ZetaDatum`/`ZetaPoly`, together with the source identity away from1. `ZetaZeroSums.zerosRectD_zetaF_strip` at39 is unconditional despite a nearby separate Platt theorem; embedding into its standard finite carrier requires a new carrier-comparison lemma. `WeilBridge.analyticOrderAt_xiF_eq` at38 and `divB_eq_of_analyticOrderAt_eq` at55 are available when changing to xi multiplicities. Their geometric/domain hypotheses must be retained.
8. For each positive-height head rectangle, certified bottom nonvanishing excludes real zeros and certified top nonvanishing excludes zeros at the checkpoint. The resulting interior count therefore equals the closed positive count N(t_j). Assemble the shared bottom/right/crossbar/left paths with their actual orientations. Finally prove the positive-measure grid inequality for Q1500 from these counts and exact rational summation.

For c3, winding0 excludes the closed right rectangle; the toy contour height33 covers the requested closed height32. It does not certify the selected full Hcert(3). For the zeta height14 rectangle, its horizontal boundaries themselves must be certified nonzero to conclude the inclusive exclusion. For the head rectangles, the externally observed integer1069 and Q-grid value are data to replay through this chain, not theorem inputs.

The existing source theorem already addresses completeness and multiplicity. The new checker must establish its boundary integral and exact function identity. That is the principal proof obligation; constructing a Boolean checker with the desired conclusion as a hypothesis would not resolve it.
