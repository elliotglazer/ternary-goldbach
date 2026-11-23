# One rectangle from the accepted modular xi disk

2026-11-11. **Exact rational adapter completed; independent review pending.** Reusing the accepted whole-disk enclosure proves the four required half-plane assertions and zero polygon crossing count for the closed rectangle below. No new analytic evaluation, node replay, spectral scan, or Lean build was performed. The conclusion remains an external certificate consequence of the reviewed disk mathematics and arithmetic, not a Lean theorem.

## Frozen inputs and exact output region

The accepted disk is centered at `s0=3/5+14i`, with radius `rho=1/64`. Its exact function is

`F_b(s)=exp(-i*b*(s-1/2))*TernaryGoldbach.Explicit.xiF(s)`,
`b=pi/4-1/33`.

This fixed b is used on every side and at every vertex. The following artifacts, relative to `work/qrh-campaign/agents`, are hash-checked by the new script:

| Artifact | SHA256 |
|---|---|
| `prime-estimates/PRINCIPAL_MODULAR_XI_PANEL_PILOT_2026-11-11.md` | `85EDD45B5DEB8E96AEC957AA956E90AEBEC4B9B0C9BE31C7D06FA52DAE6E2D49` |
| `prime-estimates/principal_modular_xi_panel_pilot_20261111.py` | `626A931E23A0B3585C0803D34D920BE759E792B230638BDD0E48155874203416` |
| `prime-estimates/principal_modular_xi_panel_pilot_20261111.json` | `0B01EC0CA4A0102816CFB22DE51AE5751975288AC1544F5ABBABCA84BF4A8608` |
| `independent-feasibility/REVIEW_PRINCIPAL_MODULAR_XI_PANEL_PILOT_2026-11-11.md` | `0A9D6BB382FC0C12D228C9DE892EE9EE3E956ECA72BA3E7851FCF90AC2DCE836` |
| `major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md` | `21ACEA6753546CB2D22E8BE2949FA02A3D6A030B21960C6A024731514F09E08B` |
| `independent-feasibility/REVIEW_POLYGON_CROSSING_PROOF_2026-11-11.md` | `F75647007C294E13132B984A0F6241B516D5113D789AECA922B4DA265A5E73F0` |

The new region is exactly

`R=[379/640,389/640] + i*[1791/128,1793/128]`.

For every s in this **closed** rectangle, both coordinate differences from s0 have absolute value at most 1/128. Hence

`|s-s0|^2 <= 2*(1/128)^2 = 1/8192 < 1/4096 = rho^2`.

This componentwise proof covers every interior point, every side and every corner. It is not a test of four corners used as an unsupported substitute for disk containment.

## Stored center, radius and strict half-plane margin

Let `v=f_hat_0` be the exact rational constant coefficient in the accepted receipt. In its original common denominator, it is

```
v = (1843277217653343489275543797094712454181552681080747118041421904408392729014984
   + 1316132672739156360048179180329900317019728244082165310156331057083895842770928*i)
    / 115792089237316195423570985008687907853269984665640564039457584007913129639936.
```

The denominator is `2^256`. The accepted full-disk enclosure is

`|F_b(s)-v| <= R0`, for `|s-s0|<=rho`,

where R0 is the saved `disk.total_radius_about_constant`, namely the rational sum of `polynomial_variation_upper` and `coefficient_error_plus_remainder`. This adapter reads that exact fraction; it does not reconstruct it from a decimal display. It also verifies the latter error sum from all thirteen saved coefficient errors and the exact Cauchy remainder `D*rho^13/(1-rho)`.

Exact rational comparisons give

`Re(v)>159/10`, `0<=R0<9/5`, and `Re(v)-R0>141/10>0`.

Consequently, for **every** s in R,

`Re(F_b(s)) >= Re(v)-|F_b(s)-v| >= Re(v)-R0 > 141/10`.

The constant coefficient is not claimed to equal the true value at the center or at any corner. It is an exact rational center of a previously accepted enclosure. The same distinction applies to all surrogate image vertices below.

## Four panels and a constant surrogate polygon

Take input vertices in order

```
z0 = 379/640 + (1791/128)*i,
z1 = 389/640 + (1791/128)*i,
z2 = 389/640 + (1793/128)*i,
z3 = 379/640 + (1793/128)*i,
z4 = z0.
```

