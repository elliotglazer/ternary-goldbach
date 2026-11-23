# Exact polygon crossings and the rectangle argument principle

2026-11-11. This is a paper proof and a proposed formalization order. No Lean file or build was made. It does not certify any external numerical enclosure. The preceding source ledger remains unchanged at SHA256 `93A2B60572F8D02E1EF47BD6672DA01D21F70927C1D8DB3EF36930E2436EA91A`.

The target source is `work/ternary-goldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. All target names below are in `TernaryGoldbach.Explicit`. The Mathlib source is the exact manifest revision `56a005855ea17e0b0958f73ec801ae140b0a1679`, read in the cache `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`. Source references describe existing declarations. The new lemmas proved on paper below have not been checked by Lean.

## 1. Certificate contract and exact result

Let `f : ℂ → ℂ` be entire. Let `z,w : ℂ` satisfy `z.re < w.re` and `z.im < w.im`. A finite sequence of affine input panels traverses the boundary of this rectangle once counterclockwise. Its vertices are `z₀,…,zₙ`, with `zₙ=z₀`, and each panel follows the corresponding rectangle side in its assigned orientation. The geometric checks must verify that the panels partition those sides, without omitted intervals or additional traversals.

For each panel j, the certificate supplies a rotation `uⱼ ∈ {1,-1,I,-I}` and rational complex vertices `vⱼ,vⱼ₊₁`, with one exactly shared vertex at each join and `vₙ=v₀`. Its analytic enclosure proof must establish

`Re(uⱼ f(zⱼ+t(zⱼ₊₁-zⱼ))) > 0` for every `t ∈ [0,1]`.

The rational checks establish `Re(uⱼ vⱼ)>0` and `Re(uⱼ vⱼ₊₁)>0`. These are strict half-plane tests. Testing only the actual function's values at panel endpoints is insufficient.

Write `a_x=Re(a)`, `a_y=Im(a)` and

`Δ(a,b) = a_x b_y - a_y b_x`.

Define the integer crossing contribution by the following ordered, mutually exclusive cases:

```
C(a,b) =  1  if a_y ≤ 0 < b_y and Δ(a,b) > 0;
         -1  if b_y ≤ 0 < a_y and Δ(a,b) < 0;
          0  otherwise.
