# Independent review of the local high-slab reciprocal bound

2026-11-11. **PASS as a conditional paper corollary.** No mathematical correction is required. This review neither replaces the independent numerical review nor asserts a Lean theorem. No function values, models, integrals or builds were computed.

## Frozen input

Reviewed `mellin/HIGH_SLAB_RECIPROCAL_CONDITIONING_2026-11-11.md`, SHA256 `14E1D33964DB5098C7D07984DE849BCC3B88D55E00CF08EA1C0345D52C775D6B`.

The exact region is the closed rectangle

`Q=[629/1250,2]+i*[1000000-1/8,1000000]`.

The note requires two proved inputs for actual zeta: closed zero exclusion on Q, and a finite boundary panel cover with unit rotations u satisfying `Re(u*zeta)>3/20` throughout each panel. They are intermediate obligations to discharge, not additional final Goldbach hypotheses. The source adapter remains `mellin/HIGH_SLAB_ZETA_SOURCE_ADAPTER_2026-11-11.md`, SHA256 `C9C4CD0156CA987D5200DA3F4AACCF3C8F1B64BD0FEADCC3F6F12F5F10ED9ED5`.

## Independent proof audit

1. Both side lengths of Q are positive. Thus its interior U is a bounded open rectangle, its closure is Q, and its frontier is exactly the four closed sides. That frontier is nonempty and compact. The finite cover includes corners and joins, so no endpoint is omitted.
2. The entire source function zetaF divided by s-1 identifies actual zeta on an open neighborhood of Q, because this rectangle is far from the pole. Intersect that neighborhood with the open set where zeta is nonzero. Closed zero exclusion ensures that the resulting open set still contains every point of Q. The reciprocal is holomorphic there and continuous on Q. This does not require zeta or its reciprocal to be globally entire. Compactness could supply an unspecified positive neighborhood thickness; no explicit thickness is claimed.
3. On a boundary panel, `|zeta|=|u*zeta|>=Re(u*zeta)>3/20`. Therefore the reciprocal norm is strictly below 20/3 at every boundary point. Variable panel rotations cause no problem: only the modulus is used.
4. Continuity and compactness give a boundary point attaining the reciprocal's maximum M. At that point the strict inequality gives `M<20/3`. This attainment argument preserves strictness; applying maximum modulus directly with the constant 20/3 would supply only a weak bound.
5. The maximum-modulus principle gives `|1/zeta(s)|<=M` for every s in the closure of U, including its boundary. This also covers a constant reciprocal. Combining with the strict inequality for M gives `|1/zeta(s)|<20/3` throughout Q. Nonvanishing and the identity `|1/zeta|=1/|zeta|` then give `|zeta(s)|>3/20`.

I read the cited source signature `Complex.norm_le_of_forall_mem_frontier_norm_le` in `Mathlib/Analysis/Complex/AbsMax.lean:404` and verified the file SHA256 `4240A1997FE901152346C84478761A54D52D9F520D96BB20D840BF2D3F34F5E8`. It requires bounded U, `DiffContOnCl` on U, a weak norm bound on its frontier, and membership in its closure. The preceding construction supplies exactly these hypotheses. No unmentioned global differentiability or integrability assumption is necessary.

## Saved numerical premise inspection

Separately, I read and hashed the completed independent receipt `independent-feasibility/high_slab_independent_replay_20261111_01.json`, SHA256 `407D74A56EEEA8DE3483B3D8E31ED4FFA4A5895ACB262A8632F7EF74BD003C2E`. It records all 13 fresh models, all 14 consumed panels and winding zero. For each saved rational margin n/d, I checked d>0 and the exact integer inequality `20*n-3*d>0`; all fourteen pass. The smallest saved margin is panel 12's

`27705752783371153338760490306785725667581690417 / 182687704666362864775460604089535377456991567872`.

The rotations include both 1 and -i. The right side uses the analytic 1/4 bound. Thus the reported margins have the form needed by the corollary; they are not all positive-real bounds. These are read-only comparisons of previously computed rational data, not a new evaluator run or independent revalidation of EM arithmetic. The final numerical review was still being frozen when this corollary review was written; acceptance of its numerical and zero-exclusion premises remains a separate gate.

## Scope

The result is actual local conditioning evidence once those two premises are accepted: a reciprocal bound on this same closed, one-eighth-high slab at the million-height endpoint. It gives no bound elsewhere in the principal strip, no conductor-family result, no uniform production margin, and no claim that a neighboring slab will pass. It does not itself finish the local winding adapter or a verified interval checker in Lean. The producer's conditional wording accurately preserves these limits.
