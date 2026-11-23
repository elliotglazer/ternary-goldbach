# Independent review: block-local inverse cover

2026-11-11. **PASS at paper/source scope; no mathematical correction required.** This review binds `mellin/BLOCK_LOCAL_INVERSE_COVER_2026-11-11.md` at SHA256 `12DBF3F0AD5F56582C1337F3EAD4239C1013BA379C005E98B8F61A6F4FD55491`.

The local maximum-modulus theorem, finite closed cover, counterexample to unrelated panel candidates, and conditional cost statements are sound. The note does not establish a uniform spectral margin, a successful candidate for each slab, or a production complexity bound. No numerical evaluation, fitting, finite spectral scan, or Lean build was performed for this review. No author file was changed.

## Source evidence read

Paths below are relative to the repository except the installed Mathlib paths.

| Source | SHA256 |
|---|---|
| `work/qrh-campaign/agents/zero-sum/GLOBAL_INVERSE_SCALING_LIMITS_2026-11-11.md` | `DDAA08056E5159790D4E7C58BBF7F028538E1C885CF5E8A1E8D0CA0EF4C6C141` |
| `work/qrh-campaign/agents/major-constants/FAMILY_STRIP_SLAB_ASSEMBLY_2026-11-11.md` | `5064865E9CE249A896B6B083278938E0E77762B88DE4539E038E624AC011FF93` |
| `work/qrh-campaign/agents/zero-sum/FAMILY_PRODUCT_CERTIFICATION_FEASIBILITY_2026-11-11.md` | `B701615E4D93727BF7A2C290C41F94EDEB40C0E9FE2BCFAB4A725CB6AC4B8973` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/LGrowth.lean` | `5E6BD327045A95842498DD35DA4D4CA476D7DF37275EA612CD4FA46D2273C341` |
| Mathlib `Analysis/Complex/AbsMax.lean` | `4240A1997FE901152346C84478761A54D52D9F520D96BB20D840BF2D3F34F5E8` |
| Mathlib `NumberTheory/LSeries/DirichletContinuation.lean` | `ECF79F2A64EF2E7215729EBB2E7D5ADAA03468B18BBDA0040680AA925D4673F1` |

Mathlib source root is the existing pinned package at `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib`. This is source inspection, not an elaboration or axiom audit of a new theorem.

## 1. Local theorem and its hypotheses

For a nondegenerate closed rectangle Q and residual R=1-fB, the stated holomorphy of f and B on a neighborhood of Q gives continuity on Q and complex differentiability on its interior. For the bounded open interior U, `closure U=Q` and its frontier is the four **closed** sides. Thus the exact hypotheses of `Complex.norm_le_of_forall_mem_frontier_norm_le` at `AbsMax.lean:404` are met after the elementary rectangle adapters. The source theorem takes boundedness, `DiffContOnCl`, the full frontier bound, and membership in the closure; it does not require an already known inverse.

The resulting `|R|<=q<1` throughout Q rules out f=0, because that would make R=1. It also implies `|fB|>=1-q>0`. The argument covers the boundary as well as the interior. A pole-free boundary alone would not be enough for B: the requirement that its poles lie outside the whole Q is essential and is explicitly retained.

A finite rational pole list disjoint from compact Q has positive separation and therefore supplies a pole-free neighborhood. The simpler clearance `a-1/2>0` is valid for poles on the line Re=1/2 and Q's left edge Re=a. Different panel bounds are harmless only when they bound this **same R**; a finite maximum remains below one. The note correctly distinguishes this from sampling pointwise values without a whole-panel certificate.

## 2. All characters, seams, and inclusive heights

The cover theorem is a direct implication for each actual f_chi: membership in a certified closed rectangle supplies nonvanishing at that point. It neither glues the candidates B nor adds zero counts. Therefore different B on different complete slabs and positive-area overlaps are legitimate. Gaps are not.

The closed partition argument includes internal horizontal/vertical seams, corners, the real axis, and the two outer height edges. Equality with Hcert is sufficient if that boundary is certified; the stricter T>Hcert protocol is a convenient stronger condition, not a mathematical necessity. A finite common-grid coverage test is sound when it checks closed elementary cells and all required target boundary coordinates.

The note retains exact character completeness and function identity. Source `DirichletCharacter.differentiable_LFunction` applies to chi!=1, so it supports the primitive nonprincipal family. It does not silently include principal zeta across its pole. The conductor-one entire/pole-removed function and its zero equivalence remain separate obligations.

Using only nonnegative heights requires the inverse-character conjugation identity and the positive-height certificate for the inverse character. One cannot replace that by the same positive-height packet for a nonreal character. The real-axis seam is still included. Functional-equation reflection for a lower real-part bound is not treated as automatic: its source factors and conditions remain explicit.

Excluding zeros on `[111/200,2]` forbids equality at the left edge and is stronger than a target allowing beta=111/200. The note states this correctly. It also does not infer coverage of unrelated real parts merely from the slab geometry.

## 3. Aggregate tests and the counterexample

An l1 bound on the group coefficients gives the scalar residual bound only after the stated transform/source identification. A moment bound `sum |R_chi|^(2k)<=q<1`, with k>=1, also gives each scalar modulus below one. Nonnegativity of the moment forces q>=0 wherever such a bound is feasible. Finite panel-dependent exponents and bounds can be converted to finitely many scalar bounds below one; no numerical root extraction is logically necessary.

Maximum modulus is applied to the holomorphic scalar residuals, not to the nonholomorphic norm or moment. The note says so. It still requires the same candidate across the whole boundary of each slab.

The counterexample is exact: for f(z)=z on the square [-1,1]+i[-1,1], every length-1/2 side panel has midpoint m with |m|>=1. The constant candidate 1/m is entire and has residual at most `(1/4)/|m|<=1/4` on its entire closed panel. There are sixteen such panels, while f(0)=0. Therefore unrelated panel residuals cannot be used as though they belonged to one global residual. Poles, approximate arithmetic, or seam omissions are not responsible for the failure.

## 4. Conditional cost model versus the global model

For positive pole spacing and nonnegative padding, the count `floor((ell+2p)/delta_p)+1` is a valid upper bound for points of a fixed arithmetic grid in a closed interval of length ell+2p. It does not imply useful approximation at that spacing. The stated fitting matrix, right-hand-side, coefficient-storage, and inverse-jet accumulation counts match the global note's literal loops after replacing global P,J by local P_j,J_j and summing over slabs.

The mesh count `2 ceil(ell/h_y)+2 ceil(W/h_x)` is the count of the stated initial equal/maximum-size subdivision. An arbitrarily over-subdivided mesh satisfying only the same size upper bounds can have more panels; the author's separate refinement term accounts for that. This is an interpretation of the described construction, not a claimed bound for every possible mesh.

The O(nT) conclusion is explicitly conditional on bounded local sizes, padding, reciprocal spacing, degrees, sample/model counts and numerical costs, together with O(T) slabs. It is not derived from locality alone. Streaming reduces peak matrix storage; durable coefficient storage can remain O(nT), and the dense solver remains a separate cost function. The note retains both high ordinate U_j and family dimensions n and v in the evaluator terms. It therefore does not contradict or evade the global scaling note's cost obstruction.

## 5. Growth, candidate norms, and the missing margin

The source `TernaryGoldbach.Explicit.norm_LFunction_le` has implicit positive modulus via `[NeZero q]`, explicit chi!=1, and Re(s)>0. It gives `(q+1)*|s|/Re(s)`. On radius-1/4 disks about a rectangle with real range [a,2], a>1/4, and heights bounded by U, the real part is at least a-1/4 and `|s|<=U+5/2<U+3`. Thus the stated M is a valid conservative bound for the nonprincipal functions. Cauchy's derivative bound on those disks gives 4M. This argument does not apply unchanged to a principal pole.

For the simple-pole candidate, `B0=|b0|+W/Delta`, `B1=W/Delta^2`, and remainder `W*(rho/Delta)^(d+1)/(Delta-rho)` follow termwise from the geometric expansion with rho<Delta. Therefore `|(1-LB)'|<=M*(4B0+B1)` is valid. Positive residual slack is needed to turn this into a panel-size choice; assigning at most a quarter of the slack each to rounding and variation is safely conservative.

The functions `f_epsilon(s)=s-(a-epsilon)` are zero-free on the closed right rectangle but force `|B(a)|>=(1-q)/epsilon` at any fixed residual bound q<1. This refutes a uniform inverse-norm bound from upper growth and zero exclusion alone. It does not assert that actual L-functions realize this worst case. The note correctly preserves that distinction.

Conditional existence of some rational inverse approximation when f is already zero-free does not establish spectral truth or success of a fixed pole dictionary. A Cauchy construction may choose other poles; it does not justify the fixed vertical grid or a uniform candidate size. No such unjustified consequence is claimed.

## Verdict boundary

The reviewed note establishes a sound **local certificate format plus exact finite-cover implication**, and correctly identifies the global dictionary factor that locality can remove. It supplies no actual complete family of slab certificates, no uniform lower bound, no local success guarantee at production heights, and no verified implementation. Those distinctions are explicit and remain part of this PASS verdict.