```

All tests on rational vertices use exact rational comparisons. Put `k=Σⱼ C(vⱼ,vⱼ₊₁)`. The conclusion is

`rectInt (logDeriv f) z w = 2π I k`.

The existing rectangle argument principle then identifies k with the number of actual zeros of f strictly inside the rectangle, counted with their analytic multiplicities. The panel half-planes exclude boundary zeros, so the same count holds for the closed rectangle. In particular, `k=0` proves that f has no zero in the closed rectangle. This conclusion concerns f itself; identifying f with a pole-removed zeta or a particular Dirichlet L-function remains a separate exact identity obligation.

## 2. One affine segment and the half-open rule

Assume the affine segment `γ(t)=a+t(b-a)`, `0≤t≤1`, avoids zero. Define

`J(a,b)=∫₀¹ (b-a)/γ(t) dt`, and `F(p)=Complex.log(-p)`.

The integrand is continuous on `[0,1]`: the numerator is constant and the denominator is continuous and nonzero. It is therefore interval integrable. We prove the exact edge identity

`J(a,b) = F(b)-F(a) + 2π I C(a,b)`.                         (E)

This statement requires only nonvanishing of the segment. The certificate's common strict rotated half-plane is an elementary sufficient condition for that nonvanishing.

Let `R₊={r∈ℂ : Im(r)=0 and Re(r)>0}`. There are two cases.

### 2.1. The segment does not meet the positive ray

Since γ avoids both zero and R₊, `-γ(t)` lies in the principal logarithm's slit plane for every t in `[0,1]`. The real derivative of `log(-γ(t))` is

`(-(b-a))/(-γ(t)) = (b-a)/γ(t)`.

The fundamental theorem of calculus gives `J(a,b)=F(b)-F(a)`.

If the upward clause of C held, let `d=b_y-a_y>0`. Then `t₀=-a_y/d` belongs to `[0,1]`, its image has imaginary part zero, and

`Re(γ(t₀)) = Δ(a,b)/d > 0`.

This would put a point of the segment in R₊. The downward clause gives the same contradiction with `d<0` and `Δ<0`. Thus `C(a,b)=0` and (E) follows. Division is used only after deriving `d≠0` from the relevant strict endpoint inequality.

### 2.2. The segment meets the positive ray

The segment cannot also meet the negative real ray. Otherwise convexity would put zero between a positive real point and a negative real point of the same segment. Hence the whole segment is in the slit plane of `G(p)=Complex.log p`. This includes endpoints on the positive ray.

The derivative of `G(γ(t))` is `(b-a)/γ(t)`, so the fundamental theorem gives

`J(a,b)=G(b)-G(a)`.

For p in this slit plane define `ε(p)=1` if `Im(p)≤0`, and `ε(p)=-1` if `Im(p)>0`. The principal-log conventions give

`F(p)=G(p)+π I ε(p)`.                                    (B)

For positive imaginary part this is `RectResidue.log_sub_log_neg_of_im_pos`; for negative imaginary part it is `log_sub_log_neg_of_im_neg`. If `Im(p)=0`, membership in the slit plane forces `Re(p)>0`. Then `arg(p)=0` and `arg(-p)=π`, so (B) uses `ε(p)=1`. This exact endpoint convention is the reason for the weak inequality on the lower end of each crossing test.

If `ε(a)=ε(b)`, both imaginary parts are in the same group, either nonpositive or positive. Neither crossing clause holds and `C=0`.

If `ε(a)-ε(b)=2`, then `a_y≤0<b_y`. The segment has one real-axis intersection, at `t₀=-a_y/(b_y-a_y)`. Since the segment meets R₊, that unique intersection is positive. Thus `Δ/(b_y-a_y)>0`, whence `Δ>0` and `C=1`.

If `ε(a)-ε(b)=-2`, the same argument gives `b_y≤0<a_y`, `Δ<0` and `C=-1`. Consequently, in all cases

`ε(a)-ε(b)=2 C(a,b)`.

Substitution in (B) proves (E). This proof uses a logarithm analytic on the entire edge in each case. No improper integral, one-sided logarithm limit, or integration across a branch discontinuity is needed.

### 2.3. Degenerate and boundary configurations

A horizontal edge has equal imaginary parts, so `C=0`. If it meets the positive ray and avoids zero, it lies on the positive ray throughout; G is analytic on it. If it does not meet that ray, F is analytic on it. A zero-length edge has `J=0`, `C=0` and identical endpoint values. Both are included in the preceding proof.

An endpoint can have zero real part. If a strict crossing clause holds and `Δ=0`, the real-axis intersection would be zero, contrary to segment nonvanishing. Thus no unhandled axis-crossing equality is hidden in the strict determinant test. An endpoint on the negative ray is allowed in case 2.1, because F is analytic there.

At a positive-ray vertex, an upward departure counts +1 and a downward arrival counts -1. An upward arrival and downward departure count zero. Hence a touch followed by return contributes zero over its two adjacent edges, while a crossing is counted exactly once. Consecutive horizontal positive-ray edges add zero and do not disturb this rule.

Directly from the definitions, `C(b,a)=-C(a,b)`, since the determinant changes sign and the two endpoint clauses interchange. Reversing an edge also negates J. For the counterclockwise square with vertices `1-I,1+I,-1+I,-1-I,1-I`, the first edge contributes +1 and the others contribute zero. This fixes the orientation sign.

## 3. Closed polygons

Suppose every segment of `v₀,…,vₙ=v₀` avoids zero. Sum (E). The finite sum of `F(vⱼ₊₁)-F(vⱼ)` is exactly zero because the vertices are shared and the list is closed. Thus

`Σⱼ J(vⱼ,vⱼ₊₁)=2π I Σⱼ C(vⱼ,vⱼ₊₁)`.                  (P)

No simplicity assumption is needed on the image polygon. Self-intersections away from zero are allowed; the integer is the signed winding count. No approximation to an angle or logarithm is evaluated by the rational checker.

## 4. Transferring the polygon integral to the actual image

For a nonzero rotation u let `Hᵤ={p : Re(u p)>0}` and `ℓᵤ(p)=log(u p)`. This set is convex, excludes zero, and sends every point to the slit plane after multiplication by u. Along a differentiable curve inside Hᵤ, the derivative of ℓᵤ is the curve derivative divided by the curve value.

Write `Aⱼ=f(zⱼ)` and let

`Iⱼ=∫₀¹ logDeriv f(zⱼ+t(zⱼ₊₁-zⱼ)) · (zⱼ₊₁-zⱼ) dt`.

Entire differentiability gives continuity of f and its derivative. The panel half-plane makes its denominator nonzero on the compact parameter interval. Hence the integrand is continuous there and interval integrable. The chain rule and FTC give

`Iⱼ=ℓᵤⱼ(Aⱼ₊₁)-ℓᵤⱼ(Aⱼ)`.

The polygon segment also lies in Hᵤⱼ by convexity, so

`J(vⱼ,vⱼ₊₁)=ℓᵤⱼ(vⱼ₊₁)-ℓᵤⱼ(vⱼ)`.

At a shared vertex j, both Aⱼ and vⱼ belong to the intersection of the previous and next half-planes. The connector `c(t)=vⱼ+t(Aⱼ-vⱼ)` stays in that intersection. For either rotation its logarithm has derivative `c'(t)/c(t)`. FTC for these two logarithms therefore proves

