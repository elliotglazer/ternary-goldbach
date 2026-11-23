# Independent review of the modular-xi rectangle adapter

2026-11-11. **PASS at the exact-rational adapter and reviewed-paper level.** No correction is needed. This is a consequence of the previously accepted external whole-disk enclosure, not a new analytic computation or a Lean theorem. No producer, dependency, canonical source, or frozen package was changed.

## Frozen inputs

All paths in this table are relative to `work/qrh-campaign/agents`. The independent script checks the three adapter hashes and the disk receipt, then all six dependency hashes recorded in the adapter receipt.

| Artifact | SHA256 |
|---|---|
| `mellin/PRINCIPAL_MODULAR_RECTANGLE_ADAPTER_2026-11-11.md` | `3ACC47F6948ADE678D9F615D8701E3C51C818B381C12338BC8AADB709E51D89C` |
| `mellin/principal_modular_rectangle_adapter_20261111.py` | `7014C0E7DB233524A76712A1728894F2B39738BB8A01DB641D2ADC2372A61AE4` |
| `mellin/principal_modular_rectangle_adapter_20261111.json` | `1F5A102C1D5BAB8C29F3B33CE5F587534C6A72A7C3FAD34F5DBA8C900DDC590E` |
| `prime-estimates/principal_modular_xi_panel_pilot_20261111.json` | `0B01EC0CA4A0102816CFB22DE51AE5751975288AC1544F5ABBABCA84BF4A8608` |
| `independent-feasibility/REVIEW_PRINCIPAL_MODULAR_XI_PANEL_PILOT_2026-11-11.md` | `0A9D6BB382FC0C12D228C9DE892EE9EE3E956ECA72BA3E7851FCF90AC2DCE836` |
| `major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md` | `21ACEA6753546CB2D22E8BE2949FA02A3D6A030B21960C6A024731514F09E08B` |
| `independent-feasibility/REVIEW_POLYGON_CROSSING_PROOF_2026-11-11.md` | `F75647007C294E13132B984A0F6241B516D5113D789AECA922B4DA265A5E73F0` |

## Independent arithmetic and geometry

I read the adapter and wrote a separate standard-library Fraction checker, without importing or executing the producer. It recomputes all thirteen coefficient-error sums, their radius-weighted sum, and the exact Cauchy tail `40121785/387381625547900583936`. It additionally bounds every nonconstant rational coefficient norm by a fresh upward integer-square-root rounding at denominator `2^256`. The resulting weighted variation is no larger than the saved variation bound. This checks the use of the full disk-image radius, rather than incorrectly substituting the center error alone.

For the exact saved constant coefficient v and image radius R0, the checks give

`Re(v)>159/10`, `0<=R0<9/5`, and `Re(v)-R0>141/10`.

Thus the accepted enclosure `|F_b(s)-v|<=R0` proves `Re(F_b(s))>141/10` at every point of the requested rectangle.

The printed endpoints are exactly `3/5 +/- 1/128` and `14 +/- 1/128`. Every point of the closed rectangle therefore satisfies `|s-(3/5+14i)|^2<=1/8192<1/4096=(1/64)^2`. This is a componentwise bound on the entire rectangle, not a sample-based inference. The four affine panels run bottom rightwards, right upwards, top leftwards, and left downwards. Their side vectors are respectively `1/64`, `i/64`, `-1/64`, and `-i/64`; their signed twice-area is `1/2048`. They traverse the boundary exactly once, counterclockwise, with no gaps.

All four rotations are exactly 1. All five stored image vertices equal the same rational v, with strictly positive real part. Each determinant is zero, both strict crossing clauses fail, and the exact crossing sum is zero. The independent checker compares every saved input endpoint, rotation, image endpoint, and crossing with these recomputed quantities.

## Why the constant image polygon is admissible

The accepted polygon proof's section 1 requires shared rational vertices in the relevant strict half-planes; it does not require their equality to actual function values. Section 2.3 explicitly includes zero-length image edges. Section 4 proves the transfer by logarithms on those half-planes and cancellation of connector terms at shared vertices. Here every half-plane is the same right half-plane, so its hypotheses hold immediately from the disk bound. There is no need for an unsupported based-homotopy or an equality `v=F_b(z_j)`.

The actual input rectangle is nondegenerate even though the surrogate image polygon is constant. Indeed, in this case the whole-image right-half-plane bound already proves nonvanishing directly. The polygon argument is a valid instantiation of the reusable contract, not evidence of a larger zero-free region.

## Actual source and zero-count transfer

I re-read `Explicit/RectResidue.lean:360` and `:391` and `Explicit/Xi.lean:18–57` in the pinned target tree. Their file hashes are:

| Source | SHA256 |
|---|---|
| `Explicit/RectResidue.lean` | `6B9C3236C2B4470AA37D3948DAB163573A1A7AFDDE8E963EF127F815EB0B88CF` |
| `Explicit/Xi.lean` | `988EDFBCA182F1A7618C88A6EA9B253BFEFEBFA3DA86C3CDC74F5DAC19523D1F` |

`NoZerosOnSides` uses closed intervals, so the strict real-part bound supplies corners as well as open sides. `rectInt_logDeriv_mul` requires an entire function, positive auxiliary radius, a nonzero value at its center, strict rectangle inequalities, inclusion in the open ball of half that radius, and a holomorphic test function near the rectangle. The proposed choices `c=z0`, `R_arg=33/16`, `h=1`, `U=univ` meet all of these: `|s-z0|<=1/32<33/32=R_arg/2`, and the center value is nonzero by the same real-part bound.

The function is the fixed entire function `F_b(s)=exp(-i*b*(s-1/2))*xiF(s)`, with `b=pi/4-1/33` throughout. The source xiF is unhalved. Its exponential multiplier is analytic and never zero, so local zero orders and zero sets agree with xiF. The source argument principle sums actual finite analytic multiplicities over interior zeros; entirety and a nonzero center exclude an identically-zero function and infinite local order. A zero sum of positive zero orders excludes interior zeros. Boundary nonvanishing then gives the closed-rectangle assertion.

Finally `0<379/640<389/640<1`, so the source `xiF_eq_zero_iff` transfers nonvanishing to `riemannZeta` on this rectangle. No pole, real-axis zero, or zero-at-zero convention enters this region. This source reading does not claim a new compiled declaration or a fresh axiom audit.

## Reproducible result and limits

The independent checker exited 0:

| Review artifact | SHA256 |
|---|---|
| `audit/review_principal_modular_rectangle_20261111.py` | `1881AC3691848FCB26819E3CDDEE4F42251FBBE0DDE13AE8AA2D7CDE314712CC` |
| `audit/review_principal_modular_rectangle_20261111.json` | `3722E286EF2F012108257968BAAC4EA46A3FF3D0EAA0CEFA7CB3AB0EB8FF053B` |

The accepted conclusion is nonvanishing of actual F_b, xiF, and zeta throughout `[379/640,389/640]+i*[1791/128,1793/128]`, conditional only on the previously reviewed disk enclosure and its stated external arithmetic trust boundary. No new numerical analytic evaluation was performed. This does not establish a height interval, a principal strip certificate, any conductor-family coverage, or a Lean-checked result. Formalizing the accepted analytic enclosure, exact checker, polygon transfer, and source instantiation remains work to do.
