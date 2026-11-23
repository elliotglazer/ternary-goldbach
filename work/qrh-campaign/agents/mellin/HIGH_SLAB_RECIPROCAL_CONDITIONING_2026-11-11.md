# Reciprocal conditioning on the closed high zeta slab

2026-11-11. Paper corollary only. This note does not accept the pending numerical review, compute values, or extend the certified region.

Let T=1000000 and let

`Q=[629/1250,2]+i*[T-1/8,T]`, with `U=interior(Q)`.

Assume the following two results have been established for actual `riemannZeta`:

1. The whole closed rectangle Q is zero-free, using the local zeta winding identity and its transfer to entire zetaF.
2. Its four closed boundary sides have a finite panel cover. On every panel there is a unit complex multiplier u such that `Re(u*zeta(s))>3/20` for every point of that panel. The multiplier may differ between panels.

These are conditional inputs to this corollary, not new allowed assumptions in the Goldbach theorem. The producer and independent numerical review must supply them from the actual enclosures and winding calculation.

Then, for every s in Q,

`|zeta(s)|>3/20` and `|1/zeta(s)|<20/3`.

## Proof, including strictness

For each boundary point s, choose a covering panel. Since its multiplier has modulus one,

`3/20<Re(u*zeta(s))<=|u*zeta(s)|=|zeta(s)|`.

Consequently the reciprocal g(s)=1/zeta(s) satisfies `|g(s)|<20/3` on the entire boundary, including all corners and panel endpoints.

The pole 1 is outside Q. Zeta is holomorphic on an open neighborhood of Q. Its assumed nonvanishing on Q makes g holomorphic on a possibly smaller open neighborhood of Q. Explicitly, at each point of Q, continuity gives an open neighborhood avoiding both the pole and the zero set. Their union is such an open neighborhood. Compactness of Q also permits a positive, unspecified neighborhood thickness if needed; this argument supplies no numerical thickness or conditioning bound outside Q.

The boundary of Q is nonempty and compact. The continuous real-valued function `|g|` therefore attains a maximum M there. At a maximizing point the strict boundary estimate gives `M<20/3`. This step is essential: merely applying the non-strict maximum-modulus theorem with constant 20/3 would prove only a non-strict interior bound.

Apply maximum modulus on bounded U to g with boundary bound M. Because `closure U=Q` and `frontier U=boundary Q`, it gives `|g(s)|<=M<20/3` for every s in Q. Since zeta(s) is nonzero there and `|g(s)|=1/|zeta(s)|`, taking reciprocals gives `|zeta(s)|>3/20`.

No common choice of u is needed. The conclusion concerns modulus; it does not assert `Re(zeta)>3/20` inside Q when the boundary panels use different rotations.

## Source interface and scope

The preceding zero-free adapter is [HIGH_SLAB_ZETA_SOURCE_ADAPTER_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/mellin/HIGH_SLAB_ZETA_SOURCE_ADAPTER_2026-11-11.md), SHA256 `C9C4CD0156CA987D5200DA3F4AACCF3C8F1B64BD0FEADCC3F6F12F5F10ED9ED5`. It uses the source `zetaF_of_ne` and `differentiable_zetaF`, and explicitly leaves the local polygon/product-integral bridge to be proved. This conditioning argument does not bypass that zero-free step.

The directly applicable Mathlib theorem is [Complex.norm_le_of_forall_mem_frontier_norm_le](C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib/Analysis/Complex/AbsMax.lean:404). Its hypotheses are `IsBounded U`, `DiffContOnCl` for g on U, a non-strict norm bound on `frontier U`, and membership in `closure U`. Holomorphy of g on a neighborhood of Q supplies the differentiability and continuity hypotheses. The inspected source file has SHA256 `4240A1997FE901152346C84478761A54D52D9F520D96BB20D840BF2D3F34F5E8`.

This corollary uses no integral, so it needs no integrability premise. If the preceding winding proof integrates g or zeta'/zeta along sides, local holomorphy and nonvanishing give continuous parametrized integrands on compact real intervals, hence interval integrability. A bare numerical integral inequality would not substitute for that continuity argument.

All conclusions are on the same closed Q, including the top height T and bottom height T-1/8. There is no claim of global reciprocal holomorphy, a bound throughout all heights up to T, a new zero-count identity, or a Lean-checked theorem. The quantitative boundary input remains conditional pending its final numerical review.