`ℓᵤprev(Aⱼ)-ℓᵤprev(vⱼ) = ℓᵤnext(Aⱼ)-ℓᵤnext(vⱼ)`.     (S)

This also handles the closing join j=0. The intersections need not be classified: their convexity and the stated membership of the two connector endpoints suffice. In particular, the impossible intersection of opposite strict half-planes cannot arise from valid data.

Subtracting the two panel formulas shows that `Iⱼ-J(vⱼ,vⱼ₊₁)` is the connector error at the right endpoint minus the connector error at the left endpoint, measured in the same local log. Equation (S) permits cyclic cancellation across all joins. We obtain

`Σⱼ Iⱼ=Σⱼ J(vⱼ,vⱼ₊₁)=2π I k`.                         (T)

This direct proof does not require a based homotopy. The actual image basepoint and rational polygon basepoint can differ.

## 5. Matching the existing rectangle integral

`Explicit/RectResidue.lean:22` defines

```
rectInt g z w =
    (∫ x in z.re..w.re, g (x + z.im*I))
  - (∫ x in z.re..w.re, g (x + w.im*I))
  + I • (∫ y in z.im..w.im, g (w.re + y*I))
  - I • (∫ y in z.im..w.im, g (z.re + y*I)).
```

This is bottom rightwards, right upwards, top leftwards, left downwards. For each horizontal input panel the factor `zⱼ₊₁-zⱼ` is its signed real length; for each vertical panel it is I times its signed imaginary length. The real affine change-of-variable identity converts Iⱼ to the corresponding oriented side integral. Adjacent-interval additivity then combines the partition of each side. Top and left signs agree with the displayed definition. These steps prove `Σⱼ Iⱼ=rectInt (logDeriv f) z w`.

The affine substitution can use Mathlib `MeasureTheory/Integral/IntervalIntegral/Basic.lean:973`, `smul_integral_comp_mul_add`, whose statement is

`(c • ∫ x in a..b, g(c*x+d)) = ∫ x in c*a+d..c*b+d, g x`.

Its scalar c is real. It includes c=0. Factoring the complex I out of a vertical integral is a separate scalar-integral identity. Interval integrability follows from the continuous nonvanishing boundary integrands already established. The required new geometry lemma must consume the actual side partition data; merely storing a closed list of rectangle-boundary points does not establish a single traversal.

## 6. Analytic multiplicities and the closed boundary

The entire-function theorem `Explicit/RectResidue.lean:391`, `rectInt_logDeriv_mul`, already states, for a rectangle inside `ball c (R/2)`, nonzero f(c), and `NoZerosOnSides f z w`,

```
rectInt (fun s => logDeriv f s * h s) z w =
  2*π*I * ∑ a ∈ (zerosIn f c R (R/2)).filter
    (fun a => z.re < a.re ∧ a.re < w.re ∧ z.im < a.im ∧ a.im < w.im),
    ((divB f c R a).toNat : ℂ) * h a.
```

Use h=1 and U=univ. One can discharge the auxiliary center and ball conditions from the certificate rather than add premises. Take c to be the bottom-left input corner z. Boundary nonvanishing gives f(c)≠0. If `dₓ=w.re-z.re` and `dᵧ=w.im-z.im`, set `R=2(dₓ+dᵧ+1)`. For any point s of the closed rectangle,