Each panel is exactly `zj+t*(z(j+1)-zj)`, `0<=t<=1`. The successive vectors are `1/64`, `i/64`, `-1/64`, `-i/64`; thus these four panels partition the boundary once counterclockwise, including all endpoints. The signed twice-area is `1/2048>0`.

Set `u_j=1` for all four panels and set all five rational image vertices equal to v. The whole-panel inequalities above give `Re(u_j F_b(panel_j(t)))>0` for every t. Both rational endpoint vertices also satisfy `Re(u_j v)>0`. Adjacent panels use the identical rational v, not separately rounded copies.

In the accepted crossing convention, each edge `(v,v)` has determinant zero and equal imaginary endpoints, so both strict crossing clauses fail. The four contributions are `0,0,0,0`; their sum is zero. Degenerate **image** edges are explicitly permitted by the polygon proof. The **input** panels are not degenerate. There is no claim that the constant polygon is the actual image of the boundary. The proof transfers their integrals using common half-plane logarithms and connector cancellation; it does not require exact image vertices.

## Actual source argument principle and closed coverage

At the Goldbach pin `23b2d68ca344203d4384e0aff7affa4ec034bef9`, [Xi.lean:18](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Explicit/Xi.lean:18) defines the unhalved xiF, and `differentiable_xiF` proves it entire. Multiplication by the fixed exponential makes F_b entire as well.

The polygon transfer gives

`rectInt (logDeriv F_b) z0 z2 = 2*pi*i*0 = 0`.

[RectResidue.lean:360](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Explicit/RectResidue.lean:360) defines `NoZerosOnSides` using closed real intervals. All four clauses follow from the strict real-part bound, including the corners. To instantiate `rectInt_logDeriv_mul` at line 391, take analytic test function h=1 on U=univ, auxiliary ball center c=z0, and ball parameter `R_arg=33/16`. Since both rectangle side lengths are 1/64,

`|s-z0| <= |Re(s-z0)|+|Im(s-z0)| <= 1/32 < 33/32 = R_arg/2`.

Thus the theorem's strict ball inclusion holds. Its center nonvanishing hypothesis follows from `Re(F_b(z0))>0`, and the real and imaginary rectangle inequalities are strict. The theorem counts zeros strictly inside using `zerosIn` and `(divB ...).toNat`. Entirety and a nonzero center exclude infinite analytic order; an actual zero has positive natural multiplicity. A zero total count therefore excludes every interior zero, while `NoZerosOnSides` supplies the rest of the closed rectangle.

In this example the real-part bound already excludes zeros throughout R directly. The argument-principle step records compatibility with the reusable rectangle/polygon contract rather than supplying a stronger geometric conclusion.

The multiplier `exp(-i*b*(s-1/2))` never vanishes. Therefore F_b and xiF have the same zero set here, and their local analytic orders agree. Since `0<379/640<389/640<1`, [Xi.xiF_eq_zero_iff:55](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Explicit/Xi.lean:55) also transfers the exclusion to actual nontrivial zeta zeros on this rectangle. No pole, zero0 convention or doubled-xi normalization changes this assertion.

## Exact receipt and scope

Run `principal_modular_rectangle_adapter_20261111.py` in this directory, SHA256 `7014C0E7DB233524A76712A1728894F2B39738BB8A01DB641D2ADC2372A61AE4`. It imports only Python's standard library, verifies six frozen hashes, parses the accepted receipt, checks the thirteen-term error sum and Cauchy remainder, and verifies the rational geometry, four rotations, shared image vertices, crossing sum and auxiliary ball. It performs no new theta, Gaussian, zeta, Gamma, exponential or other analytic evaluation. In particular, it does not rerun the 2,049-node producer or its independent numerical review.

The new receipt `principal_modular_rectangle_adapter_20261111.json` has SHA256 `1F5A102C1D5BAB8C29F3B33CE5F587534C6A72A7C3FAD34F5DBA8C900DDC590E`. It stores all vertices, the exact center and disk radius, the exact positive margin, each panel and crossing, and the auxiliary argument-principle geometry.

This result concerns only the displayed rectangle near `3/5+14i`. It neither covers an initial height interval nor certifies a principal strip, family height, global zero count or new sign chain. The accepted disk's elementary interval backend and mathematical identities retain their stated external/paper trust boundary; Lean replay and formal instantiation of the polygon adapter remain open. All producer and review artifacts were left unchanged.