`‖s-c‖ ≤ |Re(s-c)|+|Im(s-c)| ≤ dₓ+dᵧ < R/2`.

This proves the required strict ball inclusion and R>0. Every side point lies in some input panel, so the panel half-planes give exactly `NoZerosOnSides` from `RectResidue.lean:360`.

Combining the existing theorem with (T) and cancelling the nonzero complex number `2πI` identifies k with the sum of the natural numbers `(divB f c R a).toNat`. For an actual zero a in the rectangle, entire analyticity and the nonzero value f(c) imply finite analytic order by the identity theorem on ℂ. The order is positive because f(a)=0. The divisor at a equals that finite analytic order, and its nonzero support places a in `zerosIn`; the strict rectangle inclusion places it in the filtered carrier. Conversely, every point of that filtered carrier is an actual zero, as the existing theorem's proof establishes.

The relevant existing definitions are `Explicit/Landau.lean:25` for divB and `:31` for zerosIn. The source already uses `analyticOrderAt_ne_top_of_isPreconnected` inside `factor_ball` at `:50`, and `RectResidue.lean:410-419` uses the divisor-at-an-analytic-point identity and `AnalyticAt.analyticOrderAt_eq_zero` to obtain the actual-zero direction. These facts must be exposed in the final carrier lemma. One must not use `.toNat` before excluding infinite analytic order, or identify multiplicity with one merely because a numerical enclosure contains one apparent root.

Consequently k is nonnegative for the checked counterclockwise input traversal. If k=0, the sum of nonnegative multiplicities is zero, so it has no positive summand and there is no interior zero. The half-plane boundary condition excludes all remaining points of the closed rectangle. This is a zero exclusion on the closed rectangle, not just its open interior. Reversing the input traversal negates the integral and crossing sum; it cannot be silently accepted as the same counterclockwise geometry.

## 7. Smallest remaining formal lemmas

The mathematical bridge can be split into the following ordinary lemmas, in dependency order. These are proposed proof tasks, not additional assumptions about the target functions.

1. An affine segment avoiding zero has the edge integral (E) with the exact rational crossing definition. Its proof needs the two-ray convexity observation, the determinant expression for a real-axis intersection, the principal-log endpoint formula, and FTC.
2. The logarithm endpoint differences for two half-planes agree along a connector in their intersection, equation (S). This is two applications of FTC with equal derivatives.
3. A cyclic panel list satisfying the analytic half-plane assertions and shared rational vertices has integral (T). This is finite telescoping using the previous two lemmas.
4. A checked oriented side partition sums to the existing rectInt definition. This is affine substitution and interval additivity, including orientation signs.
5. The generic entire-function argument-principle result specializes to a natural multiplicity count on the closed rectangle. This exposes the finite-order/support equivalence and boundary nonvanishing from section 6.

For the logarithm/FTC steps, pinned Mathlib provides `HasDerivAt.clog_real` in `Analysis/SpecialFunctions/Complex/LogDeriv.lean:87` with exact hypotheses `HasDerivAt g g' t` and `g t ∈ slitPlane`, and conclusion `HasDerivAt (fun t => log(g t)) (g'/g t) t`. It also provides `intervalIntegral.integral_eq_sub_of_hasDerivAt` in `MeasureTheory/Integral/IntervalIntegral/FundThmCalculus.lean:1148`, requiring derivatives at all points of `uIcc a b` and interval integrability of the derivative. The analytic curves here are defined on all real t; slit-plane membership at each endpoint is strict and open, so full derivatives at endpoints are available. Continuous derivatives on the compact interval supply the integrability obligation. There is no need to weaken this to a within-derivative or omit endpoint hypotheses.

The rational checker still needs a proved semantics for its interval arithmetic and an analytic enclosure theorem for the exact function f. For Taylor or Euler-Maclaurin data, that includes coefficient identities, remainder bounds, and the value at removable singularities. None of those facts follows from successful external Arb execution. The proof above completes the paper argument after those enclosure assertions are established; it does not certify them.

## 8. Review status

The independent reviewer checked the two-case edge argument and its half-open signs before this note was written. The reviewer specifically requested the degenerate-edge and derivative-integrability cases, which are included above. That preliminary feedback is not a completed independent audit of this frozen note. The note is ready for that review. No Lean theorem is claimed proved by this document.
